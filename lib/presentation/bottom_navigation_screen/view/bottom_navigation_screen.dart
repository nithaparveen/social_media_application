import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/presentation/bottom_navigation_screen/controller/bottom_navigation_controller.dart';
import 'package:socialmedia/presentation/message_screen/view/message_screen.dart';
import 'package:socialmedia/presentation/news_screen/view/news_screen.dart';
import 'package:socialmedia/presentation/profile_screen/view/profile_screen.dart';

import '../../home_screen/view/home_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BottomNavController>(
        builder: (context, provider, child) {
          return IndexedStack(
            index: provider.selectedIndex,
            children: const [
              HomeScreen(),
              MessageScreen(),
              NewsScreen(),
              ProfileScreen()
            ],
          );
        },
      ),
      bottomNavigationBar:
          Consumer<BottomNavController>(builder: (context, controller, _) {
        return BottomNavigationBar(
            currentIndex: controller.selectedIndex,
            onTap: (index) {
              controller.selectedIndex = index;
            },backgroundColor: Colors.blueAccent,
            elevation: 0,
            type: BottomNavigationBarType.shifting,
            unselectedItemColor: Colors.black54,
            selectedItemColor: Colors.green,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble_rounded), label: "Messages"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.newspaper_rounded), label: "News"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_2_rounded), label: "Profile")
            ]);
      }),
    );
  }
}
