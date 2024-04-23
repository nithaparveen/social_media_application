import 'package:flutter/material.dart';
import 'package:socialmedia/presentation/home_screen/view/home_screen.dart';


class BottomNavController with ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}