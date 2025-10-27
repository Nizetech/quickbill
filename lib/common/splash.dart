import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quick_bills/Ui/Authentication/signIn_screen.dart';
import 'package:quick_bills/Ui/Authentication/onboarding_screen.dart';
import 'package:quick_bills/bottom_nav.dart';
import 'package:quick_bills/constants/constants.dart';

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
      // log("token: $token, isExistingUser: $isExistingUser");
      token.isNotEmpty 
          ? Get.offAll(() => BottomNav())
          : isExistingUser 
              ? Get.offAll(SignInScreen())
              : Get.offAll(() => (OnboardingScreen()));
    });
  }

  final box = Hive.box(kAppName);
  String token = '';
  bool isExistingUser = false;

  FutureOr getToken() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      token = await box.get(kAccessToken, defaultValue: '') ?? '';
      log("token:==> $token");
      isExistingUser =
          await box.get(kExistingUser, defaultValue: false) ?? false;
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
            Image.asset(width: double.infinity, 'assets/images/splash.png'),
      ),
    );
  }
}
