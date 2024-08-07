import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/core/constants/colors.dart';
import 'package:socialmedia/core/constants/text_styles.dart';
import 'package:socialmedia/presentation/home_screen/controller/home_controller.dart';

class PostStoryScreen extends StatefulWidget {
  const PostStoryScreen({super.key});

  @override
  State<PostStoryScreen> createState() => _PostStoryScreenState();
}

class _PostStoryScreenState extends State<PostStoryScreen> {
  File? image;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text("Create Story"),
        titleTextStyle: GLTextStyles.ralewayStyl(weight: FontWeight.w700, size: 22, color: ColorTheme.blue),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    minWidth: size.width * .3,
                    height: size.height * .07,
                    onPressed: () {},
                    child: TextButton.icon(
                      onPressed: () => _getImage(ImageSource.camera),
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        color: ColorTheme.blue,
                      ),
                      label: Text(
                        "Camera",
                        style: GLTextStyles.leagueSpartan(size: 16, color: ColorTheme.yellow),
                      ),
                    ),
                  ),
                  // MaterialButton(
                  //   minWidth: size.width * .3,
                  //   height: size.height * .07,
                  //   onPressed: () {},
                  //   child: TextButton.icon(
                  //     onPressed: () => _getImage(ImageSource.gallery),
                  //     icon: Icon(
                  //       Icons.photo_library_outlined,
                  //       color: ColorTheme.blue,
                  //     ),
                  //     label: Text(
                  //       "Gallery",
                  //       style: GLTextStyles.leagueSpartan(size: 16, color: ColorTheme.yellow),
                  //     ),
                  //   ),
                  // )
                ],
              ),
              if (image != null)
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  margin: EdgeInsets.symmetric(vertical: 20),
                  height: size.height*.5,
                  //width: 200,
                  child: Image.file(
                    image!,
                    fit: BoxFit.cover,
                  ),
                ),
              SizedBox(height: 10),
              MaterialButton(
                  color: ColorTheme.blue,
                  minWidth: size.width * .5,
                  height: size.height * .07,
                  onPressed: () {
                    Provider.of<HomeController>(context, listen: false).onCreateStory(
                      context,
                      image,
                    );
                  },
                  child: Text(
                    "Upload",
                    style: GLTextStyles.leagueSpartan(size: 18, color: ColorTheme.yellow),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
