import 'package:flutter/material.dart';
import 'package:socialmedia/core/constants/colors.dart';
import 'package:socialmedia/presentation/home_screen/widgets/feed_widget.dart';
import 'package:socialmedia/presentation/home_screen/widgets/stories_slider.dart';
import 'package:socialmedia/presentation/message_screen/view/message_screen.dart';
import 'package:socialmedia/presentation/search_screen/view/search_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/text_styles.dart';
import '../widgets/comment_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // bool _isSearchBarVisible = false;

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
      body: Padding(
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
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Center(
                      child: FeedWidget(author_name: "username", likePressed: (){}, unlike: (){}, comment: (){}, created_at: "created_at", image: "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", caption: "caption", location: "location", comments_count: "comments_count")
                    );
                  })
            ],
          ),
        ),
      ),
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
