import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/promotions/soical_summary_screen.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:provider/provider.dart';

class SocialBoost extends StatefulWidget {
  const SocialBoost({super.key});

  @override
  State<SocialBoost> createState() => _SocialBoostState();
}

class _SocialBoostState extends State<SocialBoost> {
  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context).colorScheme;
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    return Scaffold(
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
                      'Social Boost',
                      style:
                          MyStyle.tx18Black.copyWith(color: themedata.tertiary),
                    ),
                  ),
                  const Spacer(), // Adds flexible space after the text
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                style: TextStyle(
                  fontSize: 14.sp,
                  color: themedata.tertiary,
                  fontFamily: 'SF Pro Rounded',
                ),
                decoration: NewStyle.authInputDecoration.copyWith(
                    hintText: 'Enter category to search',
                    fillColor: themeProvider.isDarkMode()
                        ? const Color(0XFF33353C)
                        : MyColor.textFieldFillColor,
                    suffixIcon: Image.asset('assets/images/search.png')),
              ),
              const SizedBox(
                height: 12,
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
                        'Category',
                        style: MyStyle.tx14Black.copyWith(
                            color: themedata.tertiary,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      TextFormField(
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: themedata.tertiary,
                          fontFamily: 'SF Pro Rounded',
                        ),
                        enabled: false,
                        initialValue:
                            'Youtube views [Social Ads] [Ultrafast][Life....',
                        decoration: NewStyle.authInputDecoration.copyWith(
                            // hintText: 'Enter category to search',
                            fillColor: themeProvider.isDarkMode()
                                ? const Color(0XFF33353C)
                                : MyColor.textFieldFillColor,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                'assets/images/svg/youtube.svg',
                                height: 8.r,
                                width: 10.r,
                              ),
                            ),
                            suffixIcon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: themedata.tertiary,
                            )),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Service',
                        style: MyStyle.tx14Black.copyWith(
                            color: themedata.tertiary,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      TextFormField(
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: themedata.tertiary,
                          fontFamily: 'SF Pro Rounded',
                        ),
                        enabled: false,
                        initialValue:
                            'Youtube views [Social Ads] [Min 3K].....',
                        decoration: NewStyle.authInputDecoration.copyWith(
                            // hintText: 'Enter category to search',
                            fillColor: themeProvider.isDarkMode()
                                ? const Color(0XFF33353C)
                                : MyColor.textFieldFillColor,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 20.h,
                                width: 40.w,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height: 15.h,
                                      width: 30.w,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: MyColor.splashBtn,
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      child: Text(
                                        '8763',
                                        style: MyStyle.tx14Black.copyWith(
                                            color: MyColor.mainWhiteColor,
                                            fontSize: 7.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        height: 10.h,
                                        width: 20.w,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: const Color(0XFFF9C846)
                                                .withValues(alpha: 0.9),
                                            border: Border.all(
                                                color: const Color(0XFFC89306)),
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        child: Text(
                                          'New',
                                          style: MyStyle.tx14Black.copyWith(
                                              color: MyColor.mainWhiteColor,
                                              fontSize: 5.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
                                    '-Start: 0-6 Hours (May delay up to 24 hours)',
                                    style: MyStyle.tx14Black
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    '-Lifetime Guaranteed',
                                    style: MyStyle.tx14Black
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    '-Drop:0%',
                                    style: MyStyle.tx14Black
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    '-100% Owner Server',
                                    style: MyStyle.tx14Black
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/svg/info.svg',
                                        height: 18.r,
                                        width: 18.r,
                                      ),
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      const Text(
                                        'Please note',
                                        style: MyStyle.tx14Green,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  const Text(
                                    'Some content limitations apply (e.g, drugs, political, religious content) \n\nIf these limitations are violated , the order will be canceled. Video must be public throughout the order\n\nNo refunds for orders if the video is removed or made private while in progress.',
                                    style: MyStyle.tx14Grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Link',
                        style: MyStyle.tx14Black.copyWith(
                            color: themedata.tertiary,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      TextFormField(
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
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            'Average time',
                            style: MyStyle.tx14Black.copyWith(
                                color: themedata.tertiary,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Transform.flip(
                            flipY: true,
                            child: Icon(
                              Icons.info,
                              size: 12.r,
                              color: themedata.tertiary,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      TextFormField(
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: themedata.tertiary,
                          fontFamily: 'SF Pro Rounded',
                        ),
                        decoration: NewStyle.authInputDecoration.copyWith(
                          hintText: '4 min',
                          fillColor: themeProvider.isDarkMode()
                              ? const Color(0XFF33353C)
                              : MyColor.textFieldFillColor,
                          suffixIcon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: themedata.tertiary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
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
                        ),
                      ),
                      const Text(
                        'Min: 3 000-Max:100 000 000',
                        style: MyStyle.tx14Grey,
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
                                      const SocialSummaryScreen(),
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
