import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:provider/provider.dart';

import '../Values/NewColor.dart';

class CustomButton extends StatelessWidget {
  final bool isLoading;
  final String text;
  final VoidCallback onTap;
  final double? radius;
  final Color? bgColor;
  final Color? textColor;
  const CustomButton(
      {super.key,
      this.isLoading = false,
      this.radius,
      this.bgColor,
      this.textColor,
      required this.text,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: isLoading ? null : onTap,
        style: TextButton.styleFrom(
          backgroundColor: bgColor ?? MyColor.greenColor,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 10),
          ),
        ),
        child: isLoading
            ? const SizedBox.square(
                dimension: 24,
                child: const CircularProgressIndicator(
                  color: MyColor.mainWhiteColor,
                ))
            : Text(
                text,
                style: NewStyle.btnTx16SplashBlue
                    .copyWith(color: textColor ?? NewColor.mainWhiteColor),
              ),
      ),
    );
  }
}

class BackBtn extends StatelessWidget {
  final VoidCallback? onTap;
  const BackBtn({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
   
    return InkWell(
        onTap: onTap ??
            () {
          Navigator.pop(context);
        },
        child: Container(
          margin: const EdgeInsets.only(left: 15, top: 10),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
                color: themeProvider.isDarkMode()
                    ? MyColor.mainWhiteColor
                    : MyColor.dark01Color,
                width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: themeProvider.isDarkMode()
                ? MyColor.mainWhiteColor
                : MyColor.dark01Color,
            size: 20,
          ),
        ));
  }
}
