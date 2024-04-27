import 'package:flutter/material.dart';
import 'package:socialmedia/core/constants/colors.dart';
import 'package:socialmedia/core/constants/text_styles.dart';

import '../../home_screen/widgets/feed_widget.dart';

class PostDataScreen extends StatelessWidget {
  const PostDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
        centerTitle: true,
        titleTextStyle: GLTextStyles.ralewayStyl(
            weight: FontWeight.w700, size: 22, color: ColorTheme.color4),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: size.height * .25,
                  width: size.width * .95,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(5),
                      border: Border.all(width: .65)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      headerButton(
                          buttonText: "Camera",
                          buttonIcon: Icons.camera,
                          buttonAction: () {},
                          buttonColor: ColorTheme.color1),
                      headerButton(
                          buttonText: "Gallery",
                          buttonIcon: Icons.image,
                          buttonAction: () {},
                          buttonColor: ColorTheme.color1),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 280),
                  child: Text(
                    "Caption",
                    style: GLTextStyles.ralewayStyl(color: ColorTheme.color3),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                      border:
                          OutlineInputBorder(borderSide: BorderSide(width: .1))),
                  maxLines: 2,
                ),
                SizedBox(
                  height: 10
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 225),
                  child: Text(
                    "Add a Location",
                    style: GLTextStyles.ralewayStyl(color: ColorTheme.color3),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                      border:
                          OutlineInputBorder(borderSide: BorderSide(width: .1))),
                ),
                SizedBox(
                    height: 60
                ),
                MaterialButton(color: ColorTheme.color4,minWidth: size.width*.5,
                    height: size.height*.07,
                    onPressed: () {},
                    child: Text(
                      "Upload",
                      style: GLTextStyles.leagueSpartan(size:16,color: ColorTheme.color1),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
