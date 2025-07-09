import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:provider/provider.dart';

class SuccessScreen extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const SuccessScreen({
    super.key,
    required this.title,
    required this.onTap,
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
                    ? 'assets/images/success_dark.png'
                    : 'assets/images/success_light.png',
              ),
            ),
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * .33,
              ),
              // Image.asset('assets/images/Explode.png'),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 17, vertical: 5),
                decoration: BoxDecoration(
                  color: MyColor.greenColor.withValues(alpha: .05),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text('Successful!',
                    style: TextStyle(
                      fontSize: 12,
                      color: MyColor.greenColor,
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
                "This transaction takes less than 10 minutes.",
                textAlign: TextAlign.center,
                style: MyStyle.tx14Black.copyWith(
                  color: MyColor.grey,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                ),
              ),

              Spacer(),
              Image.asset(themeProvider.isDarkMode()
                  ? 'assets/images/dark_rate.png'
                  : 'assets/images/light_rate.png'),
              SizedBox(height: 30),
              CustomButton(
                text: "Buy More",
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
