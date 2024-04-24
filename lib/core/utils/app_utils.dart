

import 'package:flutter/material.dart';
import 'package:socialmedia/core/constants/colors.dart';
import 'package:socialmedia/core/constants/text_styles.dart';


class AppUtils {
  // static Future<String?> getAccessKey() async {
  //   log("getAccessKey");
  //   final sharedPreferences = await SharedPreferences.getInstance();
  //   if (sharedPreferences.get(AppConfig.token) != null) {
  //     final access =
  //         jsonDecode(sharedPreferences.get(AppConfig.token) as String);
  //     log("access key =================  $access");
  //     return access;
  //   } else {
  //     return null;
  //   }
  // }

  
  static oneTimeSnackBar(
    String? message, {
    int time = 2,
    Color? bgColor,
    TextStyle? textStyle,
    required BuildContext context,
    bool showOnTop = false,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ///To CLEAR PREVIOUS SNACK BARS
    return ScaffoldMessenger.of(context)
        // ScaffoldMessenger.of(context??Routes.router.routerDelegate.navigatorKey.currentState!.context)
        .showSnackBar(
      SnackBar(
        /*action:SnackBarAction(label: "Ok",
        onPressed: (){
          SystemSettings.internalStorage();
        },
        ) ,*/

        behavior: showOnTop ? SnackBarBehavior.floating : null,
        backgroundColor: bgColor ?? Colors.white60,
        content: Text(message!, style: textStyle ?? GLTextStyles.ralewayStyl(color: ColorTheme.white)),
        duration: Duration(seconds: time),
        margin: showOnTop
            ? EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 100,
                right: 20,
                left: 20)
            : null,
      ),
    );
  }
}