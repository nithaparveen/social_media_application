import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/presentation/home_screen/controller/home_controller_sb.dart';

import '../../../app_config/app_config.dart';
import '../../../core/constants/colors.dart';
import '../../../repository/api/home_screen/model/comments_model.dart';
import '../controller/home_controller.dart';

class CommentScreenSB extends StatefulWidget {
  const CommentScreenSB({super.key, required this.id});
  final int? id;

  @override
  State<CommentScreenSB> createState() => _CommentScreenSBState();
}

class _CommentScreenSBState extends State<CommentScreenSB> {
  fetchData() {
    Provider.of<HomeControllerSB>(context, listen: false).fetchComments(context, widget.id);
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  var commentController = TextEditingController();
   HomeControllerSB homeControllerSB=HomeControllerSB();


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
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
      body: RefreshIndicator(
        onRefresh: () =>
            Provider.of<HomeControllerSB>(context, listen: false).fetchComments(context, widget.id),
        child: StreamBuilder<CommentsModel>(
          stream: homeControllerSB.commentsStream, // Replace with your actual stream
          builder: (context, AsyncSnapshot<CommentsModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error fetching comments"));
            } else if (!snapshot.hasData || snapshot.data?.data == 0) {
              return Center(child: Text("No comments available"));
            } else {
              log("data stream -> ${snapshot.data}");
              return ListView.builder(
                itemCount: snapshot.data?.data?.length,
                itemBuilder: (context, index) {
                  final comment = snapshot.data!.data?[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(comment?.user?.profileImage ?? AppConfig.noImage),
                    ),
                    title: Text(
                      comment?.user?.userName ?? "",
                      style: TextStyle(color: ColorTheme.blue, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      comment?.content ?? "",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                    ),
                  );
                },
              );
            }
          },
        )

        ,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
                height: size.height * .08,
                width: size.width * .75,
                child: TextField(
                  controller: commentController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black, width: .5)),
                  ),
                )),
            SizedBox(
              height: size.height * .08,
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<HomeControllerSB>(context, listen: false)
                      .postComment(widget.id, commentController.text.trim(), context);
                  commentController.clear();
                },
                child: Center(
                  child: Icon(
                    Icons.send_outlined,
                    color: ColorTheme.yellow,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorTheme.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
