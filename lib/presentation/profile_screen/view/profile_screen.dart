import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/app_config/app_config.dart';
import 'package:socialmedia/global_widgets/drawer_refactored.dart';
import 'package:socialmedia/presentation/profile_screen/controller/profile_controller.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Provider.of<ProfileController>(context, listen: false).fetchData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.sizeOf(context);
    return Consumer<ProfileController>(builder: (context, controller, _) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${controller.profileModel.data?.username ?? ""}",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
              icon: Icon(
                Icons.settings,
                size: 22,
                color: Colors.black,
              ),
            ),
          ],
        ),
        endDrawer:DrawerRefactored(),
        body: Column(
          children: [
            SizedBox(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // profile photo
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: InkWell(
                        onLongPress: () {
                          //getProfilePic(ImageSource.gallery);
                          print("long pressed profile");
                        },
                        child: CircleAvatar(
                          radius: 45,
                          backgroundImage: controller
                                      .profileModel.data?.image ==
                                  null
                              ? NetworkImage("${AppConfig.noImage}")
                              : NetworkImage(
                                  "${AppConfig.mediaUrl}${controller.profileModel.data?.image}"),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //  following
                        InkWell(
                          onTap: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Followers",
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "${controller.profileModel.data?.followerCount ?? ""}",
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),

                        // followers
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Following",
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "${controller.profileModel.data?.followingCount ?? ""}",
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),

                        /// Posts

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Posts",
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "10",
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  children: List.generate(
                    10,
                    (index) => InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg"))),
                        child: Center(
                          child: Text(
                            "hai",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
