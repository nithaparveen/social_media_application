import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmedia/app_config/app_config.dart';
import 'package:socialmedia/core/constants/colors.dart';
import 'package:socialmedia/presentation/chat_screen/controller/chat_controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.id});

  final int id;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late SharedPreferences sharedPreferences;
  var getData;

  getUserName() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var storeData = sharedPreferences.getString(AppConfig.loginData);
    getData = jsonDecode(storeData!);
  }

  @override
  void initState() {
    Provider.of<ChatController>(context, listen: false).fetchChat(context, widget.id);
    getUserName();
    super.initState();
  }

  final TextEditingController _textController = TextEditingController();

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
                  : ListView.builder(
                      padding: EdgeInsets.all(8.0),
                      itemCount: controller.chatModel.data?.length,
                      itemBuilder: (_, int index) {
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
                                child: Text(
                                  controller.chatModel.data?[index].message ?? "",
                                  style: TextStyle(color: isUserMessage ? Colors.white : Colors.black),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
            }),
          ),
          Divider(height: 1.0),
          buildTextComposer(),
        ],
      ),
    );
  }

  void handleSubmitted(String text) {
    if (text.isNotEmpty) {
      _textController.clear();
    }
  }

  buildTextComposer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: handleSubmitted,
              decoration: InputDecoration.collapsed(
                hintText: 'Type a message',
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              size: 20,
            ),
            onPressed: () => handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
