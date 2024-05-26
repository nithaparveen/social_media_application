import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/core/constants/colors.dart';
import 'package:socialmedia/core/constants/text_styles.dart';
import 'package:socialmedia/presentation/post_screen/controller/post_controller.dart';

class PostDataScreen extends StatefulWidget {
  const PostDataScreen({super.key});

  @override
  State<PostDataScreen> createState() => _PostDataScreenState();
}

class _PostDataScreenState extends State<PostDataScreen> {
  File? image;
  var locationController = TextEditingController();
  var captionController = TextEditingController();

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
        title: Text("Create Post"),
        titleTextStyle: GLTextStyles.ralewayStyl(
            weight: FontWeight.w700, size: 22, color: ColorTheme.blue),
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
                          style: GLTextStyles.leagueSpartan(
                              size: 16, color: ColorTheme.yellow),
                        ),
                      )),
                  MaterialButton(
                      minWidth: size.width * .3,
                      height: size.height * .07,
                      onPressed: () {},
                      child: TextButton.icon(
                        onPressed: () => _getImage(ImageSource.gallery),
                        icon: Icon(
                          Icons.photo_library_outlined,
                          color: ColorTheme.blue,
                        ),
                        label: Text(
                          "Gallery",
                          style: GLTextStyles.leagueSpartan(
                              size: 16, color: ColorTheme.yellow),
                        ),
                      ))
                ],
              ),
              if (image != null)
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  margin: EdgeInsets.symmetric(vertical: 20),
                  height: 150,
                  width: 200,
                  child: Image.file(
                    image!,
                    fit: BoxFit.cover,
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(right: size.width * .78),
                child: Text(
                  "Caption",
                  style: GLTextStyles.ralewayStyl(color: ColorTheme.brown),
                ),
              ),
              TextField(
                controller: captionController,
                decoration: InputDecoration(
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: .1))),
                maxLines: 2,
              ),
              Padding(
                padding: EdgeInsets.only(right: size.width * .75),
                child: Text(
                  "Location",
                  style: GLTextStyles.ralewayStyl(color: ColorTheme.brown),
                ),
              ),
              TextField(
                controller: locationController,
                decoration: InputDecoration(
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: .1))),
              ),
              SizedBox(height: 10),
              MaterialButton(
                  color: ColorTheme.blue,
                  minWidth: size.width * .5,
                  height: size.height * .07,
                  onPressed: () {
                    Provider.of<PostController>(context, listen: false)
                        .onCreatePost(
                            context,
                            image,
                            captionController.text.trim(),
                            locationController.text.trim());
                    captionController.clear();
                    locationController.clear();
                  },
                  child: Text(
                    "Upload",
                    style: GLTextStyles.leagueSpartan(
                        size: 18, color: ColorTheme.yellow),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
