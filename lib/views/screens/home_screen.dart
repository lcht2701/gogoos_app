import 'package:flutter/material.dart';
import 'package:gogoos_app/controllers/admob_controller.dart';
import 'package:gogoos_app/views/screens/community_screen.dart';
import 'package:gogoos_app/views/screens/profile_screen.dart';
import 'package:gogoos_app/views/utils/app_color.dart';
import 'package:gogoos_app/views/widgets/horizontal_button_list.dart';
import 'package:gogoos_app/views/widgets/menu_section.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';

import '../../controllers/user_controller.dart';
import '../../models/role.dart';
import '../widgets/all_recipe_tile.dart';
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
  BannerAd? _banner;
  InterstitialAd? _interstitialAd;
  int _selectedIndex = 0;
  UserRole? _userRole;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _createBannerAd();
    _createInterstitialAd();
    _getCurrentUserRole();
    _pageController = PageController();
  }

  void _getCurrentUserRole() async {
    String? userRole = await UserController().getUserRole();
    if (userRole != null && mounted) {
      setState(() {
        if (userRole == 'Free') {
          _userRole = UserRole.Free;
        } else if (userRole == 'Premium') {
          _userRole = UserRole.Premium;
        } else {
          _userRole = UserRole.Admin;
        }
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  dynamic selected;
  PageController controller = PageController();

  void _createBannerAd() {
    _banner = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdMobController.bannerAdUnitId!,
      listener: AdMobController.bannerAdListener,
      request: const AdRequest(),
    )..load();
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdMobController.interstitialAdUnitId!,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) => _interstitialAd = null,
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null && _userRole == UserRole.Free) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _createInterstitialAd();
        },
      );

      _interstitialAd!.show();
    }
  }

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
          Container(
            margin: const EdgeInsets.only(
              top: 40,
              left: 16,
              right: 16,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const HomeScreenHeader(),
                  const SizedBox(height: 18),
                  const Center(
                    child: HorizontalButtonList(),
                  ),
                  _banner != null &&
                          _userRole != null &&
                          _userRole == UserRole.Free
                      ? Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: _banner?.size.height.toDouble(),
                          width: MediaQuery.of(context).size.width,
                          child: AdWidget(ad: _banner!),
                        )
                      : Container(),
                  MenuSection(
                      leftText: "Today's Top Recipes",
                      textButton: "See All",
                      onPressed: _showInterstitialAd),
                  const SizedBox(height: 8),
                  const SizedBox(
                    height: 190,
                    child: TopRecipeCard(),
                  ),
                  MenuSection(
                      leftText: "Recommended",
                      textButton: "See All",
                      onPressed: _showInterstitialAd),
                  const AllRecipesTile(),
                ],
              ),
            ),
          ),
          const SearchScreen(),
          const AddRecipeScreen(),
          const CommunityScreen(),
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
            icon: const Icon(LineAwesomeIcons.alternate_share),
          ),
          MoltenTab(
            icon: const Icon(LineAwesomeIcons.user),
          ),
        ],
      ),
    );
  }
}
