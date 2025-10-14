import 'package:flutter/cupertino.dart';

class DashboardProvider with ChangeNotifier {
  bool promotionBanner = true;
  int currentIndex = 0;
  changeBottomIndex(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }

  bool showPassword = true;
  changeBuyShowPassword(bool newValue) {
    showPassword = newValue;
    notifyListeners();
  }

  hidePromotionbanner(bool newValue) {
    promotionBanner = newValue;
    notifyListeners();
  }

  String defaultCoin = "";
  changeDefaultCoin(String newValue) {
    defaultCoin = newValue;
    notifyListeners();
  }
}
