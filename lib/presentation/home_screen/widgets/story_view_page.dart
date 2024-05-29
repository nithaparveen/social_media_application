import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/presentation/home_screen/controller/home_controller.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';

class StoryView extends StatefulWidget {
  const StoryView({super.key, required this.authorName, required this.image});

  final String authorName;
  final String image;

  @override
  State<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: Consumer<HomeController>(builder: (context, control, _) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.image),
                        fit: BoxFit.contain)),
                height: size.height,
                width: size.width,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.authorName,
                      style: GLTextStyles.ralewayStyl(
                          size: 24,
                          weight: FontWeight.w700,
                          color: ColorTheme.white,
                          textDecoration: TextDecoration.underline,
                          decorationColor: ColorTheme.white),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: ColorTheme.white,
                        ))
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
