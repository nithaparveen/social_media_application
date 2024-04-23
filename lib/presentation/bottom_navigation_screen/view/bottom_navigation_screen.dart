import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/core/constants/colors.dart';
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
        return Theme(
          data: ThemeData(
            splashColor: Colors.transparent
          ),
          child: BottomNavigationBar(
              currentIndex: controller.selectedIndex,
              onTap: (index) {
                controller.selectedIndex = index;
              },
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: ColorTheme.grey,
              selectedItemColor: ColorTheme.color4,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.message_outlined),
                    activeIcon: Icon(Icons.message),
                    label: "Messages"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.newspaper_outlined),
                    activeIcon:Icon(Icons.newspaper) ,
                    label: "News"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_outlined),
                    activeIcon:Icon(Icons.person) ,
                    label: "Profile")
              ]),
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorTheme.color4,
          child: Icon(Icons.add_photo_alternate,color: ColorTheme.color1,),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MessageScreen()));
          }),
    );
  }
}
