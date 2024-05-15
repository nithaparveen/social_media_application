import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/presentation/login_screen/view/login_screen.dart';

import '../app_config/app_config.dart';
import '../core/constants/colors.dart';
import '../core/constants/text_styles.dart';
import '../presentation/drawer_widgets/privacypolicy.dart';
import '../presentation/drawer_widgets/support.dart';
import '../presentation/drawer_widgets/termsandconditions.dart';
import '../presentation/edit_profile_screen/view/edit_profile_screen.dart';

class DrawerRefactored extends StatefulWidget {
  final String name;
  final String dob;
  final String phone;
  final String location;

  const DrawerRefactored(
      {super.key,
      required this.name,
      required this.dob,
      required this.phone,
      required this.location});

  @override
  State<DrawerRefactored> createState() => _DrawerRefactoredState();
}

class _DrawerRefactoredState extends State<DrawerRefactored> {
  late SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Drawer(
      width: size.width * 0.7,
      child: ListView(padding: EdgeInsets.zero, children: [
        Container(
          height: size.height * .15,
          child: DrawerHeader(
            child: Center(
              child: Text("Settings",
                  style: GLTextStyles.ralewayStyl(
                      color: ColorTheme.blue, size: 22)),
            ),
          ),
        ),
        ListTile(
          title: Row(
            children: [
              Icon(
                Icons.edit_outlined,
                color: ColorTheme.blue,
                size: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Edit Profile',
                style: GLTextStyles.ralewayStyl(color: ColorTheme.brown),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(
                    name: widget.name,
                    dob: widget.dob,
                    phone: widget.phone,
                    location: widget.location,
                  ),
                ));
          },
        ),
        ListTile(
          title: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: ColorTheme.blue,
                size: 20,
              ),
              SizedBox(width: 10),
              Text('Terms & Conditions',
                  style: GLTextStyles.ralewayStyl(color: ColorTheme.brown)),
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TermsAndConditionScreen(),
                ));
          },
        ),
        ListTile(
          title: Row(
            children: [
              Icon(
                Icons.privacy_tip_outlined,
                color: ColorTheme.blue,
                size: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Text('Privacy Policy',
                  style: GLTextStyles.ralewayStyl(color: ColorTheme.brown)),
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PrivacyPolicyScreen(),
                ));
          },
        ),
        ListTile(
          title: Row(
            children: [
              Icon(
                Icons.mail_outline_outlined,
                color: ColorTheme.blue,
                size: 20,
              ),
              SizedBox(width: 10),
              Text('Support',
                  style: GLTextStyles.ralewayStyl(color: ColorTheme.brown)),
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SupportScreen(),
                ));
          },
        ),
        ListTile(
          title: Row(
            children: [
              Icon(
                Icons.logout_outlined,
                color: ColorTheme.blue,
                size: 20,
              ),
              SizedBox(width: 10),
              Text('Logout',
                  style: GLTextStyles.ralewayStyl(color: ColorTheme.brown)),
            ],
          ),
          onTap: () {
            logout();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
                (route) => false);
          },
        ),
      ]),
    );
  }
}

logout() async {
  var sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool(AppConfig.loggedIn, false);
  sharedPreferences.clear();
}
