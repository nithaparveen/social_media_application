import 'package:flutter/material.dart';
import 'package:socialmedia/core/constants/colors.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<String> _messages = [
    "Hey there!",
    "You: Hi! How are you?",
    "I'm doing good, thanks. How about you?",
    "You: I'm great, thanks for asking.",
    "That's good to hear.",
    "Did you watch the game last night?",
    "You: Yeah, it was amazing!",
    "Totally! I couldn't believe that last-minute goal.",
    "You: Yeah, it was unbelievable.",
    "Anyway, gotta go now. Talk to you later!",
    "You: Sure, bye for now!"
  ];

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
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemBuilder: (_, int index) => buildMessage(_messages[index]),
              itemCount: _messages.length,
            ),
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
      setState(() {
        _messages.add('You: $text');
      });
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

  buildMessage(String message) {
    final bool isUserMessage = message.startsWith('You: ');
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
              message,
              style:
                  TextStyle(color: isUserMessage ? Colors.white : Colors.black),
            ),
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
