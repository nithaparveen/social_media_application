import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/core/constants/colors.dart';
import 'package:socialmedia/core/constants/text_styles.dart';
import 'package:socialmedia/presentation/bottom_navigation_screen/view/bottom_navigation_screen.dart';
import 'package:socialmedia/presentation/login_screen/controller/login_controller.dart';
import '../../../global_widgets/title_and_textformfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool visibility = false;

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
                      "Please LogIn to continue",
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
                    textEditingController: emailController,
                    text: 'Email',
                  ),
                 Consumer<loginController>(
                   builder: (context,controller,_) {
                     return TextFormField(
                       obscureText: controller.visibility,
                       obscuringCharacter: '*',
                       controller: passwordController,
                       decoration: InputDecoration(
                           prefixIcon: IconButton(
                               onPressed: () {
                                 controller.onPressed();
                               },
                               icon: Icon(controller.visibility == true
                                   ? Icons.visibility_off
                                   : Icons.visibility)),
                           border: OutlineInputBorder(
                               borderSide: BorderSide(width: .1, color: Colors.white54)),
                           hintText: 'Password',
                           labelText: 'password'),
                     );
                   }
                 ),
                  SizedBox(height: size.height*.022,),
                  MaterialButton(
                      color: ColorTheme.blue,
                      minWidth: size.width * .5,
                      height: size.height * .07,
                      onPressed: () {
                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavBar(),));
                        Provider.of<loginController>(context,listen: false).onLogin(emailController.text.trim(), passwordController.text.trim(), context);
                        // emailController.clear();
                        // passwordController.clear();
                      },
                      child: Text(
                        "LogIn",
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
