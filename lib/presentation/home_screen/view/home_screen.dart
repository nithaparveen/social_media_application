import 'package:flutter/material.dart';
import 'package:socialmedia/core/constants/colors.dart';
import 'package:socialmedia/presentation/home_screen/widgets/feed_widget.dart';
import 'package:socialmedia/presentation/home_screen/widgets/stories_slider.dart';
import 'package:socialmedia/presentation/message_screen/view/message_screen.dart';
import 'package:socialmedia/presentation/search_screen/view/search_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var surl = "https://maps.app.goo.gl/yQdJptcDhhyT1naFA";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ThinkShare",
          style: GLTextStyles.leagueSpartan(
              size: 25, weight: FontWeight.w500, color: ColorTheme.brown),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 6,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              StorySlider(),
              SizedBox(
                height: 10,
              ),
              ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Card(
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
                                    size: size.width * .04,
                                    weight: FontWeight.w600),
                              ),
                              subtitle: GestureDetector(
                                onTap: () {
                                  maplaunchURL(surl);
                                },
                                child: Text(
                                  "Luminar TechnoHub",
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
                                      color: ColorTheme.white, fontSize: 11),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    SizedBox(
                                      width: size.width * .02,
                                    ),
                                    displayText(label: "202"),
                                  ],
                                ),
                                Wrap(
                                  children: [
                                    displayText(label: "80"),
                                    SizedBox(
                                      width: size.width * .02,
                                    ),
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
                                  buttonAction: () {},
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
                    );
                  })
            ],
          ),
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
}

Widget displayText({required String label}) {
  return Text(
    label.isEmpty ? "" : label,
    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
  );
}
