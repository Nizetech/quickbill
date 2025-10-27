import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quick_bills/Ui/Dashboard/add_funds.dart';
import 'package:quick_bills/Values/MyColor.dart';
import 'package:quick_bills/Values/MyStyle.dart';
import 'package:quick_bills/Values/NewStyle.dart';

import '../Values/NewColor.dart';

class CustomButton extends StatelessWidget {
  final bool isLoading;
  final String text;
  final VoidCallback onTap;
  final double? radius;
  final double? fontSize;
  final Color? bgColor;
  final Color? textColor;
  final FontWeight? fontWeight;

  const CustomButton({
    super.key,
    this.isLoading = false,
    this.radius,
    this.bgColor,
    this.textColor,
    required this.text,
    required this.onTap,
    this.fontWeight,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: TextButton(
        onPressed: isLoading ? null : onTap,
        style: TextButton.styleFrom(
          backgroundColor: bgColor ?? MyColor.primaryColor,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 40),
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
                style: NewStyle.btnTx16SplashBlue.copyWith(
                    color: textColor ?? NewColor.mainWhiteColor,
                    fontWeight: fontWeight ?? FontWeight.w700,
                    fontSize: fontSize ?? 16),
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

    return InkWell(
        onTap: onTap ??
            () {
            Navigator.pop(context);
          },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 5, 10),
        child: CircleAvatar(
          backgroundColor: MyColor.grey01Color,
          child: SvgPicture.asset('assets/images/back_arrow.svg'),
        ),
      ),
    );
  }
}

class AddFundsBtn extends StatelessWidget {
  const AddFundsBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: MyColor.lightGreen,
          foregroundColor: MyColor.greenColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          Get.to(() => const AddFunds());
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.add, color: MyColor.greenColor),
            const SizedBox(width: 8),
            Text('Add Funds',
                style: MyStyle.tx14Black.copyWith(
                    color: MyColor.greenColor, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
