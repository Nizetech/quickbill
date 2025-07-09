import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:provider/provider.dart';

class PendingScreen extends StatelessWidget {
  final VoidCallback onTap;
  const PendingScreen({
    super.key,
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
                    ? 'assets/images/pending_dark.png'
                    : 'assets/images/pending_light.png',
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
                  color: MyColor.yellowColor.withValues(alpha: .05),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text('Transaction Pending',
                    style: TextStyle(
                      fontSize: 12,
                      color: MyColor.yellowColor,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Transaction pending.... \n This may take 3-5 minutes to complete.",
                textAlign: TextAlign.center,
                style: MyStyle.tx18Black.copyWith(
                    height: 1.5,
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
                  ? 'assets/images/support_p_dark.png'
                  : 'assets/images/support_p_light.png'),
              SizedBox(height: 30),
              CustomButton(
                text: "Try Again Later",
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
