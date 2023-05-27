import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogoos_app/views/utils/app_color.dart';
import 'package:gogoos_app/views/widgets/homepage_header.dart';
import 'package:gogoos_app/views/widgets/top_recipe_card.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

import '../widgets/homepage_functions.dart';
import '../widgets/recipe_tile.dart';
import '../widgets/search_with_filter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic selected;
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.only(
            top: 24,
            left: 16,
            right: 16,
          ),
          child: Column(
            children: [
              HomePageHeader(),
              const SizedBox(height: 14),
              SearchWithFilter(),
              const SizedBox(height: 14),
              HomePageFunctions(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Today\'s Top Recipes',
                      style: TextStyle(
                        color: AppColor.darkColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'See All',
                          style: TextStyle(
                            color: AppColor.orangeColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 180,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 16);
                  },
                  itemBuilder: (context, index) {
                    return TopRecipeCard();
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recommended',
                      style: TextStyle(
                        color: AppColor.darkColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'See All',
                        style: TextStyle(
                          color: AppColor.orangeColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListView.separated(
                padding: EdgeInsets.all(8),
                shrinkWrap: true,
                itemCount: 10,
                physics: BouncingScrollPhysics(),
                separatorBuilder: (context, index) {
                  return SizedBox(height: 8);
                },
                itemBuilder: (context, index) {
                  return RecipeTile();
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: StylishBottomBar(
        backgroundColor: AppColor.primaryColor,
        items: [
          BottomBarItem(
            icon: const Icon(
              Icons.house_outlined,
            ),
            selectedIcon: const Icon(Icons.house_rounded),
            // selectedColor: Colors.teal,
            backgroundColor: AppColor.orangeColor,
            title: const Text('Home'),
          ),
          BottomBarItem(
            icon: const Icon(Icons.search),
            backgroundColor: AppColor.orangeColor,
            selectedIcon: const Icon(Icons.search_rounded),
            selectedColor: AppColor.orangeColor,
            // unSelectedColor: Colors.purple,
            // backgroundColor: Colors.orange,
            title: const Text('Search'),
          ),
          BottomBarItem(
              icon: const Icon(
                Icons.message_outlined,
              ),
              selectedIcon: const Icon(
                Icons.message,
              ),
              backgroundColor: AppColor.orangeColor,
              selectedColor: Colors.deepOrangeAccent,
              title: const Text('Style')),
          BottomBarItem(
              icon: const Icon(
                Icons.person_outline,
              ),
              selectedIcon: const Icon(
                Icons.person,
              ),
              backgroundColor: AppColor.orangeColor,
              selectedColor: Colors.deepPurple,
              title: const Text('Profile')),
        ],
        hasNotch: true,
        fabLocation: StylishBarFabLocation.center,
        currentIndex: selected ?? 0,
        onTap: (index) {
          controller.jumpToPage(index);
          setState(() {
            selected = index;
          });
        },
        option: AnimatedBarOptions(
          // iconSize: 32,
          barAnimation: BarAnimation.fade,
          iconStyle: IconStyle.animated,
          // opacity: 0.3,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        backgroundColor: AppColor.orangeColor,
        child: Icon(
          CupertinoIcons.arrow_up,
          color: AppColor.lightColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // body: SafeArea(
      //   child: PageView(
      //     controller: controller,
      //     children: const [
      //       Center(child: Text('Home')),
      //       Center(child: Text('Star')),
      //       Center(child: Text('Style')),
      //       Center(child: Text('Profile')),
      //     ],
      //   ),
      // ),
    );
  }
}
