import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  bool isDarkMode() {
    return _themeMode == ThemeMode.dark;
  }

  MaterialColor kPrimaryColor = const MaterialColor(
    0xFF232325,
    <int, Color>{
      50: Color(0xFF232325),
      100: Color(0xFF232325),
      200: Color(0xFF232325),
      300: Color(0xFF232325),
      400: Color(0xFF232325),
      500: Color(0xFF232325),
      600: Color(0xFF232325),
      700: Color(0xFF232325),
      800: Color(0xFF232325),
      900: Color(0xFF232325),
    },
  );

  ThemeData get lightTheme => ThemeData(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        colorScheme: const ColorScheme.dark(
          primary: MyColor.splashBtn,
          onPrimary: MyColor.splashBtn,
          secondary: MyColor.lightGreenColor,
          onSecondary: MyColor.lightGreenColor,
          surfaceContainer: MyColor.lightGrayColor,
          brightness: Brightness.dark,
          secondaryContainer: MyColor.cardlightBgColor,
          tertiary: MyColor.darkColor,
          onTertiary: MyColor.darkColor,
        ),
        // brightness: Brightness.light,
        
        primarySwatch: kPrimaryColor,
        scaffoldBackgroundColor: MyColor.mainWhiteColor,
        appBarTheme: const AppBarTheme(
          surfaceTintColor: Colors.white,
          backgroundColor: MyColor.backgroundColor,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          elevation: 0,
        ),
      );

  ThemeData get darkTheme => ThemeData(
        // brightness: Brightness.dark,
        primarySwatch: kPrimaryColor,
        colorScheme: const ColorScheme.dark(
          primary: MyColor.splashBtn,
          onPrimary: MyColor.splashBtn,
          surfaceContainer: MyColor.darkGrishColor,
          secondaryContainer: MyColor.cardDarkBgColor,
          secondary: MyColor.lightPrimaryDarkColor,
          onSecondary: MyColor.lightPrimaryDarkColor,
          brightness: Brightness.dark,
          onTertiary: Colors.white,
          tertiary: Colors.white,
        ),
        scaffoldBackgroundColor: MyColor.backgroundColor,
        iconTheme: const IconThemeData(
          color: MyColor.backgroundColor,
        ),
        textTheme: const TextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
        ),
      );
}
