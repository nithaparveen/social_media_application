import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/app_config/app_config.dart';
import 'package:socialmedia/global_widgets/drawer_refactored.dart';
import 'package:socialmedia/presentation/profile_screen/controller/profile_controller.dart';
import 'package:socialmedia/presentation/profile_screen/view/widgets/following_list_screen.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
import '../../home_screen/widgets/feed_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Provider.of<ProfileController>(context, listen: false).fetchData(context);
  }

  String? selectedDate;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
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
        endDrawer: DrawerRefactored(
          name: controller.profileModel.data?.name ?? "",
          dob: "${controller.profileModel.data?.dob}",
          phone: controller.profileModel.data?.phoneNumber ?? "",
          location: controller.profileModel.data?.location ?? "",
        ),
        body: RefreshIndicator(
          onRefresh: () => Provider.of<ProfileController>(context, listen: false).fetchData(context),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        // profile photo
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: InkWell(
                                onLongPress: () {
                                  //getProfilePic(ImageSource.gallery);
                                  print("long pressed profile");
                                },
                                child: CircleAvatar(
                                  radius: 45,
                                  backgroundImage: controller.profileModel.data?.image == null
                                      ? NetworkImage("${AppConfig.noImage}")
                                      : NetworkImage(
                                          "${AppConfig.mediaUrl}${controller.profileModel.data?.image}"),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${controller.profileModel.data?.name}",
                                  style: GLTextStyles.ralewayStyl(size: 18),
                                ),
                                Text(
                                  "${DateFormat('dd/MM/yyyy').format((controller.profileModel.data!.dob)!).toString()}",
                                  style: GLTextStyles.ralewayStyl(size: 15),
                                ),
                                Text(
                                  "${controller.profileModel.data?.phoneNumber}",
                                  style: GLTextStyles.ralewayStyl(size: 15),
                                ),
                                Text(
                                  "${controller.profileModel.data?.location}",
                                  style: GLTextStyles.ralewayStyl(size: 15),
                                ),
                              ],
                            )
                          ],
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
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => FollowingListScreen()));
                              },
                              child: Column(
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
                                  "${controller.postListModel.data!.length}",
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
                Consumer<ProfileController>(
                  builder: (context, control, child) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        physics: NeverScrollableScrollPhysics(),
                        children: List.generate(
                          control.postListModel.data!.length,
                          (index) => InkWell(
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        content: SizedBox(
                                          height: size.height * .70,
                                          width: size.height * .75,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                leading: CircleAvatar(
                                                  backgroundImage: control.postListModel.data?[index].author
                                                              ?.profileImage ==
                                                          null
                                                      ? NetworkImage(
                                                          "https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg")
                                                      : NetworkImage(
                                                          "${AppConfig.mediaUrl}${control.postListModel.data![index].author!.profileImage}"),
                                                ),
                                                title: Text(
                                                  "${control.postListModel.data?[index].author?.authorName}",
                                                  style: GLTextStyles.poppinsStyl(
                                                      size: size.width * .04, weight: FontWeight.w600),
                                                ),
                                                subtitle: GestureDetector(
                                                  onTap: () {
                                                    // maplaunchURL(surl);
                                                  },
                                                  child: Text(
                                                    "${control.postListModel.data?[index].location}",
                                                    style: GLTextStyles.kanitStyl(
                                                        size: size.width * .035, weight: FontWeight.w300),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: size.width * .65,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.contain,
                                                        image: control.postListModel.data?[index].image ==
                                                                null
                                                            ? NetworkImage(
                                                                "https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg")
                                                            : NetworkImage(
                                                                "${control.postListModel.data?[index].image}",
                                                              ))),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    displayText(
                                                        label:
                                                            "${control.postListModel.data?[index].caption}"),
                                                    Wrap(
                                                      children: [
                                                        Wrap(
                                                          children: [
                                                            Container(
                                                              width: size.width * .05,
                                                              height: size.width * .05,
                                                              decoration: BoxDecoration(
                                                                  color: ColorTheme.yellow,
                                                                  shape: BoxShape.circle),
                                                              child: const Icon(Icons.thumb_up,
                                                                  color: Colors.white, size: 14),
                                                            ),
                                                            SizedBox(width: size.width * .02),
                                                            displayText(
                                                                label:
                                                                    "${control.postListModel.data?[index].likeCount}"),
                                                          ],
                                                        ),
                                                        SizedBox(width: size.width * .04),
                                                        displayText(
                                                            label:
                                                                "${control.postListModel.data?[index].commentsCount}"),
                                                        SizedBox(width: size.width * .02),
                                                        displayText(label: "Comments"),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  headerButton(
                                                      buttonText: "Like",
                                                      buttonIcon:
                                                          control.postListModel.data?[index].isLiked == true
                                                              ? Icons.thumb_up_alt_outlined
                                                              : Icons.thumb_up_off_alt_sharp,
                                                      buttonAction: () {},
                                                      buttonColor: ColorTheme.yellow),
                                                  headerButton(
                                                      buttonText: "Comment",
                                                      buttonIcon: Icons.message_outlined,
                                                      buttonAction: () {},
                                                      buttonColor: ColorTheme.yellow),
                                                ],
                                              ),
                                              headerButton(
                                                buttonText: "Delete",
                                                buttonIcon: Icons.delete_outline,
                                                buttonAction: () {
                                                  Provider.of<ProfileController>(context, listen: false)
                                                      .postDeleted(
                                                          controller.postListModel.data?[index].postId,
                                                          context);
                                                },
                                                buttonColor: ColorTheme.yellow,
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: control.postListModel.data?[index].image == null
                                          ? NetworkImage(
                                              "https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg")
                                          : NetworkImage(
                                              "${control.postListModel.data?[index].image}",
                                            ))),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
