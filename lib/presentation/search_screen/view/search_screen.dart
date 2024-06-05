import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/app_config/app_config.dart';
import 'package:socialmedia/presentation/home_screen/controller/home_controller.dart';
import 'package:socialmedia/presentation/search_screen/controller/search_controller.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();

  @override
  void dispose() {
    searchController;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
            )),
        title: Text('Search'),
        titleTextStyle: GLTextStyles.ralewayStyl(weight: FontWeight.w700, size: 22, color: ColorTheme.blue),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(size.width * 0.22),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  //height: size.height * .08,
                  width: size.width * .75,
                  child: TextFormField(
                    // maxLines: 6,
                    controller: searchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black, width: .5)),
                    ),
                    validator: (value){
                      if(value==null){
                        return "Enter the string";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: size.width * .05),
                // SizedBox(
                //   height: size.height * .07,
                //   child: ElevatedButton(
                //     onPressed: () {
                //       Provider.of<SearchScreenController>(context, listen: false)
                //           .fetchData(searchController.text.trim(), context);
                //     },
                //     child: Center(
                //       child: Icon(
                //         Icons.search,
                //         color: ColorTheme.yellow,
                //       ),
                //     ),
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: ColorTheme.blue,
                //     ),
                //   ),
                // )
                InkWell(
                  onTap: () {
                    Provider.of<SearchScreenController>(context, listen: false)
                        .fetchData(searchController.text.trim(), context);
                  },
                  child: Container(
                    height: size.height * .057,
                    width: size.width * .15,
                    decoration:
                        BoxDecoration(color: ColorTheme.blue, borderRadius: BorderRadius.circular(10)),
                    child: Icon(Icons.search, color: ColorTheme.yellow),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()=>Provider.of<SearchScreenController>(context, listen: false)
            .fetchData(searchController.text.trim(), context),
        child: Consumer<SearchScreenController>(builder: (context, controller, _) {
          return Visibility(
            visible: controller.showData,
            child: ListView.builder(
                itemCount: controller.searchModel?.data?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "${controller.searchModel?.data?[index].image ?? "${AppConfig.noImage}"}")),
                    title: Text("${controller.searchModel?.data?[index].username}"),
                    subtitle: Text("${controller.searchModel?.data?[index].name}"),
                    trailing: SizedBox(
                      width: 100,
                      child: ElevatedButton(
                          onPressed: () {
                            Provider.of<HomeController>(context, listen: false)
                                .followTapped(controller.searchModel?.data?[index].id, context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: controller.searchModel?.data?[index].isFollowing == true
                                  ? ColorTheme.white
                                  : ColorTheme.blue),
                          child: controller.searchModel?.data?[index].isFollowing == true
                              ? Text(
                                  "Unfollow",
                                  style: TextStyle(color: ColorTheme.blue),
                                )
                              : Text(
                                  "Follow",
                                  style: TextStyle(color: ColorTheme.white),
                                )),
                    ),
                  );
                }),
          );
        }),
      ),
    );
  }
}
