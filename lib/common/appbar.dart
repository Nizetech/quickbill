import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';

AppBar appBar({
  VoidCallback? onTap,
  required String title,
  bool isBack = true,
}) {
  return AppBar(
    leading: isBack
        ? BackBtn(
            onTap: onTap,
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
