import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/app_config/app_config.dart';
import 'package:socialmedia/presentation/home_screen/controller/home_controller.dart';

import '../../../core/constants/colors.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key, required this.id});

  final int? id;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  fetchData() {
    Provider.of<HomeController>(context, listen: false).fetchComments(context, widget.id);
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  var commentController = TextEditingController();

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
            Provider.of<HomeController>(context, listen: false).fetchComments(context, widget.id),
        child: Consumer<HomeController>(builder: (context, controller, _) {
          return controller.isLoadingComments
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: controller.commentsModel.data?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(controller
                                      .commentsModel.data?[index].user?.profileImage ==
                                  null
                              ? AppConfig.noImage
                              : "${AppConfig.mediaUrl}${controller.commentsModel.data?[index].user?.profileImage}"),
                        ),
                        title: Text(
                          controller.commentsModel.data?[index].user?.userName ?? "",
                          style: TextStyle(color: ColorTheme.blue, fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          controller.commentsModel.data?[index].content ?? "",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                        ));
                  });
        }),
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
                  Provider.of<HomeController>(context, listen: false)
                      .postComment(widget.id, commentController.text.trim(), context);
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
    // }
    // );
  }
}
