import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';
void main (){
  runApp(MaterialApp(home: SearchScreen(),));
}
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start ,
          children: [
            IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back)),
            SizedBox(
              height: 40,
              width: MediaQuery.sizeOf(context).width * .6,
              child: TextField(maxLines: 6,
                // controller: textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Color(0xff8c2f35), width: 1)),
                ),
              ),
            ),
            SizedBox(
                width: 8
            ),
            Expanded(
              child: SizedBox(height: 40,width: 60,
                child: ElevatedButton(
                  onPressed: () {
                    // provider.searchData(
                    //     searchText: textController.text.toLowerCase());
                    // FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Center(
                    child: Text(
                      "Search",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStatePropertyAll(Color(0xff8c2f35),)),
                ),
              ),
            )
          ],
        ),
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     TextField(
        //       decoration: InputDecoration(
        //         hintText: 'Search',
        //         border: OutlineInputBorder(),
        //         suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.search))
        //       ),
        //     ),
        //     // MaterialButton(
        //     //   color: ColorTheme.blue,
        //     //   minWidth: size.width * .5,
        //     //   height: size.height * .07,
        //     //   onPressed: () {},
        //     //   child: Text(
        //     //     "Search",
        //     //     style: GLTextStyles.leagueSpartan(
        //     //         size: 18, color: ColorTheme.yellow),
        //     //   ),
        //     // )
        //   ],
        // ),
      ),
    );
  }
}