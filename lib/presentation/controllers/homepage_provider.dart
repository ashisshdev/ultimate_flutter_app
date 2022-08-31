import 'package:flutter/cupertino.dart';

class HomePageController with ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  changeIndex(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }
}
