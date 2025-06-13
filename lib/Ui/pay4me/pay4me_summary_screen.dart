import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/pay4me/pay4me_screen.dart';
import 'package:jost_pay_wallet/Ui/pay4me/pay4me_success_screen.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:provider/provider.dart';

class Pay4meSummaryScreen extends StatefulWidget {
  final Map data;
  const Pay4meSummaryScreen({super.key, required this.data});

  @override
  State<Pay4meSummaryScreen> createState() => _Pay4meSummaryScreenState();
}

class _Pay4meSummaryScreenState extends State<Pay4meSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Consumer<ServiceProvider>(builder: (context, model, _) {
        return Padding(
          padding: const EdgeInsets.only(top: 54, left: 24, right: 24),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Get.back(),
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
                      'Transaction summary',
                      style: MyStyle.tx18Black.copyWith(
                        color: themedata.tertiary,
                      ),
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
                        height: 46.h,
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
                            const CompanyCard(),
                            SizedBox(
                              height: 24.h,
                            ),
                            Text(
                              'Payment Preview',
                              style: MyStyle.tx14Black.copyWith(
                                  fontFamily: 'Roboto',
                                  color: themedata.tertiary),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'We pay with',
                                  style: MyStyle.tx12Grey,
                                ),
                                const Spacer(),
                                // SvgPicture.asset(
                                //   'assets/images/svg/paypal.svg',
                                //   height: 16.r,
                                //   width: 16.r,
                                // ),
                                Text(
                                  widget.data['payOption'] == 0
                                      ? 'Paypal'
                                      : "Visa & Mastercard",
                                  style: MyStyle.tx14Black.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: themedata.tertiary,
                                  ),
                                ),
                              ],
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
                                  '${widget.data['amount']} USD',
                                  style: MyStyle.tx12Black.copyWith(
                                      fontWeight: FontWeight.w500,
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
                                  'Pay from',
                                  style: MyStyle.tx12Grey,
                                ),
                                const Spacer(),
                                Text(
                                  'Main wallet',
                                  style: MyStyle.tx12Black.copyWith(
                                      fontWeight: FontWeight.w500,
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
                                  'Invoice link',
                                  style: MyStyle.tx12Grey,
                                ),
                                const Spacer(flex: 1),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    widget.data['link'],
                                    textAlign: TextAlign.right,
                                    style: MyStyle.tx12Black.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: themedata.tertiary,
                                        fontFamily: 'SF Pro Rounded'),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Username',
                                  style: MyStyle.tx12Grey,
                                ),
                                const Spacer(),
                                Text(
                                  widget.data['username'],
                                  style: MyStyle.tx12Black.copyWith(
                                      fontWeight: FontWeight.w500,
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
                                  'Password',
                                  style: MyStyle.tx12Grey,
                                ),
                                const Spacer(),
                                Text(
                                  widget.data['pwd'],
                                  style: MyStyle.tx12Black.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: themedata.tertiary,
                                      fontFamily: 'SF Pro Rounded'),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            SizedBox(
                              width:
                                  double.infinity, // Full width of the screen
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
                                  'You pay',
                                  style: MyStyle.tx12Grey,
                                ),
                                const Spacer(),
                                Text(
                                  // '55 USD',
                                  "₦ ${formatNumber(widget.data['total'])}",
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
                        height: 43.h,
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
                                    'Please note:',
                                    style: MyStyle.tx14Black.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: MyColor.splashBtn),
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  const Text(
                                    '* For your security, please change your password after your order has been completed.\n\n* JostPay is not responsible for anyunathorized access once your services have been delivered and paid for.',
                                    style: MyStyle.tx14Grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 88.h,
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
                            model.buyPay4Me({
                              "usd_amount": widget.data['amount'],
                              "payment_option": widget.data['payOption'] == 0
                                  ? "paypal"
                                  : "card",
                              "invoice_link": widget.data['link'],
                              "account_username": widget.data['username'],
                              "account_password": widget.data['pwd'],
                            });
                          },
                          child: Text(
                            "Confirm",
                            style: NewStyle.btnTx16SplashBlue
                                .copyWith(color: NewColor.mainWhiteColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 43.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
