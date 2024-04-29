import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:socialmedia/core/constants/colors.dart';
import 'package:socialmedia/core/constants/text_styles.dart';
import 'package:socialmedia/presentation/bottom_navigation_screen/controller/bottom_navigation_controller.dart';
import 'package:socialmedia/presentation/news_screen/view/news_screen.dart';
import 'package:socialmedia/presentation/post_screen/view/post_screen.dart';
import 'package:socialmedia/presentation/profile_screen/view/profile_screen.dart';
import 'package:socialmedia/presentation/search_screen/view/search_screen.dart';

import '../../home_screen/view/home_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Consumer<BottomNavController>(
        builder: (context, provider, child) {
          return IndexedStack(
            index: provider.selectedIndex,
            children: const [
              HomeScreen(),
              PostDataScreen(),
              NewsScreen(),
              ProfileScreen()
            ],
          );
        },
      ),
      bottomNavigationBar:
          Consumer<BottomNavController>(builder: (context, controller, _) {
        return Theme(
          data: ThemeData(splashColor: ColorTheme.brown),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: FlashyTabBar(
                height: 55,
                iconSize: 22,
                selectedIndex: controller.selectedIndex,
                showElevation: true,
                onItemSelected: (index) => setState(() {
                  controller.selectedIndex = index;
                }),
                items: [
                  FlashyTabBarItem(
                    icon: Icon(
                      Icons.home,
                      color: ColorTheme.brown,
                    ),
                    title: Text('Home',
                        style: GLTextStyles.leagueSpartan(
                            size: 16,
                            color: ColorTheme.brown,
                            weight: FontWeight.w500)),
                  ),
                  FlashyTabBarItem(
                    icon: Icon(
                      Icons.add_box_outlined,
                      color: ColorTheme.brown,
                    ),
                    title: Text('Post',
                        style: GLTextStyles.leagueSpartan(
                            size: 16,
                            color: ColorTheme.brown,
                            weight: FontWeight.w500)),
                  ),
                  FlashyTabBarItem(
                    icon: Icon(
                      Icons.newspaper_outlined,
                      color: ColorTheme.brown,
                    ),
                    title: Text('News',
                        style: GLTextStyles.leagueSpartan(
                            size: 16,
                            color: ColorTheme.brown,
                            weight: FontWeight.w500)),
                  ),
                  FlashyTabBarItem(
                    icon: Icon(
                      Icons.person_outlined,
                      color: ColorTheme.brown,
                    ),
                    title: Text('Profile',
                        style: GLTextStyles.leagueSpartan(
                            size: 16,
                            color: ColorTheme.brown,
                            weight: FontWeight.w500)),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
