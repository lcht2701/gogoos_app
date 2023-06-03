import 'package:flutter/material.dart';
import 'package:gogoos_app/views/screens/user_profile/profile_screen.dart';
import 'package:gogoos_app/views/utils/app_color.dart';
import 'package:gogoos_app/views/widgets/top_recipe_card.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';

import '../../widgets/recipe_tile.dart';
import '../../widgets/search_with_filter.dart';
import 'components/homepage_functions.dart';
import 'components/homepage_header.dart';

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
                top: 32,
                left: 16,
                right: 16,
              ),
              child: Column(
                children: [
                  const HomeScreenHeader(),
                  const SizedBox(height: 14),
                  const SearchWithFilter(),
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
          const ProfileScreen(),
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
            icon: const Icon(Icons.home_outlined),
          ),
          MoltenTab(
            icon: const Icon(Icons.search),
          ),
          MoltenTab(
            icon: const Icon(Icons.chat_bubble_outline),
          ),
          MoltenTab(
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),
    );
  }
}
