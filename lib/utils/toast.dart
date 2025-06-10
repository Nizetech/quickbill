import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';

class ErrorToast {
  ErrorToast(String message) {
    Flushbar(
      message: message,
      maxWidth: Get.width * 0.7,
      flushbarPosition: FlushbarPosition.TOP,
      messageSize: 12,
      borderRadius: BorderRadius.circular(10),
      padding: const EdgeInsets.all(10),
      icon: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.close, color: Colors.white)),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
    ).show(Get.context!);
  }
}

class SuccessToast {
  SuccessToast(String message) {
    Flushbar(
      message: message,
      maxWidth: Get.width * 0.7,
      flushbarPosition: FlushbarPosition.TOP,
      messageSize: 14,
      borderRadius: BorderRadius.circular(10),
      boxShadows: [
        BoxShadow(
          color: Colors.grey.withOpacity(.5),
          blurRadius: 3,
          offset: const Offset(0, 1),
        ),
      ],
      padding: const EdgeInsets.all(10),
      icon: IconButton(
          onPressed: () => Get.back(),
          icon:
               Icon(
          Icons.check_circle,
          color: Colors.white,
        ),
      ),
      backgroundColor: MyColor.greenColor,
      duration: const Duration(seconds: 3),
    ).show(Get.context!);
  }
}

void verifyToast({String? message}) {
  Fluttertoast.showToast(
      msg: message ?? "Please verify your account to continue",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: MyColor.greenColor,
      textColor: const Color(0xFFFF4B4B),
      fontSize: 11.0);
}

void errorSnackBar(String message) {
  Get.snackbar(
    'Error',
    message,
    backgroundColor: Colors.red,
    colorText: Colors.white,
  );
}

void fancyToast(String msg) {
  Fluttertoast.showToast(msg: msg
      // toastLength: Toast.LENGTH_SHORT,
      // gravity: ToastGravity.BOTTOM,
      // timeInSecForIosWeb: 3,
      // backgroundColor: MyColor.greenColor,
      // textColor: const Color(0xFFFF4B4B),
      // fontSize: 11.0
      );
}
