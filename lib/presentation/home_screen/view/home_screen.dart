import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/core/constants/colors.dart';
import 'package:socialmedia/presentation/home_screen/controller/home_controller.dart';
import 'package:socialmedia/presentation/home_screen/widgets/feed_widget.dart';
import 'package:socialmedia/presentation/home_screen/widgets/stories_slider.dart';
import 'package:socialmedia/presentation/message_screen/view/message_screen.dart';
import 'package:socialmedia/presentation/search_screen/view/search_screen.dart';

import '../../../app_config/app_config.dart';
import '../../../core/constants/text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // bool _isSearchBarVisible = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeController>(context, listen: false).fetchData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ThingShare",
          style: GLTextStyles.leagueSpartan(
              size: 25, weight: FontWeight.w500, color: ColorTheme.brown),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
              // _searchClicked,
              icon: Icon(
                Icons.search,
                color: ColorTheme.brown,
                size: 24,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MessageScreen()));
              },
              icon: Icon(
                Icons.message,
                color: ColorTheme.brown,
                size: 22,
              )),
          SizedBox(width: 10),
          // Icon(Icons.search),
        ],
      ),
      body: Consumer<HomeController>(builder: (context, hcontrol, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // _isSearchBarVisible ? SearchField() :  SizedBox(),
                StorySlider(),
                SizedBox(height: 10),
                ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 10);
                    },
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: hcontrol.homeModel.data!.length,
                    itemBuilder: (context, index) {
                      return Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Column(
                            children: [
                              ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: hcontrol
                                                .homeModel
                                                .data?[index]
                                                .author
                                                ?.profileImage ==
                                            null
                                        ? NetworkImage(
                                            "https://th.bing.com/th/id/OIP.y6HMdOJ4LiIUWk7n5ZGlpAHaHa?w=480&h=480&rs=1&pid=ImgDetMain")
                                        : NetworkImage(
                                            "${AppConfig.mediaUrl}${hcontrol.homeModel.data?[index].author?.profileImage}"),
                                  ),
                                  title: Text(
                                    "${hcontrol.homeModel.data?[index].author?.authorName}",
                                    style: GLTextStyles.poppinsStyl(
                                        size: size.width * .04,
                                        weight: FontWeight.w600),
                                  ),
                                  subtitle: GestureDetector(
                                    onTap: () {
                                      // maplaunchURL(surl);
                                    },
                                    child: Text(
                                      "${hcontrol.homeModel.data?[index].location}",
                                      style: GLTextStyles.kanitStyl(
                                          size: size.width * .035,
                                          weight: FontWeight.w300),
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
                                      style: TextStyle(
                                          color: ColorTheme.white,
                                          fontSize: 11),
                                    ),
                                  )),
                              Container(
                                height: size.width * .75,
                                child: Image.network(
                                  hcontrol.homeModel.data?[index].image == null
                                      ? "https://th.bing.com/th/id/OIP.y6HMdOJ4LiIUWk7n5ZGlpAHaHa?w=480&h=480&rs=1&pid=ImgDetMain"
                                      : "${hcontrol.homeModel.data?[index].image}",
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Wrap(
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
                                        displayText(label: "${hcontrol.homeModel.data?[index].likeCount}"),
                                      ],
                                    ),
                                    Wrap(
                                      children: [
                                        displayText(label: "${hcontrol.homeModel.data?[index].commentsCount}"),
                                        SizedBox(width: size.width * .02),
                                        displayText(label: "Comments"),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  headerButton(
                                      buttonText: "Like",
                                      buttonIcon: hcontrol.homeModel.data?[index].isLiked==true?Icons.thumb_up_alt_sharp:Icons.thumb_up_alt_outlined,
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
                      ));
                    })
              ],
            ),
          ),
        );
      }),
    );
  }

// void _searchClicked() {
//   setState(() {
//     _isSearchBarVisible = !_isSearchBarVisible;
//     log("message");
//   });
// }
}

Widget displayText({required String label}) {
  return Text(
    label.isEmpty ? "" : label,
    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
  );
}
