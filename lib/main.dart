import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/presentation/bottom_navigation_screen/controller/bottom_navigation_controller.dart';
import 'package:socialmedia/presentation/bottom_navigation_screen/view/bottom_navigation_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => BottomNavController()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BottomNavBar(),
    );
  }
}
