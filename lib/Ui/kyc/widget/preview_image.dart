import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';

class PreviewImage extends StatelessWidget {
  const PreviewImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Get.height * 0.3,
          width: Get.width * 0.7,
          decoration: BoxDecoration(
            color: MyColor.grey02Color,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Spacer(flex: 2),
        SizedBox(
          height: 45,
          child: CustomButton(
            text: "Submit",
            radius: 60,
            onTap: () {},
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.transparent,
              side: BorderSide(color: MyColor.greenColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60),
              ),
            ),
            child: Text(
              "Retake",
              style: NewStyle.btnTx16SplashBlue.copyWith(
                color: MyColor.greenColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
