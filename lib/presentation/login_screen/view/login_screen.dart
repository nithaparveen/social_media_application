import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:socialmedia/core/constants/colors.dart';
import 'package:socialmedia/core/constants/text_styles.dart';
import 'package:socialmedia/presentation/bottom_navigation_screen/view/bottom_navigation_screen.dart';
import '../../../global_widgets/title_and_textformfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              decoration: BoxDecoration(
                  color: ColorTheme.blue,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.elliptical(350, 140),
                      bottomLeft: Radius.elliptical(150, 40))),
              height: size.height * .28,
              // width: size.width * .85,
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 45, top: 55),
                    child: Text(
                      "Welcome \nback",
                      textAlign: TextAlign.start,
                      style: GLTextStyles.poppinsStyl(
                          color: ColorTheme.yellow,
                          size: 30,
                          weight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 48),
                    child: Text(
                      "Please SignIn to continue",
                      textAlign: TextAlign.start,
                      style: GLTextStyles.poppinsStyl(
                        color: ColorTheme.yellow,
                        size: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TitleAndTextFormField(
                    text: 'Username',
                  ),
                 TitleAndTextFormField(
                    text: 'Password',
                  ),
                  SizedBox(height: size.height*.022,),
                  MaterialButton(
                      color: ColorTheme.blue,
                      minWidth: size.width * .5,
                      height: size.height * .07,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavBar(),));

                      },
                      child: Text(
                        "SignIn",
                        style: GLTextStyles.leagueSpartan(
                            size: 18, color: ColorTheme.yellow),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
