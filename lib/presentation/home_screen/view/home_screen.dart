import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/core/constants/colors.dart';
import 'package:socialmedia/presentation/home_screen/controller/home_controller.dart';
import 'package:socialmedia/presentation/home_screen/widgets/feed_widget.dart';
import 'package:socialmedia/presentation/home_screen/widgets/stories_slider.dart';
import 'package:socialmedia/presentation/message_screen/view/message_screen.dart';
import 'package:socialmedia/presentation/search_screen/view/search_screen.dart';

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
                FeedWidget(size: size)
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

