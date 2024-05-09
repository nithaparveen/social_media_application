import 'package:flutter/material.dart';

import '../core/constants/colors.dart';
import '../core/constants/text_styles.dart';

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Wrap(
      children: [
        SearchBar(
          onSubmitted: (value) {},
          hintText: "Search",
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
