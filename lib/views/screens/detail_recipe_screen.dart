// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gogoos_app/models/recipe.dart';
import 'package:gogoos_app/views/utils/app_color.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../widgets/detail_recipe_description.dart';
import '../widgets/full_screen_image.dart';
import '../widgets/ingredient_tile.dart';
import '../widgets/review_tile.dart';
import '../widgets/tutorial_tile.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe data;
  const RecipeDetailScreen({super.key, required this.data});
  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController(initialScrollOffset: 0.0);
    _scrollController.addListener(() {
      changeAppBarColor(_scrollController);
    });
  }

  Color appBarColor = Colors.transparent;

  changeAppBarColor(ScrollController scrollController) {
    if (scrollController.position.hasPixels) {
      if (scrollController.position.pixels > 2.0) {
        setState(() {
          appBarColor = AppColor.darkColor;
        });
      }
      if (scrollController.position.pixels <= 2.0) {
        setState(() {
          appBarColor = Colors.transparent;
        });
      }
    } else {
      setState(() {
        appBarColor = Colors.transparent;
      });
    }
  }

  // fab to write review
  showFAB(TabController tabController) {
    int reviewTabIndex = 2;
    if (tabController.index == reviewTabIndex) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AnimatedContainer(
          color: appBarColor,
          duration: const Duration(milliseconds: 200),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: const Text('Search Recipe',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
            leading: IconButton(
              icon:
                  const Icon(LineAwesomeIcons.angle_left, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  LineAwesomeIcons.bookmark,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      // Post Review FAB
      floatingActionButton: Visibility(
        visible: showFAB(_tabController),
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      color: Colors.white,
                      child: const TextField(
                        keyboardType: TextInputType.multiline,
                        minLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Write your review here...',
                        ),
                        maxLines: null,
                      ),
                    ),
                    actions: [
                      Row(
                        children: [
                          SizedBox(
                            width: 120,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.grey[600],
                              ),
                              child: const Text('cancel'),
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                //DO SOMETHING
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.orangeSoftColor,
                              ),
                              child: const Text('Post Review'),
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                });
          },
          backgroundColor: AppColor.orangeColor,
          child: const Icon(LineAwesomeIcons.edit),
        ),
      ),
      body: ListView(
        controller: _scrollController,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: [
          // Section 1 - Recipe Image
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      FullScreenImage(image: widget.data.photoUrl),
                ),
              );
            },
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.data.photoUrl),
                      fit: BoxFit.cover)),
              child: Container(
                decoration: BoxDecoration(gradient: AppColor.linearBlackTop),
                height: 280,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),

          // Section 2 - Recipe Info
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            color: AppColor.orangeSoftColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Recipe Title
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(bottom: 5, top: 16),
                  child: Text(
                    widget.data.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // Recipe Calories and Time
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      LineAwesomeIcons.fire,
                      size: 20,
                      color: Colors.white,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: Text(
                        '${widget.data.calories} calories',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      LineAwesomeIcons.stopwatch,
                      size: 20,
                      color: Colors.white,
                    ),
                    Container(
                      margin: const EdgeInsets.only(),
                      child: Text(
                        '${widget.data.time} min',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                // Recipe Description
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: RecipeDescription(
                    description: widget.data.description,
                  ),
                ),
              ],
            ),
          ),

          // Tabbar ( Ingridients, Tutorial, Reviews )
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            color: AppColor.lightColor,
            child: TabBar(
              controller: _tabController,
              onTap: (index) {
                setState(() {
                  _tabController.index = index;
                });
              },
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black.withOpacity(0.6),
              labelStyle: const TextStyle(fontWeight: FontWeight.w500),
              indicatorColor: Colors.black,
              tabs: const [
                Tab(
                  text: 'Ingredients',
                ),
                Tab(
                  text: 'Tutorial',
                ),
                Tab(
                  text: 'Reviews',
                ),
              ],
            ),
          ),
          // IndexedStack based on TabBar index
          IndexedStack(
            index: _tabController.index,
            children: [
              // Ingredients
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: _tabController.index == 0
                    ? widget.data
                        .getIngredientsForRecipeId(widget.data.id)
                        .length
                    : 0,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final ingredients =
                      widget.data.getIngredientsForRecipeId(widget.data.id);
                  return IngredientTile(data: ingredients[index]);
                },
              ),
              // Tutorials
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: _tabController.index == 1
                    ? widget.data.getTutorialsForRecipeId(widget.data.id).length
                    : 0,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final tutorials =
                      widget.data.getTutorialsForRecipeId(widget.data.id);
                  return TutorialTile(data: tutorials[index]);
                },
              ),
              // Reviews
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: _tabController.index == 2
                    ? widget.data.getReviewsForRecipeId(widget.data.id).length
                    : 0,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final reviews =
                      widget.data.getReviewsForRecipeId(widget.data.id);
                  return ReviewTile(data: reviews[index]);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
