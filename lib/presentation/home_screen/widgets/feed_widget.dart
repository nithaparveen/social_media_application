import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';

class FeedWidget extends StatefulWidget {
  //const PostCard({super.key});

  final String? profile_image;
  final String author_name;
  final String created_at;
  final String image;
  final String caption;
  final String location;
  final String? like_count;
  final String comments_count;
  final bool? is_liked;
  final int? post_id;
  final int? author_id;
  final void Function() likePressed;
  final void Function() unlike;
  final void Function() comment;

  FeedWidget({
    this.profile_image,
    required this.author_name,
    this.post_id,
    required this.likePressed,
    required this.unlike,
    required this.comment,
    required this.created_at,
    required this.image,
    required this.caption,
    required this.location,
    this.like_count,
    required this.comments_count,
    this.author_id,
    this.is_liked,
  });

  @override
  State<FeedWidget> createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  var surl = "https://maps.app.goo.gl/yQdJptcDhhyT1naFA";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // var imageUrl = widget.imagePosted == null
    //     ? "https://th.bing.com/th/id/OIP.y6HMdOJ4LiIUWk7n5ZGlpAHaHa?w=480&h=480&rs=1&pid=ImgDetMain"
    //     : AppConfig.mediaurl + widget.imagePosted!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=2788&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                  ),
                ),
                title: Text(
                  "Username",
                  style: GLTextStyles.poppinsStyl(
                      size: size.width * .04, weight: FontWeight.w600),
                ),
                subtitle: GestureDetector(
                  onTap: () {
                    maplaunchURL(surl);
                  },
                  child: Text(
                    "Luminar TechnoHub",
                    style: GLTextStyles.kanitStyl(
                        size: size.width * .035, weight: FontWeight.w300),
                  ),
                ),
                trailing: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                      color: ColorTheme.blue,
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    "Follow",
                    style: TextStyle(color: ColorTheme.white, fontSize: 11),
                  ),
                )),
            Container(
              height: size.width * .75,
              child: Image.network(
                // "https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=2788&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    children: [
                      Container(
                        width: size.width * .05,
                        height: size.width * .05,
                        decoration: BoxDecoration(
                            color: ColorTheme.yellow, shape: BoxShape.circle),
                        child: const Icon(Icons.thumb_up,
                            color: Colors.white, size: 14),
                      ),
                      SizedBox(width: size.width * .02),
                      displayText(label: "202"),
                    ],
                  ),
                  Wrap(
                    children: [
                      displayText(label: "80"),
                      SizedBox(width: size.width * .02),
                      displayText(label: "Comments"),
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                headerButton(
                    buttonText: "Like",
                    buttonIcon: Icons.thumb_up_alt_outlined,
                    buttonAction: () {},
                    buttonColor: ColorTheme.yellow),
                headerButton(
                    buttonText: "Comment",
                    buttonIcon: Icons.message_outlined,
                    buttonAction: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             CommentScreen()));
                    },
                    buttonColor: ColorTheme.yellow),
                headerButton(
                    buttonText: "Share",
                    buttonIcon: Icons.share_outlined,
                    buttonAction: () {},
                    buttonColor: ColorTheme.yellow),
              ],
            )
          ],
        ),
      ),
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

  Widget displayText({required String label}) {
    return Text(
      label == null ? "" : label,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
    );
  }

  Widget footerSection() {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                    color: Colors.orange, shape: BoxShape.circle),
                child:
                    const Icon(Icons.thumb_up, color: Colors.white, size: 14),
              ),
              const SizedBox(
                width: 4,
              ),
              displayText(label: "${widget.like_count}"),
            ],
          ),
          Row(
            children: [
              displayText(label: "${widget.comments_count}"),
              const SizedBox(
                width: 4,
              ),
              displayText(label: "Comments"),
              const SizedBox(
                width: 12,
              ),
              displayText(label: "Bookmarks"),
            ],
          )
        ],
      ),
    );
  }

// Widget imageSection() {
// Widget titleSection() {
//   return widget.descriptionPosted != null && widget.descriptionPosted != ""
//       ? Container(
//           padding: const EdgeInsets.only(bottom: 5),
//           child: Text(
//               widget.descriptionPosted == null
//                   ? ""
//                   : widget.descriptionPosted,
//               style: const TextStyle(color: Colors.black, fontSize: 16)),
//         )
//       : const SizedBox();
// }
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
    // Widget verticalDivider = VerticalDivider(
    //   thickness: 1,
    //   color: Colors.grey[300],
    // );
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
