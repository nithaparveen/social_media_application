import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:socialmedia/core/constants/colors.dart';
import 'package:socialmedia/core/constants/text_styles.dart';
import 'package:socialmedia/presentation/news_screen/view/widget/news_view_screen.dart';

import '../controller/news_controller.dart';
import 'widget/news_card.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  Future<void> fetchData(BuildContext context) async {
    Provider.of<NewsController>(context, listen: false).fethchData();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Consumer<NewsController>(
      builder: (context, provider, child) {
        return DefaultTabController(
          length: provider.categoryList.length,
          initialIndex: 0,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              titleTextStyle: GLTextStyles.ralewayStyl(
                  color: ColorTheme.blue, size: 25, weight: FontWeight.w700),
              title: const Text("News"),
              centerTitle: true,
              bottom: TabBar(
                tabAlignment: TabAlignment.start,
                labelStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: ColorTheme.blue),
                labelColor: ColorTheme.yellow,
                unselectedLabelColor: Colors.black54,
                unselectedLabelStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
                overlayColor: const MaterialStatePropertyAll(Colors.grey),
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                    color: ColorTheme.blue,
                    borderRadius: BorderRadius.circular(10)),
                isScrollable: true,
                tabs: List.generate(
                  provider.categoryList.length,
                  (index) => Tab(
                    text: provider.categoryList[index],
                  ),
                ),
                onTap: (value) {
                  provider.onTap(index: value);
                },
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              toolbarHeight: height * .05,
            ),
            body: provider.isLoading == true
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView.separated(
                        itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewsViewScreen(
                                            title: provider.newsDataModel.articles?[index].title
                                                    .toString() ??
                                                "",
                                            description: provider
                                                    .newsDataModel
                                                    .articles?[index]
                                                    .description
                                                    .toString() ??
                                                "",
                                            imageUrl: provider.newsDataModel
                                                    .articles?[index].urlToImage
                                                    .toString() ??
                                                "https://clareproject.org.uk/wp-content/uploads/2021/12/placeholder-1.jpg",
                                            contant: provider.newsDataModel
                                                    .articles?[index].content
                                                    .toString() ??
                                                "",
                                            sourceName: provider.newsDataModel.articles?[index].source?.name.toString() ?? "",
                                            url: provider.newsDataModel.articles?[index].url.toString() ?? "",
                                            date: provider.newsDataModel.articles?[index].publishedAt)));
                              },
                              child: NewsCard(
                                title: provider
                                        .newsDataModel.articles?[index].title
                                        .toString() ??
                                    "",
                                description: provider.newsDataModel
                                        .articles?[index].description
                                        .toString() ??
                                    "",
                                date: provider
                                    .newsDataModel.articles?[index].publishedAt,
                                imageUrl: provider.newsDataModel
                                        .articles?[index].urlToImage
                                        .toString() ??
                                    "https://clareproject.org.uk/wp-content/uploads/2021/12/placeholder-1.jpg",
                                contant: provider
                                        .newsDataModel.articles?[index].content
                                        .toString() ??
                                    "",
                                sourceName: provider.newsDataModel
                                        .articles?[index].source?.name
                                        .toString() ??
                                    "",
                                url: provider.newsDataModel.articles?[index].url
                                        .toString() ??
                                    "",
                              ),
                            ),
                        separatorBuilder: (context, index) => const Divider(
                              height: 20,
                            ),
                        itemCount:
                            provider.newsDataModel.articles?.length ?? 0),
                  ),
          ),
        );
      },
    );
  }
}
