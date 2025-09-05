import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jost_pay_wallet/Ui/Authentication/SignInScreen.dart';
import 'package:jost_pay_wallet/Ui/Static/onboarding_screen.dart';
import 'package:jost_pay_wallet/bottom_nav.dart';
import 'package:jost_pay_wallet/constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getToken();

    Future.delayed(Duration(seconds: 2), () {
      token.isNotEmpty && pinEnabled.isNotEmpty && pinEnabled == '0'
          ? Get.offAll(() => BottomNav())
          : isExistingUser && pinEnabled == '1'
              ? Get.offAll(SignInScreen())
              : Get.offAll(() => (OnboardingScreen()));
    });
  }

  final box = Hive.box(kAppName);
  String token = '';
  String pinEnabled = '';
  bool isExistingUser = false;

  FutureOr getToken() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      token = await box.get(kAccessToken, defaultValue: '');
      isExistingUser = await box.get(kExistingUser, defaultValue: false);
      pinEnabled = box.get(isPinEnabled, defaultValue: "");
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child:
            Image.asset(width: double.infinity, 'assets/images/splash_2.png'),
      ),
    );
  }
}
