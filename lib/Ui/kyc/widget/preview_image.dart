import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:provider/provider.dart';

class PreviewImage extends StatelessWidget {
  final String imagePath;
  final TabController tabController;
  const PreviewImage(
      {super.key, required this.imagePath, required this.tabController});

  @override
  Widget build(BuildContext context) {
    final account = Provider.of<AccountProvider>(context, listen: false);
    return Column(
      children: [
        Container(
          height: Get.height * 0.3,
          width: Get.width * 0.7,
          decoration: BoxDecoration(
            color: MyColor.grey02Color,
            image: DecorationImage(
              image: FileImage(File(imagePath)),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Spacer(flex: 2),
        SizedBox(
          height: 45,
          child: CustomButton(
            text: "Submit",
            radius: 60,
            onTap: () {
              account.verifyKyc(callback: () {
                tabController.animateTo(2);
              });
              tabController.animateTo(2);
            },
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              tabController.animateTo(0);
            },
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
