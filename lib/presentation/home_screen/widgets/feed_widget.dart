import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:socialmedia/app_config/app_config.dart';
import 'package:socialmedia/presentation/home_screen/widgets/likes_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../controller/home_controller.dart';
import 'comment_screen.dart';

class FeedWidget extends StatelessWidget {
  FeedWidget({
    super.key,
    required this.size,
    this.profile_image,
    required this.author_name,
    required this.created_at,
    required this.image,
    required this.caption,
    required this.location,
    required this.like_count,
    required this.comments_count,
    this.isLiked,
    this.post_id,
    this.author_id,
    required this.likePressed,
    required this.followPressed,
    this.isFollowed,
  });

  final String? profile_image;
  final String author_name;
  final String created_at;
  final String image;
  final String caption;
  final String location;
  final String like_count;
  final String comments_count;
  final bool? isLiked;
  final bool? isFollowed;
  final int? post_id;
  final int? author_id;
  final Size size;
  final Function() likePressed;
  final Function() followPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage(profile_image ?? "${AppConfig.noImage}"),
                ),
                title: Text(
                  author_name,
                  style: GLTextStyles.poppinsStyl(
                      size: size.width * .04, weight: FontWeight.w600),
                ),
                subtitle: GestureDetector(
                  onTap: () {
                    maplaunchURL(
                        "https://www.google.com/maps/place/?q=$location");
                  },
                  child: Text(
                    location,
                    style: GLTextStyles.kanitStyl(
                        size: size.width * .035, weight: FontWeight.w300),
                  ),
                ),
                trailing: InkWell(
                  onTap: followPressed,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                        color: ColorTheme.blue,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      "Unfollow",
                      style: TextStyle(color: ColorTheme.white, fontSize: 11),
                    ),
                  ),
                ),
              ),
              Container(
                height: size.width * .75,
                child: Image.network(image, fit: BoxFit.contain),
              ),
              Text(
                caption,
                style: GLTextStyles.kanitStyl(
                    size: size.width * .04, weight: FontWeight.w400),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LikeScreen(
                              id: post_id,
                            ),
                          )),
                      child: Wrap(
                        children: [
                          Container(
                            width: size.width * .05,
                            height: size.width * .05,
                            decoration: BoxDecoration(
                                color: ColorTheme.yellow,
                                shape: BoxShape.circle),
                            child: const Icon(Icons.thumb_up,
                                color: Colors.white, size: 14),
                          ),
                          SizedBox(width: size.width * .02),
                          displayText(label: "${like_count}"),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommentScreen(id: post_id),
                          )),
                      child: Wrap(
                        children: [
                          displayText(label: "${comments_count}"),
                          SizedBox(width: size.width * .02),
                          displayText(label: "Comments"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  headerButton(
                      buttonText: "Like",
                      buttonIcon: isLiked == true
                          ? Icons.thumb_up_alt_sharp
                          : Icons.thumb_up_alt_outlined,
                      buttonAction: likePressed,
                      buttonColor: ColorTheme.yellow),
                  headerButton(
                      buttonText: "Comment",
                      buttonIcon: Icons.message_outlined,
                      buttonAction: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CommentScreen(id: post_id),
                            ));
                        log("postId -> $post_id");
                      },
                      buttonColor: ColorTheme.yellow),
                  headerButton(
                      buttonText: "Share",
                      buttonIcon: Icons.share_outlined,
                      buttonAction: () {
                        String postToShare = "$author_name \n $image";
                        Provider.of<HomeController>(context, listen: false)
                            .share(toShare: postToShare);
                        // Share.share('');
                      },
                      buttonColor: ColorTheme.yellow),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderButtonSection extends StatelessWidget {
  final Widget buttonOne;
  final Widget buttonTwo;
  final Widget buttonThree;

  const HeaderButtonSection(
      {super.key,
      required this.buttonOne,
      required this.buttonTwo,
      required this.buttonThree});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buttonOne,
          buttonTwo,
          buttonThree,
        ],
      ),
    );
  }
}

Widget headerButton(
    {required String buttonText,
    required IconData buttonIcon,
    required void Function() buttonAction,
    required Color buttonColor}) {
  return TextButton.icon(
      onPressed: buttonAction,
      icon: Icon(
        buttonIcon,
        color: buttonColor,
      ),
      label: Text(
        buttonText,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
      ));
}

Widget displayText({required String label}) {
  return Text(
    label.isEmpty ? "" : label,
    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
  );
}

Future<void> maplaunchURL(url) async {
  final Uri url1 = Uri.parse(url);
  try {
    if (!await launchUrl(url1, mode: LaunchMode.inAppWebView)) {
      await launchUrl(url1, mode: LaunchMode.inAppWebView);
    } else {
      throw 'Could not launch $url';
    }
  } catch (e) {
    print('Error launching URL: $e');
  }
}
