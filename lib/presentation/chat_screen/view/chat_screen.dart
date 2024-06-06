import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/app_config/app_config.dart';
import 'package:socialmedia/core/constants/colors.dart';
import 'package:socialmedia/presentation/chat_screen/controller/chat_controller.dart';
import 'package:socialmedia/presentation/chat_screen/view/widgets/image_selected_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.id});

  final int id;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late SharedPreferences sharedPreferences;
  ScrollController scrollController = new ScrollController();
  var getData;
  File? image;

  Future<void> getImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ImageSelectedScreen(image: image!, id: widget.id)));
    }
  }

  PlatformFile? file;
  Future<void> pickSingleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      file = result.files.first;
      //file == null ? false : OpenAppFile.open(file!.path.toString());
    }
  }

  getUserName() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var storeData = sharedPreferences.getString(AppConfig.loginData);
    getData = jsonDecode(storeData!);
  }

  @override
  void initState() {
    Provider.of<ChatController>(context, listen: false).fetchChat(context, widget.id);
    getUserName();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 50), () {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
    });
    super.initState();
  }

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
        title: Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ChatController>(builder: (context, controller, _) {
              return controller.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: () =>
                          Provider.of<ChatController>(context, listen: false).fetchChat(context, widget.id),
                      child: ListView.builder(
                        padding: EdgeInsets.all(8.0),
                        itemCount: controller.chatModel.data?.length,
                        controller: scrollController,
                        itemBuilder: (_, index) {
                          final bool isUserMessage =
                              controller.chatModel.data?[index].senderUsername == getData["data"]["username"];
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment:
                                  isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: isUserMessage ? ColorTheme.brown : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Column(
                                    children: [
                                      if (controller.chatModel.data?[index].image != null)
                                        Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: isUserMessage ? ColorTheme.brown : Colors.grey[300],
                                              borderRadius: BorderRadius.circular(8.0),
                                              image: DecorationImage(
                                                  image:
                                                      NetworkImage(controller.chatModel.data?[index].image))),
                                        ),
                                      if (controller.chatModel.data?[index].message != null)
                                        Text(
                                          controller.chatModel.data?[index].message ?? "",
                                          style:
                                              TextStyle(color: isUserMessage ? Colors.white : Colors.black),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
            }),
          ),
          Divider(height: 1.0),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Flexible(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Type a message',
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                    icon: Icon(CupertinoIcons.paperclip)),
                IconButton(
                    onPressed: () =>pickSingleFile(),
                    icon: Icon(CupertinoIcons.doc)),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    size: 20,
                  ),
                  onPressed: () {
                    Provider.of<ChatController>(context, listen: false)
                        .sendMessage(context, textController.text.trim(), widget.id);
                    textController.clear();
                    setState(() {
                      Provider.of<ChatController>(context, listen: false).fetchChat(context, widget.id);
                      scrollController.jumpTo(scrollController.position.maxScrollExtent);
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
