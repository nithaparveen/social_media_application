import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:socialmedia/core/constants/colors.dart';

import '../../../core/constants/text_styles.dart';

class StorySlider extends StatefulWidget {
  const StorySlider({super.key});

  @override
  State<StorySlider> createState() => _StorySliderState();
}

class _StorySliderState extends State<StorySlider> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.width*.45,
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Feed",
              style: GLTextStyles.ralewayStyl(
                  size: 25, weight: FontWeight.w700, color: ColorTheme.color4),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorTheme.grey,
                        ),
                        height: size.width * .30,
                        width: size.width * .15,
                      ),
                      Positioned(
                                  left: 5,
                                  top: 12,
                                  child: Icon(Icons.add_a_photo,size: size.width * .07,)
                                )
                    ],
                  ),
                  SizedBox(width: size.width*.01,),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        // physics: FixedExtentScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Stack(children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.red,
                                  ),
                                  height: size.width * .30,
                                  width: size.width * .29,
                                ),
                                Positioned(
                                  left: 12,
                                  top: 12,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: size.width * .04,
                                  ),
                                )
                              ]),
                            ],
                          );
                        }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
