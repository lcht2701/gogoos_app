// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gogoos_app/views/widgets/button.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:gogoos_app/controllers/recipe_controller.dart';

import '../../models/ingredient.dart';
import '../../models/recipe.dart';
import '../../models/tutorial.dart';
import '../utils/app_color.dart';
import '../widgets/add_recipe_text_field.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddRecipeScreen> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipeScreen> {
  // Define variables
  String? _photoUrl;
  late String _title;
  late int _calories;
  late int _time;
  late String _description;
  final List<Ingredient> _ingredients = [];
  final List<Tutorial> _tutorials = [];
  List<Ingredient> availableIngredients = [];

  // Define text editing controllers for input fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchAvailableIngredients();
  }

  Future<void> _fetchAvailableIngredients() async {
    final ingredients = await RecipeController().getAllIngredients();
    setState(() {
      availableIngredients = ingredients;
    });
  }

  void _showIngredientModal(
    List<Ingredient> availableIngredients,
    Function(Ingredient) onIngredientSelected,
  ) async {
    List<Ingredient> filteredIngredients = List.from(availableIngredients);

    final selectedIngredient = await showModalBottomSheet<Ingredient>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.7,
              minChildSize: 0.4,
              maxChildSize: 0.9,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned(
                        top: 10,
                        child: Container(
                          height: 4,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                top: 30, bottom: 10, left: 20, right: 20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextField(
                              controller: _searchController,
                              cursorColor: AppColor.darkColor,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                  size: 24,
                                ),
                                hintText: 'Search Recipe',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                              ),
                              onChanged: (searchTerm) {
                                setState(() {
                                  filteredIngredients = availableIngredients
                                      .where((ingredient) => ingredient.name
                                          .toLowerCase()
                                          .contains(searchTerm.toLowerCase()))
                                      .toList();
                                });
                              },
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredIngredients.length,
                            itemBuilder: (BuildContext context, int index) {
                              final ingredient = filteredIngredients[index];
                              return ListTile(
                                title: Text(ingredient.name),
                                onTap: () {
                                  Navigator.pop(context, ingredient);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
    if (selectedIngredient != null) {
      onIngredientSelected(selectedIngredient);
    }
  }

  void _showIngredientAmountDialog(Ingredient ingredient,
      Function(Ingredient, int, String) onIngredientAdded) {
    int amount = 0;
    String unit = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          title: Text('Add ${ingredient.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                onChanged: (value) {
                  amount = int.parse(value);
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Unit'),
                onChanged: (value) {
                  unit = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                onIngredientAdded(ingredient, amount, unit);
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showTutorialDialog(Function(Tutorial) onTutorialAdded) {
    String step = '';
    String description = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Tutorial Step'),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Step'),
                onChanged: (value) {
                  step = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  description = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final tutorial =
                    Tutorial(step: step, description: description, id: '');
                onTutorialAdded(tutorial);
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _deleteIngredient(int index) {
    setState(() {
      _ingredients.removeAt(index);
    });
  }

  void _deleteTutorial(int index) {
    setState(() {
      _tutorials.removeAt(index);
    });
  }

  @override
  void dispose() {
    // Dispose the text editing controllers
    _titleController.dispose();
    _caloriesController.dispose();
    _timeController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Add Recipe',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            //Add Image
            GestureDetector(
              onTap: () async {
                _photoUrl = await RecipeController().uploadRecipeImg();
                setState(() {});
              },
              child: Container(
                height: 180,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade300,
                ),
                child: _photoUrl == null
                    ? const Center(
                        child: Icon(
                          LineAwesomeIcons.plus_circle,
                          color: Colors.black,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          _photoUrl!,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
            //Title
            AddRecipeTextField(
              title: 'Title',
              controller: _titleController,
              inputType: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            //Calories
            AddRecipeTextField(
              title: 'Calories',
              controller: _caloriesController,
              inputType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            //Time
            AddRecipeTextField(
              title: 'Time',
              controller: _timeController,
              inputType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            //Description
            AddRecipeTextField(
              title: 'Recipe Description',
              controller: _descriptionController,
              inputType: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            //Add Ingredients
            Container(
              padding: const EdgeInsets.only(left: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Ingredients',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                    onPressed: () {
                      _showIngredientModal(availableIngredients,
                          (selectedIngredient) {
                        _showIngredientAmountDialog(selectedIngredient,
                            (ingredient, amount, unit) {
                          setState(() {
                            final ingredientToAdd = Ingredient(
                              id: ingredient.id,
                              name: ingredient.name,
                              amount: amount,
                              unit: unit,
                            );
                            _ingredients.add(ingredientToAdd);
                          });
                        });
                      });
                    },
                    icon: const Icon(LineAwesomeIcons.plus_circle),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            //Show selected ingredients list
            Column(
              children: _ingredients.asMap().entries.map((entry) {
                final index = entry.key;
                final ingredient = entry.value;
                return ListTile(
                  title: Text(ingredient.name),
                  subtitle: Text(
                      'Amount: ${ingredient.amount}, Unit: ${ingredient.unit}'),
                  trailing: IconButton(
                    onPressed: () {
                      _deleteIngredient(index);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                );
              }).toList(),
            ),
            //Add Step
            Container(
              padding: const EdgeInsets.only(left: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Cooking Tutorials',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  IconButton(
                    onPressed: () {
                      _showTutorialDialog((tutorial) {
                        setState(() {
                          _tutorials.add(tutorial);
                        });
                      });
                    },
                    icon: const Icon(LineAwesomeIcons.plus_circle),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            //Show Tutorials
            Column(
              children: _tutorials.asMap().entries.map((entry) {
                final index = entry.key;
                final tutorial = entry.value;
                return ListTile(
                  title: Text('Step ${tutorial.step}'),
                  subtitle: Text(tutorial.description),
                  trailing: IconButton(
                    onPressed: () {
                      _deleteTutorial(index);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            //Save Recipe
            Mybutton(
              onTap: () {
                _title = _titleController.value.text;
                _calories = int.parse(_caloriesController.value.text);
                _time = int.parse(_timeController.value.text);
                _description = _descriptionController.value.text;
                Recipe newRecipe = Recipe(
                  id: '',
                  title: _title,
                  photoUrl: _photoUrl as String,
                  calories: _calories,
                  time: _time,
                  description: _description,
                  isTopRecipe: false,
                  ingredients: _ingredients,
                  tutorials: _tutorials,
                );
                RecipeController().addRecipe(newRecipe).then((_) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Success'),
                      content: const Text('Recipe created successfully!'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/home');
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                  // Clear input fields
                  _titleController.clear();
                  _caloriesController.clear();
                  _timeController.clear();
                  _descriptionController.clear();
                  _ingredients.clear();
                  _tutorials.clear();
                  setState(() {
                    _photoUrl = null;
                  });
                }).catchError(
                  (error) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Error'),
                        content: Text('Failed to create recipe: $error'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              text: 'Save Recipe',
            ),
          ],
        ),
      ),
    );
  }
}
