import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/app_config/app_config.dart';
import 'package:socialmedia/presentation/profile_screen/controller/profile_controller.dart';

class FollowersListScreen extends StatefulWidget {
  const FollowersListScreen({super.key});

  @override
  State<FollowersListScreen> createState() => _FollowersListScreenState();
}

class _FollowersListScreenState extends State<FollowersListScreen> {
  fetchData() {
    Provider.of<ProfileController>(context, listen: false)
        .fetchFollower(context);
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
        title: Text("Followers"),
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
        onRefresh: () => Provider.of<ProfileController>(context, listen: false)
            .fetchFollower(context),
        child: Consumer<ProfileController>(builder: (context, controller, _) {
          return controller.isLoadingFollower
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: controller.followersModel.data?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: controller
                                    .followersModel.data?[index].image ==
                                null
                            ? NetworkImage("${AppConfig.noImage}")
                            : NetworkImage(
                                "${AppConfig.mediaUrl}${controller.followersModel.data?[index].image}"),
                      ),
                      title: Text(
                          "${controller.followersModel.data?[index].username}"),
                      // trailing: ElevatedButton(onPressed: () {}, child: Text("UnFollow")),
                    );
                  },
                );
        }),
      ),
    );
  }
}
