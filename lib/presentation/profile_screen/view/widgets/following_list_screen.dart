import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/app_config/app_config.dart';
import 'package:socialmedia/presentation/profile_screen/controller/profile_controller.dart';

class FollowingListScreen extends StatefulWidget {
  const FollowingListScreen({super.key});

  @override
  State<FollowingListScreen> createState() => _FollowingListScreenState();
}

class _FollowingListScreenState extends State<FollowingListScreen> {
  fetchData() {
    Provider.of<ProfileController>(context, listen: false).fetchFollowing(context);
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
        title: Text("Following"),
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
        onRefresh: () =>Provider.of<ProfileController>(context, listen: false).fetchFollowing(context),
        child: Consumer<ProfileController>(builder: (context, controller, _) {
          return controller.isLoadingFollowing
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: controller.followingModel.data?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: controller.followingModel.data?[index].image == null
                            ? NetworkImage("${AppConfig.noImage}")
                            : NetworkImage(
                                "${AppConfig.mediaUrl}${controller.followingModel.data?[index].image}"),
                      ),
                      title: Text("${controller.followingModel.data?[index].username}"),
                      trailing: ElevatedButton(onPressed: () {}, child: Text("UnFollow")),
                    );
                  },
                );
        }),
      ),
    );
  }
}
