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
barrierColor: MyColor.primaryColor.withValues(alpha: .8),
    Dialog(
      surfaceTintColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      //  MyColor.primaryColor.withValues(alpha: .5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          // color: MyColor.primaryColor.withValues(alpha: .5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: isWhite
            ? const Column(
                children: [],
              )
            : Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 65,
                    width: 65,
                    child: LoadingIndicator(
                      indicatorType: Indicator.ballBeat,
                      colors: [MyColor.whiteColor],
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
    ),
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
