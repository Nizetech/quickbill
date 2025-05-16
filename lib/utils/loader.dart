import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:loading_indicator/loading_indicator.dart';

void showLoader(
    {String? text, bool isWhite = false, bool isDismissible = true}) {
  // authRepo.isDialogShowing = true;

  Get.dialog(
    barrierColor:
        //  isWhite ? Colors.transparent :
        Colors.black.withOpacity(.5),
    barrierDismissible: isDismissible,
    isWhite
        ? const Column(
            children: [],
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 65,
                width: 65,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballClipRotate,
                  colors: [MyColor.greenColor.withOpacity(.7)],
                  strokeWidth: 5,
                  pathBackgroundColor:
                      //  showPathBackground ?
                      Colors.white,
                  // : null,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                // text ??
                'Please wait...',
                style: Get.textTheme.titleSmall!.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
    // )
    // .then((value) {
    //   // cancel Token
    //   client.cancelToken.cancel();
    // }
  );
}

// Hide Loader
void hideLoader() {
  // authRepo.isDialogShowing = false;
  // Navigator.of(context).pop();
  Get.back();
}
