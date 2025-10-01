import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/kyc_web.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:provider/provider.dart';

class DepositLimit extends StatelessWidget {
  const DepositLimit({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    final userModel =
        Provider.of<AccountProvider>(context, listen: true).userModel;
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
        children: [
          Row(
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(
                    text: 'You have ',
                    style: MyStyle.tx14Black.copyWith(
                      color: themedata.tertiary,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                          text:
                              '₦${formatNumberWithOutDecimal((userModel?.user?.limit?.toString() ?? '0'))}',
                          style: MyStyle.tx14Black.copyWith(
                            color: themedata.tertiary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )),
                      TextSpan(
                        text: ' deposit limit left',
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(
                  color: themeProvider.isDarkMode()
                      ? MyColor.dark02Color
                      : MyColor.borderColor.withValues(alpha: .2),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: MyColor.grey03Color,
                    width: 1,
                  ),
                ),
                child: Text(
                  'Monthly cap',
                  style: MyStyle.tx14Black.copyWith(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: MyColor.grey03Color,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Upgrade to ',
                    style: MyStyle.tx14Black.copyWith(
                      color: MyColor.grey02Color,
                      fontSize: 12,
                    ),
                    children: [
                      TextSpan(
                        text: 'Full Verification',
                        style: MyStyle.tx14Black.copyWith(
                          color: MyColor.grey02Color,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Enjoy unlimited deposits and unlock features more',
                  style: MyStyle.tx14Black.copyWith(
                    color: MyColor.grey02Color,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFeature(
                            title: 'Unlock gift card purchase',
                            themedata: themedata,
                          ),
                          _buildFeature(
                            title: 'Access hosting & domain services',
                            themedata: themedata,
                          ),
                          _buildFeature(
                            title: 'Activste personal virtual account',
                            themedata: themedata,
                          ),
                          _buildFeature(
                            title: 'And lots more benefits',
                            themedata: themedata,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Text.rich(
                      textAlign: TextAlign.right,
                      TextSpan(
                        text: 'Status\n',
                        style: MyStyle.tx14Black.copyWith(
                          color: MyColor.grey02Color,
                          fontSize: 12,
                        ),
                        children: [
                          TextSpan(
                            text: 'Basic',
                            style: MyStyle.tx14Black.copyWith(
                              color: themedata.tertiary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                LinearProgressIndicator(
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(10),
                  value: userModel?.user?.limit != null
                      ? (userModel?.user?.limit ?? 0) /
                          (userModel?.user?.monthlyLimit ?? 0)
                      : 0,
                  color: MyColor.greenColor,
                  backgroundColor: MyColor.greyColor,
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: CustomButton(
                          text: 'Upgrade Account',
                          fontSize: 14,
                          onTap: () {
                            Get.back();
                            Get.to(const KycWebview());
                          },
                        ),
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
              ],
            ),
          ),

          const SizedBox(height: 10),
          Center(
            child: Text(
              'Basic User -₦${formatNumberWithOutDecimal((userModel?.user?.monthlyLimit?.toString() ?? '0'))} monthly deposit cap',
              style: MyStyle.tx14Black.copyWith(
                color: MyColor.grey02Color,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          // Adding the button
        ],
      ),
    );
  }

  _buildFeature({required String title, required ColorScheme themedata}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Icon(Icons.circle, color: themedata.tertiary, size: 7),
          SizedBox(width: 5),
          Expanded(
            child: Text(title,
                style: MyStyle.tx14Black.copyWith(
                  color: themedata.tertiary,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                )),
          ),
        ],
      ),
    );
  }
}

void showDepositLimit() {
  Get.dialog(
    Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: DepositLimit()),
    barrierColor: Colors.black.withOpacity(.5),
    barrierDismissible: true,
  );
}
