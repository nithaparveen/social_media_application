import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        // title: Text('Search'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            MaterialButton(
              color: ColorTheme.color4,
              minWidth: size.width * .5,
              height: size.height * .07,
              onPressed: () {},
              child: Text(
                "Search",
                style: GLTextStyles.leagueSpartan(
                    size: 18, color: ColorTheme.color1),
              ),
            )
          ],
        ),
      ),
    );
  }
}
