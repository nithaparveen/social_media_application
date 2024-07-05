import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/app_config/app_config.dart';
import 'package:socialmedia/core/constants/colors.dart';
import 'package:socialmedia/presentation/home_screen/controller/home_controller.dart';
import 'package:socialmedia/presentation/home_screen/view/widgets/post_story_screen.dart';
import 'package:socialmedia/presentation/home_screen/view/widgets/story_view_page.dart';

import '../../../../core/constants/text_styles.dart';


class StorySlider extends StatefulWidget {
  const StorySlider({super.key});



  @override
  State<StorySlider> createState() => _StorySliderState();
}

class _StorySliderState extends State<StorySlider> {
  fetchData() {
    Provider.of<HomeController>(context, listen: false)
        .fetchStories( context);
    Provider.of<HomeController>(context, listen: false)
        .fetchUserStories(context);
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.width * .38,
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
          SizedBox(height: 5),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostStoryScreen(),
                        ));
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
                SizedBox(width: size.width * .01),
                Expanded(
                  child: Consumer<HomeController>(
                    builder: (context, control, _) {
                      bool userHasStory =
                          control.userStoryModel.story != null &&
                              control.userStoryModel.story!.isNotEmpty;
                      return ListView.builder(
                        shrinkWrap: true,
                        // physics: FixedExtentScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: (userHasStory ? 1 : 0) +
                            (control.storyModel.stories?.length ?? 0),
                        itemBuilder: (context, index) {
                          if (index == 0 && userHasStory) {
                            return buildUserStoryItem(
                              context,
                              control,
                              control.userStoryModel.story?[0].author
                                  ?.username ??
                                  "",
                              control.userStoryModel.story?[0].image,
                              control.userStoryModel.story?[0].updatedAt,
                              control.userStoryModel.story?[0].id,  // Pass storyId
                            );
                          } else {
                            int storyIndex = userHasStory ? index - 1 : index;
                            return buildStoryItem(
                              context,
                              control,
                              control.storyModel.stories?[storyIndex].author
                                  ?.username ??
                                  "",
                              control.storyModel.stories?[storyIndex].image,
                              control.storyModel.stories?[storyIndex].updatedAt,
                              control.storyModel.stories?[storyIndex].id,  // Pass storyId
                            );
                          }
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStoryItem(BuildContext context, HomeController control,
      String authorName, String? imageUrl, DateTime? updatedAt, int? storyId) {
    var size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(width: 10),
        Column(
          children: [
            InkWell(
              child: Container(
                height: size.width * .22,
                width: size.width * .14,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorTheme.lightBrown,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: imageUrl == null
                        ? NetworkImage(
                        "https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg")
                        : NetworkImage("${AppConfig.mediaUrl}$imageUrl"),
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StoryView(
                      authorName: authorName,
                      image: '${AppConfig.mediaUrl}$imageUrl',
                      time: DateFormat('hh:mm a')
                          .format(updatedAt ?? DateTime.now())
                          .toString(),
                      isUserStory: false,  // Not a user story
                      storyId: storyId ?? 0,  // Pass storyId
                    ),
                  ),
                );
              },
            ),
            Text(
              authorName,
              style: GLTextStyles.ralewayStyl(size: 14),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildUserStoryItem(BuildContext context, HomeController control,
      String authorName, String? imageUrl, DateTime? updatedAt, int? storyId) {
    var size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(width: 10),
        Column(
          children: [
            InkWell(
              child: Container(
                height: size.width * .22,
                width: size.width * .14,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorTheme.lightBrown,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: imageUrl == null
                        ? NetworkImage(
                        "https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg")
                        : NetworkImage("$imageUrl"),
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StoryView(
                      authorName: authorName,
                      image: '$imageUrl',
                      time: DateFormat('hh:mm a')
                          .format(updatedAt ?? DateTime.now())
                          .toString(),
                      isUserStory: true,  // This is a user story
                      storyId: storyId ?? 0,  // Pass storyId
                    ),
                  ),
                );
              },
            ),
            Text(
              authorName,
              style: GLTextStyles.ralewayStyl(size: 14),
            ),
          ],
        ),
      ],
    );
  }
}
