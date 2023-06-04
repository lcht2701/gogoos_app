import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gogoos_app/models/recipe.dart';
import 'package:gogoos_app/views/utils/app_color.dart';

import 'components/full_screen_image.dart';
import 'components/ingridient_tile.dart';
import 'components/review_tile.dart';
import 'components/step_tile.dart';

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
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/icons/bookmark.svg',
                      color: Colors.white)),
            ],
            systemOverlayStyle: SystemUiOverlayStyle.light,
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
                        minLines: 6,
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
          child: const Icon(Icons.edit),
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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FullScreenImage(
                      image:
                          Image.asset(widget.data.photo, fit: BoxFit.cover))));
            },
            child: Container(
              height: 180,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(widget.data.photo), fit: BoxFit.cover)),
              child: Container(
                decoration: BoxDecoration(gradient: AppColor.linearBlackTop),
                height: 300,
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
                    SvgPicture.asset(
                      'assets/icons/fire-filled.svg',
                      width: 16,
                      height: 16,
                      color: Colors.white,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: Text(
                        widget.data.calories,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.alarm, size: 16, color: Colors.white),
                    Container(
                      margin: const EdgeInsets.only(),
                      child: Text(
                        widget.data.time,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                // Recipe Description
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  // margin: const EdgeInsets.only(right: 250.0),
                  // margin: const EdgeInsetsDirectional.only(end: 150),
                  // padding: const EdgeInsetsDirectional.only(start: .0),
                  // decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.grey.shade600)),
                  child: Text(
                    widget.data.description,
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                        height: 150 / 100),
                  ),
                )
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
              // Ingridients
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: widget.data.ingredients.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return IngridientTile(
                    data: widget.data.ingredients[index],
                  );
                },
              ),
              // Tutorials
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: widget.data.tutorial.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return StepTile(
                    data: widget.data.tutorial[index],
                  );
                },
              ),
              // Reviews
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: widget.data.reviews.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ReviewTile(data: widget.data.reviews[index]);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
