import 'package:flutter/material.dart';
import 'package:socialmedia/presentation/bottom_navigation_screen/view/bottom_navigation_screen.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../profile_screen/view/profile_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
           },
        ),
        // centerTitle: true,
        titleTextStyle: GLTextStyles.ralewayStyl(
            weight: FontWeight.w700, size: 22, color: ColorTheme.blue),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 55,
                backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=2788&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Edit Photo",
                  style: GLTextStyles.poppinsStyl(
                      color: ColorTheme.brown, size: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 280),
                      child: Text(
                        "Name",
                        style:
                            GLTextStyles.ralewayStyl(color: ColorTheme.brown),
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: .1))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 250),
                      child: Text(
                        "Username",
                        style:
                            GLTextStyles.ralewayStyl(color: ColorTheme.brown),
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: .1))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 250),
                      child: Text(
                        "Password",
                        style:
                            GLTextStyles.ralewayStyl(color: ColorTheme.brown),
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: .1))),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          color: ColorTheme.blue,
                          minWidth: size.width * .4,
                          height: size.height * .07,
                          onPressed: () {},
                          child: Text(
                            "Save Changes",
                            style: GLTextStyles.leagueSpartan(
                                size: 18, color: ColorTheme.yellow),
                          ),
                        ),
                        MaterialButton(
                          color: ColorTheme.blue,
                          minWidth: size.width * .4,
                          height: size.height * .07,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: GLTextStyles.leagueSpartan(
                                size: 18, color: ColorTheme.yellow),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
