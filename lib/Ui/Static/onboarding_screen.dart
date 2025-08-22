import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gif_view/gif_view.dart';
import 'package:jost_pay_wallet/Ui/Authentication/SignInScreen.dart';
import 'package:jost_pay_wallet/Ui/Authentication/SignUpScreen.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';

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
                  height: 24,
                ),
                SizedBox(
                  height: 60.h,
                  child: Stack(
                    children: [
                      Positioned(
                          top: -20.h,
                          left: -80.w,
                          child: Transform.scale(
                              scale: 0.4,
                          child: Image.asset(
                            'assets/images/JostPayLogo.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GifView.asset(
                  'assets/images/justpay_gif.gif',
                  height: 300,
                  frameRate: 10,
                  fit: BoxFit.cover,
                ),
                Spacer(),
                const Text(
                  'Welcome to JostPay',
                  style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff141B34),
                      fontFamily: 'SF Pro Rounded'),
                ),
                const SizedBox(
                  height: 3,
                ),
                const Text(
                  "Buy airtime, data, electricity tokens, cable TV, car repairs & painting, domains, hosting, and much more conveniently on JostPay",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff6B7280),
                      fontFamily: 'SF Pro Rounded'),
                  textAlign: TextAlign.center,
                ),
                Spacer(),

                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: MyColor.greenColor,
                      padding:
                          const EdgeInsets.symmetric(vertical: 16), // Padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      "Sign up",
                      style: MyStyle.tx16White,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInScreen()));
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: MyColor.mainWhiteColor,
                      padding:
                          const EdgeInsets.symmetric(vertical: 16), // Padding
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: MyColor.greenColor,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      "Sign in",
                      style: MyStyle.tx16Green
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
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
