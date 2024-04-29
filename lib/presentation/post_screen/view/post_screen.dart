import 'package:flutter/material.dart';
import 'package:socialmedia/core/constants/colors.dart';
import 'package:socialmedia/core/constants/text_styles.dart';


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
                        onPressed: (){},
                        icon: Icon(Icons.camera_alt_outlined),
                        label: Text("Camera",style: GLTextStyles.leagueSpartan(
                               size: 16, color: ColorTheme.color1),),
                      )),
                  MaterialButton(
                      minWidth: size.width * .3,
                      height: size.height * .07,
                      onPressed: () {},
                      child: TextButton.icon(
                        onPressed: (){},
                        icon: Icon(Icons.photo_library_outlined),
                        label: Text("Gallery",style: GLTextStyles.leagueSpartan(
                               size: 16, color: ColorTheme.color1),),
                        
                      ))
                ],
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
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(right: 270),
                child: Text(
                  "Location",
                  style: GLTextStyles.ralewayStyl(color: ColorTheme.color3),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: .1))),
              ),
              SizedBox(height: 60),
              MaterialButton(
                  color: ColorTheme.color4,
                  minWidth: size.width * .5,
                  height: size.height * .07,
                  onPressed: () {},
                  child: Text(
                    "Upload",
                    style: GLTextStyles.leagueSpartan(
                        size: 16, color: ColorTheme.color1),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
