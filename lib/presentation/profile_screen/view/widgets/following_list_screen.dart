import 'package:flutter/material.dart';

class FollowingListScreen extends StatefulWidget {
  const FollowingListScreen({super.key});

  @override
  State<FollowingListScreen> createState() => _FollowingListScreenState();
}

class _FollowingListScreenState extends State<FollowingListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Following"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(),
            title: Text(""),
            trailing: ElevatedButton(onPressed: (){}, child: Text("Follow")),
          );
        },
      ),
    );
  }
}
