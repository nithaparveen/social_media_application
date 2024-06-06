import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/presentation/news_screen/controller/news_controller.dart';

import '../../../home_screen/controller/home_controller.dart';

class NewsCard extends StatelessWidget {
  const NewsCard(
      {super.key,
      required this.title,
      required this.description,
      required this.date,
      required this.imageUrl,
      required this.contant,
      required this.sourceName,
      required this.url});

  final String title;
  final String description;
  final DateTime? date;
  final String imageUrl;
  final String contant;
  final String sourceName;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(
                    imageUrl,
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "$sourceName | ${DateFormat('dd/MM/yyyy').format(date!).toString()}"),
                  IconButton(
                      onPressed: () {
                        String newsToShare = "$title \n \n $description \n \n $url";
                        Provider.of<NewsController>(context,
                                listen: false).share(toShare: newsToShare);
                      },
                      icon: const Icon(Icons.share))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}