import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/app_config/app_config.dart';
import 'package:socialmedia/presentation/home_screen/controller/home_controller.dart';

import '../../../../core/constants/colors.dart';


class LikeScreen extends StatefulWidget {
  const LikeScreen({super.key, this.id});

  final int? id;

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  fetchData() {
    Provider.of<HomeController>(context, listen: false)
        .fetchLikes(context, widget.id);
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Likes"),
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
        onRefresh: () => Provider.of<HomeController>(context, listen: false)
            .fetchLikes(context, widget.id),
        child: Consumer<HomeController>(builder: (context, controller, _) {
          return controller.isLoadingLikes
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: controller.likesModel.data?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(controller
                                    .likesModel.data?[index].image ==
                                null
                            ? AppConfig.noImage
                            : "${AppConfig.mediaUrl}${controller.likesModel.data?[index].image}"),
                      ),
                      title: Text(
                        controller.likesModel.data?[index].username ?? "",
                        style: TextStyle(
                            color: ColorTheme.blue,
                            fontWeight: FontWeight.w500),
                      ),
                    );
                  },
                );
        }),
      ),
    );
  }
}
