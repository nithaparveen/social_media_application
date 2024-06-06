import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/app_config/app_config.dart';
import 'package:socialmedia/core/constants/colors.dart';
import 'package:socialmedia/presentation/chat_screen/view/chat_screen.dart';
import 'package:socialmedia/presentation/message_screen/controller/message_screen_controller.dart';

import '../../../core/constants/text_styles.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  void initState() {
    Provider.of<MessageScreenController>(context, listen: false)
        .fetchMessage(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ThingShare",
          style: GLTextStyles.leagueSpartan(
              size: 25, weight: FontWeight.w500, color: ColorTheme.brown),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
          ),
        ),
      ),
      body:
          Consumer<MessageScreenController>(builder: (context, controller, _) {
        return controller.isLoading
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () =>
                    Provider.of<MessageScreenController>(context, listen: false)
                        .fetchMessage(context),
                child: ListView.separated(
                  itemCount: controller.messageSendersModel.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                id: controller
                                    .messageSendersModel.data![index].id!,
                                name: controller.messageSendersModel
                                        .data?[index].username ??
                                    "",
                              ),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(controller
                                    .messageSendersModel.data?[index].image ??
                                AppConfig.noImage),
                          ),
                          title: Text(
                            controller.messageSendersModel.data?[index]
                                    .username ??
                                "",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ),
              );
      }),
    );
  }
}
