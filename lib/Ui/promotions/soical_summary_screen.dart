import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/bottom_nav.dart';
import 'package:jost_pay_wallet/Ui/promotions/social_success_screen.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:provider/provider.dart';

class SocialSummaryScreen extends StatefulWidget {
  const SocialSummaryScreen({super.key});

  @override
  State<SocialSummaryScreen> createState() => _SocialSummaryScreenState();
}

class _SocialSummaryScreenState extends State<SocialSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 54, left: 24, right: 24),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNav())),
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
                    'Summary',
                    style: MyStyle.tx18Black.copyWith(
                      color: themedata.tertiary,
                    ),
                  ),
                ),
                const Spacer(), // Adds flexible space after the text
              ],
            ),
            SizedBox(
              height: 78.h,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  boxShadow: const [MyStyle.widgetShadow],
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SvgPicture.asset(
                      'assets/images/svg/youtube.svg',
                      height: 85.r,
                      width: 60.r,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Youtube Package Summary',
                    style: MyStyle.tx14Black.copyWith(
                      fontFamily: 'Roboto',
                      color: themedata.tertiary,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Package',
                        style: MyStyle.tx12Grey,
                      ),
                      const Spacer(),
                      Text(
                        'Youtube views [Min 3K] [Speed:100K+/Day]',
                        style: MyStyle.tx12Black.copyWith(
                            color: themedata.tertiary,
                            fontFamily: 'SF Pro Rounded'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Link',
                        style: MyStyle.tx12Grey,
                      ),
                      const Spacer(),
                      Text(
                        'https://youtu.be/iiOHw.....zmcmULsNQWlc7OBs',
                        style: MyStyle.tx12Black.copyWith(
                            color: themedata.tertiary,
                            fontFamily: 'SF Pro Rounded'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Quantity',
                        style: MyStyle.tx12Grey,
                      ),
                      const Spacer(),
                      Text(
                        '3 000 000',
                        style: MyStyle.tx12Black.copyWith(
                            color: themedata.tertiary,
                            fontFamily: 'SF Pro Rounded'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Average Time',
                        style: MyStyle.tx12Grey,
                      ),
                      const Spacer(),
                      Text(
                        '4 minutes',
                        style: MyStyle.tx12Black.copyWith(
                            color: themedata.tertiary,
                            fontFamily: 'SF Pro Rounded'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Changes',
                        style: MyStyle.tx12Grey,
                      ),
                      const Spacer(),
                      Text(
                        'No Changes',
                        style: MyStyle.tx12Black.copyWith(
                            color: themedata.tertiary,
                            fontFamily: 'SF Pro Rounded'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: double.infinity, // Full width of the screen
                    height: 4, // Adjust height as needed
                    child: Stack(
                      children: [
                        // Bottom border
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: DottedBorder(
                            color: themeProvider.isDarkMode()
                                ? MyColor.borderDarkColor
                                : MyColor.borderColor,
                            strokeWidth: 1,
                            dashPattern: const [
                              6,
                              3
                            ], // Dash pattern: 6 units line, 3 units space
                            customPath: (size) => Path()
                              ..moveTo(0, 0)
                              ..lineTo(size.width, 0),
                            child: Container(
                              height:
                                  0, // The container for the border can have a height of 0
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Amount',
                        style: MyStyle.tx12Grey,
                      ),
                      const Spacer(),
                      Text(
                        '\$3000',
                        style: MyStyle.tx14Black.copyWith(
                            fontWeight: FontWeight.w600,
                            color: themedata.tertiary,
                            fontFamily: 'SF Pro Rounded'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 47.h,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: MyColor.greenColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SocialSuccessScreen()));
                },
                child: Text(
                  "Confirm",
                  style: NewStyle.btnTx16SplashBlue
                      .copyWith(color: NewColor.mainWhiteColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
