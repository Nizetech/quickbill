import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/DashboardScreen.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Deposit.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:provider/provider.dart';

class AddFunds extends StatefulWidget {
  const AddFunds({super.key});

  @override
  State<AddFunds> createState() => _AddFundsState();
}

class _AddFundsState extends State<AddFunds> {
  final List<Map<String, dynamic>> data = [
    {
      'type': 'Bank Transfer',
      'amount': 'N 26,000.00',
      'date': 'June 30th, 11: 37',
      'status': 'Successful'
    },
    {
      'type': 'USDT',
      'amount': '0.005433467',
      'date': 'June 30th, 11: 37',
      'status': 'Successful'
    },
    {
      'type': 'Card',
      'amount': '0.005433467',
      'date': 'June 30th, 11: 37',
      'status': 'Refunded'
    },
    {
      'type': 'USDT',
      'amount': '0.005433467',
      'date': 'June 30th, 11: 37',
      'status': 'Successful'
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 64.0, // Top padding
          left: 24.0, // Left padding
          right: 24.0,
        ), // Padding around the widget
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Image widget
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: themeProvider.isDarkMode()
                        ? MyColor.borderDarkColor
                        : MyColor.borderColor, // Set the color of the border
                    width: 0.5, // Set the width of the border
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DashboardScreen())),
                      child: Image.asset(
                        'assets/images/arrow_left.png',
                        color: themeProvider.isDarkMode()
                            ? MyColor.mainWhiteColor
                            : MyColor.dark01Color,
                      ),
                    ),
                    const Spacer(), // Adds flexible space between the image and the text
                    Transform.translate(
                      offset: const Offset(-26, 0),
                      child: Text(
                        'Add funds',
                        style: MyStyle.tx18Black
                            .copyWith(color: themedata.tertiary),
                      ),
                    ),
                    const Spacer(), // Adds flexible space after the text
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: themeProvider.isDarkMode()
                            ? MyColor.borderDarkColor
                            : MyColor.borderColor,
                        width: 0.5)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    color: themeProvider.isDarkMode()
                                        ? MyColor.borderDarkColor
                                        : MyColor.borderColor,
                                    width: 0.5))),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/ng-flag.png',
                                    width: 32.7,
                                    height: 32.7,
                                  ),
                                  const Spacer(),
                                  Text(
                                    'NGN',
                                    style: MyStyle.tx28Black.copyWith(
                                        fontSize: 8.5,
                                        color: themedata.tertiary),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                children: [
                                  Image.asset('assets/images/currency.png',
                                      color: themedata.tertiary,
                                      width: 20.4,
                                      height: 20.4),
                                  Text('10,000.00',
                                      style: MyStyle.tx18Black.copyWith(
                                          fontSize: 12.3.sp,
                                          color: themedata.tertiary))
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Add Funds',
                                    style: MyStyle.tx8White.copyWith(
                                        color: MyColor.greenColor,
                                        decoration: TextDecoration.underline,
                                        decorationColor: MyColor.greenColor,
                                        decorationThickness: 1.0),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                left: BorderSide(
                                    color: themeProvider.isDarkMode()
                                        ? MyColor.borderDarkColor
                                        : MyColor.borderColor,
                                    width: 0.5))),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/us-flag.png',
                                    width: 32.7,
                                    height: 32.7,
                                  ),
                                  const Spacer(),
                                  Text(
                                    'USD',
                                    style: MyStyle.tx28Black.copyWith(
                                        fontSize: 8.5.sp,
                                        color: themedata.tertiary),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                children: [
                                  Image.asset('assets/images/us-currency.png',
                                      width: 20.4,
                                      height: 20.4,
                                      color: themedata.tertiary),
                                  Text('10,000.00',
                                      style: MyStyle.tx18Black.copyWith(
                                          fontSize: 12.3.sp,
                                          color: themedata.tertiary)),
                                  Image.asset('assets/images/equal.png',
                                      width: 9,
                                      height: 9,
                                      color: themedata.tertiary),
                                  Text(
                                    '150,000.00 NGN',
                                    style: MyStyle.tx8White.copyWith(
                                        color: themeProvider.isDarkMode()
                                            ? const Color(0XFFCBD2EB)
                                            : const Color(0xff30333A)),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Available Balance',
                                    style: MyStyle.tx8White
                                        .copyWith(color: MyColor.greenColor),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                    // boxShadow: [MyStyle.widgetShadow]),
                    boxShadow: themeProvider.isDarkMode()
                        ? null
                        : [MyStyle.widgetShadow]),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bank Details',
                              style: MyStyle.tx12Black.copyWith(
                                  color: themeProvider.isDarkMode()
                                      ? const Color(0XFFCBD2EB)
                                      : const Color(0xff30333A)),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                Text(
                                  '4578907653',
                                  style: MyStyle.tx18Black
                                      .copyWith(color: themedata.tertiary),
                                ),
                                const Spacer(),
                                Container(
                                  height: 24,
                                  width: 24,
                                  // padding: const EdgeInsets.all(13),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: themedata.secondary,
                                      shape: BoxShape.circle),
                                  child: Image.asset(
                                    "assets/images/copy.png",
                                    height: 16,
                                    width: 16,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              'Bank Name',
                              style: MyStyle.tx12Black.copyWith(
                                  color: themeProvider.isDarkMode()
                                      ? const Color(0XFFCBD2EB)
                                      : const Color(0xff30333A)),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Jostpay wallet',
                              style: MyStyle.tx18Black
                                  .copyWith(color: themedata.tertiary),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          decoration: BoxDecoration(
                              color: themedata.secondary,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    // padding: const EdgeInsets.all(13),
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                        color: MyColor.darkGreenColor,
                                        shape: BoxShape.circle),
                                    child: Image.asset(
                                      "assets/images/Arrow up-right.png",
                                      height: 16,
                                      width: 16,
                                    ),
                                  ),
                                  const Spacer(),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        10), // Optional: Adds rounded clipping
                                    child: Transform.translate(
                                      offset: const Offset(4.0,
                                          0.0), // Translate 10 pixels to the right and 20 pixels down
                                      child: Image.asset(
                                        'assets/images/vector.png',
                                        width: 62.5,
                                        height: 68.7,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Deposit())),
                                child: const Text(
                                  'Explore other options',
                                  style: MyStyle.tx12GreenUnder,
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            const SizedBox(
              height: 32,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: themeProvider.isDarkMode()
                              ? MyColor.borderDarkColor
                              : MyColor.borderColor,
                          width: 0.5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/filter-icon.png',
                          width: 16,
                          height: 16,
                          color: themeProvider.isDarkMode()
                              ? const Color(0XFFCBD2EB)
                              : const Color(0xff30333A),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Filters',
                          style: MyStyle.tx12Black.copyWith(
                              color: themeProvider.isDarkMode()
                                  ? const Color(0XFFCBD2EB)
                                  : const Color(0xff30333A)),
                        )
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  'View all',
                  style: MyStyle.tx12Black.copyWith(
                      color: themeProvider.isDarkMode()
                          ? const Color(0XFFCBD2EB)
                          : const Color(0xff30333A)),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Deposit History',
                style: MyStyle.tx14Black.copyWith(color: themedata.tertiary),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              // child: SingleChildScrollView(
              child: ListView.builder(
                  itemCount: data.length,
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    var list = data[index];
                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 41,
                              width: 41,
                              decoration: BoxDecoration(
                                  color: themedata.secondary,
                                  borderRadius: BorderRadius.circular(12.3)),
                              child: Image.asset(
                                  'assets/images/dashboard/money-send-circle.png'),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  list['type'],
                                  style: MyStyle.tx12Black
                                      .copyWith(color: themedata.tertiary),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  list['date'],
                                  style: MyStyle.tx12Black.copyWith(
                                      color: themeProvider.isDarkMode()
                                          ? const Color(0XFFCBD2EB)
                                          : const Color(0xff30333A)),
                                )
                              ],
                            ),
                            const Spacer(),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    list['amount'],
                                    style: MyStyle.tx12Black
                                        .copyWith(color: themedata.tertiary),
                                  ),
                                  Container(
                                      width: 91,
                                      decoration: BoxDecoration(
                                          color: list['status'] == 'Successful'
                                              ? themedata.secondary
                                              : MyColor.purpleColor
                                                  .withOpacity(0.22),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              list['status'],
                                              style: MyStyle.tx12Black.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: list['status'] ==
                                                          'Successful'
                                                      ? MyColor.dark01GreenColor
                                                      : MyColor
                                                          .darkPurpleColor),
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Image.asset(list['status'] ==
                                                    'Successful'
                                                ? 'assets/images/down-green.png'
                                                : 'assets/images/down-purple.png')
                                          ],
                                        ),
                                      ))
                                ])
                          ],
                        ),
                        const SizedBox(
                          height: 32,
                        )
                      ],
                    );
                  }),
              // ),
            )
          ],
        ),
      ),
    );
  }
}
