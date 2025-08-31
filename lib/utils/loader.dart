import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:loading_indicator/loading_indicator.dart';

void showLoader(
    {String? text, bool isWhite = false, bool isDismissible = true}) {
  // authRepo.isDialogShowing = true;
  print('showLoader called'); // Debug print

  if (Get.isDialogOpen == true) {
    print('Dialog already open, returning');
    return;
  }

  Get.dialog(
    Dialog(
      backgroundColor: Colors.transparent,
      child: isWhite
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
    ),
    barrierColor: Colors.black.withOpacity(.5),
    barrierDismissible: isDismissible,
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
  print('hideLoader called, isDialogOpen: ${Get.isDialogOpen}'); // Debug print
  if (Get.isDialogOpen == true) {
    Get.back();
    print('Dialog closed');
  } else {
    print('No dialog to close');
  }
}
