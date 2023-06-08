// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gogoos_app/views/widgets/button.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:gogoos_app/controllers/recipe_controller.dart';

import '../../models/ingredient.dart';
import '../../models/recipe.dart';
import '../../models/tutorial.dart';
import '../widgets/add_recipe_text_field.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddRecipeScreen> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipeScreen> {
  //define variable
  String? _photoUrl;
  late String _title;
  late int _calories;
  late int _time;
  late String _description;
  final List<Ingredient> _ingredients = [];
  final List<Tutorial> _tutorials = [];

  // Define text editing controllers for input fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Ingredients',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(LineAwesomeIcons.plus_circle),
                )
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Cooking Tutorials',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(LineAwesomeIcons.plus_circle),
                )
              ],
            ),
            const SizedBox(height: 16),
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
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }).catchError((error) {
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
                });
              },
              text: 'Save Recipe',
            ),
          ],
        ),
      ),
    );
  }
}
