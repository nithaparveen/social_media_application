import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:socialmedia/core/constants/colors.dart';
import 'package:socialmedia/core/constants/text_styles.dart';
import 'package:socialmedia/global_widgets/text_form_field.dart';

import '../../../global_widgets/title_and_textformfield.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: size.width,
            decoration: BoxDecoration(
                color: ColorTheme.blue,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.elliptical(350, 170),
                    bottomLeft: Radius.elliptical(150, 20))),
            height: size.height * .38,
            // width: size.width * .85,
            alignment: Alignment.bottomLeft,
            child: Text(
              "Create \naccount",
              textAlign: TextAlign.start,
              style: GLTextStyles.poppinsStyl(
                  color: ColorTheme.yellow,
                  size: 28,
                  weight: FontWeight.bold),
            ),
          ),
          SingleChildScrollView(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  "Please SignUp to continue",
                  textAlign: TextAlign.start,
                  style: GLTextStyles.poppinsStyl(
                    color: ColorTheme.yellow,
                    size: 15,
                  ),
                ),
                SizedBox(
                  height: size.height * .2,
                ),
                TitleAndTextFormField(
                  text: '',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
