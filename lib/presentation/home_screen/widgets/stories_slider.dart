import 'package:flutter/material.dart';

import 'package:socialmedia/core/constants/colors.dart';
import 'package:socialmedia/presentation/home_screen/widgets/post_story_screen.dart';
import 'package:socialmedia/presentation/home_screen/widgets/story_view_page.dart';

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
      height: size.width * .30,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "Feed",
              style: GLTextStyles.ralewayStyl(
                  size: 24, weight: FontWeight.w700, color: ColorTheme.blue),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostStoryScreen(),
                        ),
                        (route) => false);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                    height: size.width * .22,
                    width: size.width * .12,
                    child: Center(
                      child: Icon(
                        Icons.add_a_photo,
                        size: size.width * .065,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * .01,
                ),
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
                              InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorTheme.lightBrown,
                                  ),
                                  height: size.width * .22,
                                  width: size.width * .16,
                                ),
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => StoryView(),
                                      ),
                                      (route) => false);
                                },
                              ),
                              Positioned(
                                left: 8,
                                top: 10,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: size.width * .035,
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
    );
  }
}
