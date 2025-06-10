import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/DashboardProvider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:provider/provider.dart';

import '../../Values/MyColor.dart';
import '../../Values/NewColor.dart';

class Helpsupport extends StatefulWidget {
  const Helpsupport({super.key});

  @override
  State<Helpsupport> createState() => _HelpsupportState();
}

class _HelpsupportState extends State<Helpsupport> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final dashProvider = Provider.of<DashboardProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 68, horizontal: 24),
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
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Account Settings',
                          style: MyStyle.tx18Black
                              .copyWith(color: themedata.tertiary),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                              top: 24, left: 24, bottom: 24),
                          decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: themeProvider.isDarkMode()
                                      ? MyColor.borderDarkColor
                                      : MyColor
                                          .transparentColor, // Set the color of the border
                                  width: 0.5, // Set the width of the border
                                ),
                              ),
                              color: Theme.of(context).scaffoldBackgroundColor,
                              boxShadow: themeProvider.isDarkMode()
                                  ? null
                                  : const [MyStyle.widgetShadow],
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset('assets/images/support.png'),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    // Wrap the Container with Expanded
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text('Customer Support',
                                              style: MyStyle.tx22Green.copyWith(
                                                  color: themedata.tertiary)),
                                          Text('AVG.Response time: 2mins',
                                              style: MyStyle.tx12Black.copyWith(
                                                  color: themeProvider
                                                          .isDarkMode()
                                                      ? const Color(0XFFCBD2EB)
                                                      : const Color(
                                                          0xff30333A))),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          SizedBox(
                                            width: double
                                                .infinity, // Full width of the screen
                                            height:
                                                4, // Adjust height as needed
                                            child: Stack(
                                              children: [
                                                // Bottom border
                                                Positioned(
                                                  bottom: 0,
                                                  left: 0,
                                                  right: 0,
                                                  child: DottedBorder(
                                                    color: themeProvider
                                                            .isDarkMode()
                                                        ? MyColor
                                                            .borderDarkColor
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
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.back();
                                  dashProvider.changeBottomIndex(9);
                                },
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 106,
                                    ),
                                    const Text(
                                      'Live chat Faster replies',
                                      style: MyStyle.tx12Green,
                                    ),
                                    Image.asset(
                                      'assets/images/arrow-right-g.png',
                                      width: 16,
                                      height: 16,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'You can also reach us here',
                          style: MyStyle.tx18Black
                              .copyWith(color: themedata.tertiary),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: themeProvider.isDarkMode()
                                      ? MyColor.borderDarkColor
                                      : MyColor.borderColor,
                                  width: 1),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () => openEmail('info@jostpay.com'),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 42,
                                      height: 42,
                                      decoration: BoxDecoration(
                                          color: themedata.secondary
                                              .withValues(alpha: 0.8),
                                          borderRadius:
                                              BorderRadius.circular(12.3)),
                                      child: Image.asset(
                                          'assets/images/google.png'),
                                    ),
                                    const SizedBox(width: 16),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Support Ticket',
                                          style: MyStyle.tx16Black.copyWith(
                                              color: themedata.tertiary),
                                        ),
                                        const Text(
                                          'Please provide a concise description\nof the problem you are experiencing\nto Help@Jostpay.com',
                                          style: MyStyle.tx12Grey,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () => openWhatsApp('09035899595'),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 42,
                                      height: 42,
                                      decoration: BoxDecoration(
                                          color: themedata.secondary
                                              .withValues(alpha: 0.8),
                                          borderRadius:
                                              BorderRadius.circular(12.3)),
                                      child: Image.asset(
                                          'assets/images/whatsapp.png'),
                                    ),
                                    const SizedBox(width: 16),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Whatsapp",
                                          style: MyStyle.tx16Black.copyWith(
                                              color: themedata.tertiary),
                                        ),
                                        const Text(
                                          'Chat directly with one of our support\nteams, average response within\n5mins.',
                                          style: MyStyle.tx12Grey,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          'Frequently Asked Questions',
                          style: MyStyle.tx18Black
                              .copyWith(color: themedata.tertiary),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: themeProvider.isDarkMode()
                                      ? MyColor.borderDarkColor
                                      : MyColor.borderColor,
                                  width: 1),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'How do I change my account email?',
                                style: MyStyle.tx18Black
                                    .copyWith(color: themedata.tertiary),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "You can log in to your account from the Home page navigate to my Profile, click edit my info you will be prompt to a page where you can edit your email.",
                                style: MyStyle.tx14Grey,
                              )
                            ],
                          ),
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
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: themeProvider.isDarkMode()
                                      ? MyColor.borderDarkColor
                                      : MyColor.borderColor,
                                  width: 1),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'How do i change my password',
                                style: MyStyle.tx18Black
                                    .copyWith(color: themedata.tertiary),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "To update your password to a new one go to Home page click my profile and navigate to settings click change password from settings you will be prompt to a page where you can change your password",
                                style: MyStyle.tx14Grey,
                              )
                            ],
                          ),
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
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: themeProvider.isDarkMode()
                                      ? MyColor.borderDarkColor
                                      : MyColor.borderColor,
                                  width: 1),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'How do I view my payment history?',
                                style: MyStyle.tx18Black
                                    .copyWith(color: themedata.tertiary),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "To view your payment history, log in to your account and go to the 'Payment History' or 'Transaction Histor' section from the home page",
                                style: MyStyle.tx14Grey,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              Get.back();
                              dashProvider.changeBottomIndex(8);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: MyColor.greenColor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              "Learn More",
                              style: NewStyle.btnTx16SplashBlue
                                  .copyWith(color: NewColor.mainWhiteColor),
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
                ],
              ))
        ],
      ),
    );
  }
}
