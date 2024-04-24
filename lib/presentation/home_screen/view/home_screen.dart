import 'package:flutter/material.dart';
import 'package:socialmedia/core/constants/colors.dart';
import 'package:socialmedia/presentation/home_screen/widgets/stories_slider.dart';
import 'package:socialmedia/presentation/message_screen/view/message_screen.dart';

import '../../../core/constants/textstyles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("inThink",style: GLTextStyles.title24c3,),
        // leading: Icon(Icons.camera_alt_outlined),
        centerTitle: true,
        actions: [
          Icon(Icons.notifications),
          SizedBox(width: 15),
          // Icon(Icons.search),
          // SizedBox(width: 10)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text("Feed",style: GLTextStyles.titleBlk23bold,),
            SizedBox(height: 20,),
            StorySlider()
            // StorySlider()
          ],
        ),
      ),
    );
  }
}
