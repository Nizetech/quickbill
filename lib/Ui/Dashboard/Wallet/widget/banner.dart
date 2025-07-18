import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/DashboardProvider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Support/terms_screen.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class BannerAds extends StatelessWidget {
  final DashboardProvider dashProvider;
  const BannerAds({super.key, required this.dashProvider});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);

    return Container(
      padding: const EdgeInsets.only(left: 26, top: 11, right: 26),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Are you the next winner? 🎉',
                      style: MyStyle.tx28Black.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.tertiary),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text("Don't miss out on this incredible",
                        style: MyStyle.tx12Black.copyWith(
                            color: themeProvider.isDarkMode()
                                ? const Color(0XFFCBD2EB)
                                : const Color(0xff30333A)))
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text("opportunity to win big!",
                        style: MyStyle.tx12Black.copyWith(
                            color: themeProvider.isDarkMode()
                                ? const Color(0XFFCBD2EB)
                                : const Color(0xff30333A)))
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        dashProvider.changeBottomIndex(3);
                      },
                      child: Container(
                        // width: 66,
                        height: 25,
                        margin: EdgeInsets.only(bottom: 12.h),
                        decoration: BoxDecoration(
                            color: MyColor.greenColor,
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 12),
                        child: const Text(
                          'Learn more',
                          style: MyStyle.tx8White,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        Platform.isIOS
                            ? Get.to(TermsScreen(
                                isFromHome: true,
                              ))
                            :
                        dashProvider.hidePromotionbanner(false);
                      },
                      child: Container(
                        // width: 66,
                        height: 25,
                        margin: EdgeInsets.only(bottom: 12.h),
                        decoration: BoxDecoration(
                            color: MyColor.greenColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 12),
                        child: Text(
                          Platform.isIOS ? 'View Rules' : 'Close',
                          style: MyStyle.tx8White,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
              child: Transform.translate(
            offset: const Offset(0.0,
                12.0), // Translate 10 pixels to the right and 20 pixels down
            child: Image.asset(
              'assets/images/dashboard/gift.png',
              width: 71,
              height: 120,
            ),
          ))
        ],
      ),
    );
  }
}
