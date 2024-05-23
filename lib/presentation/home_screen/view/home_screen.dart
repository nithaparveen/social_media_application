import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/core/constants/colors.dart';
import 'package:socialmedia/presentation/home_screen/controller/home_controller.dart';
import 'package:socialmedia/presentation/home_screen/widgets/feed_widget.dart';
import 'package:socialmedia/presentation/home_screen/widgets/stories_slider.dart';
import 'package:socialmedia/presentation/message_screen/view/message_screen.dart';
import 'package:socialmedia/presentation/profile_screen/controller/profile_controller.dart';
import 'package:socialmedia/presentation/search_screen/view/search_screen.dart';

import '../../../core/constants/text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // bool _isSearchBarVisible = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchData();
    });
    super.initState();
  }

  fetchData() {
    Provider.of<HomeController>(context, listen: false).fetchData(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ThingShare",
          style: GLTextStyles.leagueSpartan(
              size: 25, weight: FontWeight.w500, color: ColorTheme.brown),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
              // _searchClicked,
              icon: Icon(
                Icons.search,
                color: ColorTheme.brown,
                size: 24,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MessageScreen()));
              },
              icon: Icon(
                Icons.message,
                color: ColorTheme.brown,
                size: 22,
              )),
          SizedBox(width: 10),
          // Icon(Icons.search),
        ],
      ),
      // body: Consumer<HomeController>(builder: (context, hcontrol, _) {
      //   return Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 6),
      //     child: SingleChildScrollView(
      //       child: Column(
      //         children: [
      //           // _isSearchBarVisible ? SearchField() :  SizedBox(),
      //           StorySlider(),
      //           SizedBox(height: 10),
      //           FeedWidget(size: size)
      //         ],
      //       ),
      //     ),
      //   );
      // }),
      body: RefreshIndicator(
        onRefresh: () => Provider.of<HomeController>(context, listen: false)
            .fetchData(context),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * .03),
                child: StorySlider(),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 10),
            ),
            Consumer<HomeController>(
              builder: (context, controller, child) {
                return controller.isLoading
                    ? SliverToBoxAdapter(
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : SliverList.separated(
                        itemCount: controller.homeModel.data?.length,
                        itemBuilder: (context, index) {
                          return FeedWidget(
                            size: size,
                            author_name:
                                '${controller.homeModel.data?[index].author?.authorName}',
                            created_at:
                                '${controller.homeModel.data?[index].createdAt}',
                            image: controller.homeModel.data?[index].image ==
                                    null
                                ? "https://th.bing.com/th/id/OIP.y6HMdOJ4LiIUWk7n5ZGlpAHaHa?w=480&h=480&rs=1&pid=ImgDetMain"
                                : "${controller.homeModel.data?[index].image}",
                            caption:
                                '${controller.homeModel.data?[index].caption}',
                            location:
                                '${controller.homeModel.data?[index].location ?? ""}',
                            comments_count:
                                '${controller.homeModel.data?[index].commentsCount}',
                            isLiked: controller.homeModel.data?[index].isLiked,
                            likePressed: () {
                              controller.likeTapped(
                                  controller.homeModel.data?[index].postId,
                                  context);
                              Provider.of<HomeController>(context)
                                  .fetchData(context);
                            },
                            like_count:
                                "${Provider.of<HomeController>(context).homeModel.data?[index].likeCount}",
                            post_id: controller.homeModel.data?[index].postId,
                            followPressed: () {
                              Provider.of<HomeController>(context,listen: false)
                                  .followTapped(controller.homeModel.data?[index].author?.authorId,context);
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 10);
                        },
                      );
              },
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: size.width * .2),
            )
          ],
        ),
      ),
    );
  }

// void _searchClicked() {
//   setState(() {
//     _isSearchBarVisible = !_isSearchBarVisible;
//     log("message");
//   });
// }
}
