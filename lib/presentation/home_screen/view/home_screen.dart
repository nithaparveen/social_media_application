import 'package:flutter/material.dart';
import 'package:socialmedia/core/constants/colors.dart';
import 'package:socialmedia/presentation/message_screen/view/message_screen.dart';

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
        title: Text("inThink",style: TextStyle(color: ColorTheme.color3,fontWeight: FontWeight.w600,fontSize: 25 ),),
        leading: Icon(Icons.camera_alt_outlined),
        centerTitle: true,
        actions: [
          Icon(Icons.notifications),
          SizedBox(width: 10),
          Icon(Icons.search),
          SizedBox(width: 10)
        ],
      ),
    );
  }
}
