import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/constants/constants.dart';

class ThemeProvider extends ChangeNotifier {
  final box = Hive.box(kAppName);
 
  // Store ThemeMode as a string and retrieve it safely
  ThemeMode themeMode = getThemeModeFromBox();

  static ThemeMode getThemeModeFromBox() {
    final themeModeString =
        Hive.box(kAppName).get('themeMode', defaultValue: ThemeMode.light.name);
    return ThemeMode.values.firstWhere(
      (e) => e.name == themeModeString,
      orElse: () => ThemeMode.light,
    );
  }

  void toggleTheme(bool isDarkMode) {
    themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    box.put('themeMode', themeMode.name); // Store as a string
    notifyListeners();
  }

  bool isDarkMode() {
    return themeMode == ThemeMode.dark;
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
        fontFamily: 'Switzer',
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
        fontFamily: 'Switzer',
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
