import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_bills/Values/MyColor.dart';
import 'package:quick_bills/Values/MyStyle.dart';
import 'package:quick_bills/common/button.dart';

AppBar appBar({
  VoidCallback? onTap,
  required String title,
  bool isBack = true,
}) {
  return AppBar(
    leading: isBack
        ? BackBtn(
            onTap: onTap ?? () => Get.back(),
          )
        : null,
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(
      title,
      style: MyStyle.tx20Grey.copyWith(
        color: MyColor.blackColor,
        fontSize: 18,
      ),
    ),
  );
}
