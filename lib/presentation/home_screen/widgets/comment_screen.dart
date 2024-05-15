import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({
    super.key,
    // required this.id
  });

  // final int? id;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  // fetchData() {
  //   Provider.of<FeedPageController>(context, listen: false).fetchComments(widget.id, context);
  // }

  // @override
  // void initState() {
  //   fetchData();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    // return Consumer<FeedPageController>(builder: (context, controller, _) {
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
            )),
      ),
      body: ListView.builder(
          itemCount: 4,
          // controller.commentsModel.data?.length,
          itemBuilder: (context, index) {
            return ListTile(leading: CircleAvatar(), title: Text("amazing")
                // Text(controller.commentsModel.data?[index].text ?? ""),
                );
          }),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: size.width * .02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // SizedBox(width: size.width * .05),
            SizedBox(
                height: size.height * .08,
                width: size.width * .75,
                child: TextField(
                  // maxLines: 6,
                  // controller: textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.black, width: .5)),
                  ),
                )),
            SizedBox(
              height: size.height * .08,
              child: ElevatedButton(
                onPressed: () {},
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
