import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jost_pay_wallet/Ui/giftCard/gift_card_summary_screen.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:provider/provider.dart';

import '../../Provider/theme_provider.dart';

class CardsOptionScreen extends StatefulWidget {
  const CardsOptionScreen({super.key});

  @override
  State<CardsOptionScreen> createState() => _CardsOptionScreenState();
}

class _CardsOptionScreenState extends State<CardsOptionScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      'assets/images/arrow_left.png',
                      color: themeProvider.isDarkMode()
                          ? MyColor.mainWhiteColor
                          : MyColor.dark01Color,
                    ),
                  ),
                  const Spacer(),
                  Transform.translate(
                    offset: const Offset(-20, 0),
                    child: Text(
                      'Amazon',
                      style:
                          MyStyle.tx18Black.copyWith(color: themedata.tertiary),
                    ),
                  ),
                  const Spacer(), // Adds flexible space after the text
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 32.h,
                      ),
                      Text(
                        'Amount',
                        style: MyStyle.tx14Black.copyWith(
                            color: themedata.tertiary,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      TextFormField(
                        enabled: false,
                        // initialValue: 'Select option',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: themedata.tertiary,
                          fontFamily: 'SF Pro Rounded',
                        ),
                        decoration: NewStyle.authInputDecoration.copyWith(
                            hintText: 'Select option',
                            fillColor: themeProvider.isDarkMode()
                                ? const Color(0XFF33353C)
                                : MyColor.textFieldFillColor,
                            suffixIcon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: themedata.tertiary,
                            )),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Quantity',
                        style: MyStyle.tx14Black.copyWith(
                            color: themedata.tertiary,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      TextFormField(
                        enabled: false,
                        decoration: NewStyle.authInputDecoration.copyWith(
                            hintText: 'Select option',
                            fillColor: themeProvider.isDarkMode()
                                ? const Color(0XFF33353C)
                                : MyColor.textFieldFillColor,
                            suffixIcon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: themedata.tertiary,
                            )),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Email Address',
                        style: MyStyle.tx14Black.copyWith(
                            color: themedata.tertiary,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      TextFormField(
                        enabled: false,
                        decoration: NewStyle.authInputDecoration.copyWith(
                            hintText: 'Select option',
                            fillColor: themeProvider.isDarkMode()
                                ? const Color(0XFF33353C)
                                : MyColor.textFieldFillColor,
                            suffixIcon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: themedata.tertiary,
                            )),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Pay With',
                        style: MyStyle.tx14Black.copyWith(
                            color: themedata.tertiary,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      TextFormField(
                        enabled: false,
                        decoration: NewStyle.authInputDecoration.copyWith(
                            hintText: 'Select option',
                            fillColor: themeProvider.isDarkMode()
                                ? const Color(0XFF33353C)
                                : MyColor.textFieldFillColor,
                            suffixIcon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: themedata.tertiary,
                            )),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      Stack(
                        children: [
                          // Bottom border
                          DottedBorder(
                            color: MyColor.splashBtn,
                            strokeWidth: 1,
                            dashPattern: const [
                              6,
                              3
                            ], // Dash pattern: 6 units line, 3 units space
                            // customPath: (size) => Path()
                            //   ..moveTo(0, 0)
                            //   ..lineTo(size.width, 0),
                            child: Container(
                              // height: 100.h,
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.h, horizontal: 9.w),
                              decoration: BoxDecoration(
                                color: MyColor.splashBtn.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Please note',
                                    style: MyStyle.tx14Black
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  const Text(
                                    'Amazon Gift Card:',
                                    style: MyStyle.tx14Green,
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  const Text(
                                    '* Never expires, redeemable for millions of items on Amazon.com\n\n* Redeem at www.amazon.com/redeem with claim code during checkout\n\n* Funds applied automatically, remaining balance requires other payment method\n\n* Delivered electronically via email\n\nNote: No returns or refunds on gift cards. Confirm country and type before purchase.',
                                    style: MyStyle.tx14Grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 42.h),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const GiftCardSummaryScreen(),
                                ));
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: MyColor.splashBtn,
                            padding: const EdgeInsets.symmetric(
                                vertical: 16), // Padding
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: MyColor.splashBtn,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: Text(
                            "Continue",
                            style: MyStyle.tx16Green.copyWith(
                                color: MyColor.mainWhiteColor,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
