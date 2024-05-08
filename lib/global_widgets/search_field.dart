import 'package:flutter/material.dart';

import '../core/constants/colors.dart';
import '../core/constants/text_styles.dart';

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(width: 10.0),
        MaterialButton(
          color: ColorTheme.blue,
          minWidth: size.width * .3,
          height: size.height * .07,
          onPressed: () {},
          child: Text(
            "Search",
            style:
                GLTextStyles.leagueSpartan(size: 18, color: ColorTheme.yellow),
          ),
        )
      ],
    );
  }
}
