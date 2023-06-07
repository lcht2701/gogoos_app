import 'package:flutter/material.dart';
import 'package:gogoos_app/views/screens/profile_screen.dart';
import 'package:gogoos_app/views/utils/app_color.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';

import '../widgets/all_recipe_tile.dart';
import '../widgets/homescreen_functions.dart';
import '../widgets/homescreen_header.dart';
import '../widgets/top_recipe_card.dart';
import 'add_recipe_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  dynamic selected;
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightColor,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              margin: const EdgeInsets.only(
                top: 40,
                left: 16,
                right: 16,
              ),
              child: Column(
                children: [
                  const HomeScreenHeader(),
                  const SizedBox(height: 14),
                  const HomeScreenFunctions(),
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
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 180,
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 16);
                      },
                      itemBuilder: (context, index) {
                        return const TopRecipeCard();
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
                  const AllRecipesTile(),
                ],
              ),
            ),
          ),
          const SearchScreen(),
          const AddRecipeScreen(),
          const ProfileScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: MoltenBottomNavigationBar(
        selectedIndex: _selectedIndex,
        barColor: AppColor.primaryColor,
        domeCircleColor: AppColor.orangeColor,
        onTabChange: (index) {
          setState(() {
            _pageController.jumpToPage(index);
          });
        },
        tabs: [
          MoltenTab(
            icon: const Icon(LineAwesomeIcons.home),
          ),
          MoltenTab(
            icon: const Icon(LineAwesomeIcons.search),
          ),
          MoltenTab(
            icon: const Icon(LineAwesomeIcons.plus),
          ),
          MoltenTab(
            icon: const Icon(LineAwesomeIcons.sms),
          ),
          MoltenTab(
            icon: const Icon(LineAwesomeIcons.user),
          ),
        ],
      ),
    );
  }
}
