import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/kyc_web.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:provider/provider.dart';

class VerficationPrompt extends StatelessWidget {
  const VerficationPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color:
            !themeProvider.isDarkMode() ? Color(0xfffCFCFC) : Color(0xff171717),
        border: Border.all(
          color: themeProvider.isDarkMode()
              ? MyColor.borderDarkColor.withValues(alpha: .2)
              : MyColor.borderColor.withValues(alpha: .2),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Full Verification Required',
            style: MyStyle.tx16Black.copyWith(
              color: themedata.tertiary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Full verification is required to access this service. Please upgrade your KYC verification status to gain full access to all services.',
            textAlign: TextAlign.center,
            style: MyStyle.tx14Black.copyWith(
              color: themedata.tertiary,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 40,
            child: CustomButton(
              text: 'Upgrade Verification',
              fontSize: 14,
              onTap: () {
                Get.back();
                Get.to(const KycWebview());
              },
            ),
          ),
          SizedBox(width: 10),
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              "I'll do it later",
              style: MyStyle.tx14Black.copyWith(
                color: MyColor.greenColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showVerificationPrompt() {
  Get.dialog(
    Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: VerficationPrompt(),
    ),
  );
}
