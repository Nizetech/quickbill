import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';

import '../Values/NewColor.dart';

class CustomButton extends StatelessWidget {
  final bool isLoading;
  final String text;
  final VoidCallback onTap;
  const CustomButton(
      {super.key,
      this.isLoading = false,
      required this.text,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: isLoading ? null : onTap,
        style: TextButton.styleFrom(
          backgroundColor: MyColor.greenColor,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: isLoading
            ? const SizedBox.square(
                dimension: 24,
                child: const CircularProgressIndicator(
                  color: MyColor.mainWhiteColor,
                ))
            : Text(
                "Sign Up",
                style: NewStyle.btnTx16SplashBlue
                    .copyWith(color: NewColor.mainWhiteColor),
              ),
      ),
    );
  }
}
