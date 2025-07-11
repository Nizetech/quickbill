import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:provider/provider.dart';

class FailedScreen extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  const FailedScreen({
    super.key,
    required this.onTap,
    required this.title,  
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 20),
          padding: EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              scale: .2,
              image: AssetImage(
                themeProvider.isDarkMode()
                    ? 'assets/images/failed_dark.png'
                    : 'assets/images/failed_light.png',
              ),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: Get.height * .33,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 17, vertical: 5),
                decoration: BoxDecoration(
                  color: MyColor.redColor.withValues(alpha: .05),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text('Transaction Failed!',
                    style: TextStyle(
                      fontSize: 12,
                      color: MyColor.redColor,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: MyStyle.tx18Black.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              Text(
                "Dont't fret -- it's likely your network.",
                textAlign: TextAlign.center,
                style: MyStyle.tx14Black.copyWith(
                  color: MyColor.grey,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Spacer(),
              Image.asset(themeProvider.isDarkMode()
                  ? 'assets/images/support_f_dark.png'
                  : 'assets/images/support_f_light.png'),
              SizedBox(height: 30),
              CustomButton(
                text: "Try Again",
                bgColor: MyColor.darkGreenColor,
                textColor: MyColor.grey,
                onTap: onTap,
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
