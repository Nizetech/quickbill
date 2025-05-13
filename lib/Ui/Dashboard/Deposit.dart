
import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

import '../../Values/MyColor.dart';
import '../Dashboard/DashboardScreen.dart';

class Deposit extends StatefulWidget {
  const Deposit({super.key});

  @override
  State<Deposit> createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  final bool _isSwitched = false;
  final List<Map<String, dynamic>> banks = [
    {
      'image': 'assets/images/bank-1.png',
      'title': 'Bank Transfer',
      'detail': 'Funds should be received after 2 mins of payment',
    },
    {
      'image': 'assets/images/bank-2.png',
      'title': 'Bank Transfer',
      'detail': 'Funds should be received after 2 mins of payment',
    },
    {
      'image': 'assets/images/bank-3.png',
      'title': 'Bank Transfer',
      'detail': 'Funds should be received after 2 mins of payment',
    },
    {
      'image': 'assets/images/bank-4.png',
      'title': 'Bank Transfer',
      'detail': 'Funds should be received after 2 mins of payment',
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
      // backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 68, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                const Spacer(),
                Transform.translate(
                  offset: const Offset(-20, 0),
                  child: Text(
                    'Deposit',
                    style:
                        MyStyle.tx18Black.copyWith(color: themedata.tertiary),
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(
              height: 30,
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
                                          fontSize: 12.3,
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
                                  Image.asset('assets/images/us-currency.png',
                                      color: themedata.tertiary,
                                      width: 20.4,
                                      height: 20.4),
                                  Text('10,000.00',
                                      style: MyStyle.tx18Black.copyWith(
                                          fontSize: 12.3,
                                          color: themedata.tertiary)),
                                  Image.asset(
                                    'assets/images/equal.png',
                                    color: themedata.tertiary,
                                    width: 9,
                                    height: 9,
                                  ),
                                  Text(
                                    '150,000.00 NGN',
                                    style: MyStyle.tx8White
                                        .copyWith(color: themedata.tertiary),
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
              height: 30,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 18),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: themeProvider.isDarkMode()
                            ? MyColor.borderDarkColor
                            : MyColor.borderColor,
                        width: 1),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    for (int i = 0; i < banks.length; i++) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            boxShadow: const [MyStyle.widgetShadow],
                            borderRadius: BorderRadius.circular(8.8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: themedata.secondary
                                      .withValues(alpha: 0.7),
                                  borderRadius: BorderRadius.circular(13.5)),
                              child: Image.asset(banks[i]['image']),
                            ),
                            // SizedBox(
                            //   width: 48.w,
                            // ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    banks[i]['title'] ?? 'No Title',
                                    style: MyStyle.tx16Black
                                        .copyWith(color: themedata.tertiary),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    banks[i]['detail'] ?? 'No Detail',
                                    style: MyStyle.tx14Black.copyWith(
                                      color: MyColor.greyColor,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Adding the button
                                  Container(
                                    height: 36,
                                    // width: 120.w,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: MyColor.greenColor,
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: const Text(
                                      'Deposit Now',
                                      style: MyStyle.tx14White,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ]
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
