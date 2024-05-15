import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
class SearchScreen extends StatelessWidget {
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
        titleTextStyle: GLTextStyles.ralewayStyl(
            weight: FontWeight.w700, size: 22, color: ColorTheme.blue),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: size.height * .08,
              width: size.width * .75,
              child: TextField(
                // maxLines: 6,
                // controller: textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.black, width: .5)),
                ),
              ),
            ),
            SizedBox(
              width: size.width * .009,
            ),
            Expanded(
              child: SizedBox(
                height: size.height * .08,
                child: ElevatedButton(
                  onPressed: () {
                    // provider.searchData(
                    //     searchText: textController.text.toLowerCase());
                    // FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Center(
                    child: Icon(
                      Icons.search,
                      color: ColorTheme.yellow,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorTheme.blue,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
