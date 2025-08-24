import 'package:flutter/material.dart';
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
  final FontWeight? fontWeight;

  const CustomButton(
      {super.key,
      this.isLoading = false,
      this.radius,
      this.bgColor,
      this.textColor,
      required this.text,
    required this.onTap,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: TextButton(
        onPressed: isLoading ? null : onTap,
        style: TextButton.styleFrom(
          backgroundColor: bgColor ?? MyColor.greenColor,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 10),
          ),
        ),
        child: isLoading
            ? const SizedBox.square(
                dimension: 24,
                child: CircularProgressIndicator(
                  color: MyColor.mainWhiteColor,
                ))
            : Text(
                text,
                style: NewStyle.btnTx16SplashBlue
                    .copyWith(
                    color: textColor ?? NewColor.mainWhiteColor,
                    fontWeight: fontWeight ?? FontWeight.w700),
              ),
      ),
    );
  }
}


class BackBtn extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isFromAuth;
  const BackBtn({super.key, this.onTap, this.isFromAuth = false});

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
                color: themeProvider.isDarkMode() && !isFromAuth
                    ? MyColor.mainWhiteColor
                    : MyColor.dark01Color,
                width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: themeProvider.isDarkMode() && !isFromAuth
                ? MyColor.mainWhiteColor
                : MyColor.dark01Color,
            size: 20,
          ),
        ));
  }
}
