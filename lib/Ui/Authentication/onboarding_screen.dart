import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_bills/Ui/Authentication/signIn_screen.dart';
import 'package:quick_bills/Ui/Authentication/signUp_screen.dart';
import 'package:quick_bills/Values/MyColor.dart';
import 'package:quick_bills/Values/MyStyle.dart';
import 'package:quick_bills/common/button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 35,
                ),
                Image.asset(
                  'assets/images/onboard_img.png',
                  width: double.infinity,
                  // height: 46,
                ),
                Spacer(),
                const Text(
                  'Welcome to QuickBills',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff141B34),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                const Text(
                  "We bring the easy and seamless way to pay bills.\n Epic — just like that.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff6B7280),
                  ),
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                CustomButton(
                  radius: 15,
                  text: "Get Started",
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return const SignUpScreen(isOnboarding: true);
                    }));
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text.rich(TextSpan(
                    text: 'Already have an account? ',
                    style: MyStyle.tx14Black.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign In',
                        style: MyStyle.tx14Black.copyWith(
                          fontWeight: FontWeight.w500,
                          color: MyColor.primaryColor,
                          decoration: TextDecoration.underline,
                          decorationColor: MyColor.primaryColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.to(const SignInScreen()),
                      ),
                    ],
                  )),
                ),
                const SizedBox(
                  height: 35,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
