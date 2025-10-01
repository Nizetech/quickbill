import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Ui/Authentication/SignUpScreen.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:jost_pay_wallet/common/google_auth.dart';

class RegisterOptions extends StatelessWidget {
  const RegisterOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 1, 0),
          child: InkWell(
              onTap: () => Get.back(),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: MyColor.blackColor, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: MyColor.blackColor,
                  size: 20,
                ),
              )),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text.rich(
              TextSpan(
                text: 'Create a ',
                style: MyStyle.tx28Black,
                children: [
                  TextSpan(
                    text: 'Jostpay\n',
                    style: MyStyle.tx28Green,
                  ),
                  TextSpan(
                    text: 'account',
                    style: MyStyle.tx28Black,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GoogleAuth(
              text: 'Continue with Google',
              isLogin: false,
            ),
            const SizedBox(height: 20),
            CustomButton(
                text: 'Create account using email',
                onTap: () {
                  Get.to(() => const SignUpScreen());
                }),
          ],
        ),
      ),
    );
  }
}
