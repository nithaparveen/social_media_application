import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:socialmedia/core/constants/colors.dart';

void main() {
  runApp(MaterialApp(
    home: StorySlider(),
  ));
}

class StorySlider extends StatefulWidget {
  const StorySlider({super.key});

  @override
  State<StorySlider> createState() => _StorySliderState();
}

class _StorySliderState extends State<StorySlider> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorTheme.grey,
                  ),
                  height: size.height * .149,
                  width: size.width * .13,
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
                              width: 15,
                            ),
                            Stack(children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red,
                                ),
                                height: size.height * .149,
                                width: size.width * .29,
                              ),
                              Positioned(
                                left: 12,
                                top: 8,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 17,
                                ),
                              )
                            ]),
                          ],
                        );
                      }),
                )
              ],
            )));
    // ));
  }
}
