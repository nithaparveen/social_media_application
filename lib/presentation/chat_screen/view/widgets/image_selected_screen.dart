import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/presentation/chat_screen/controller/chat_controller.dart';

class ImageSelectedScreen extends StatefulWidget {
  const ImageSelectedScreen({super.key, required this.image, required this.id});

  final File image;
  final int id;

  @override
  State<ImageSelectedScreen> createState() => _ImageSelectedScreenState();
}

class _ImageSelectedScreenState extends State<ImageSelectedScreen> {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close, color: Colors.white)),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: FileImage(widget.image), fit: BoxFit.contain), color: Colors.black),
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                icon: Icon(
                  Icons.send,
                  size: 20,
                ),
                onPressed: () {
                  Provider.of<ChatController>(context, listen: false)
                      .onSendMessage(context, widget.image, textController.text.trim(), widget.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
