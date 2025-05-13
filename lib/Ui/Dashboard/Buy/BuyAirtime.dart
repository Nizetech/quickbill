import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/BuyAirtimeConfirm.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

import '../DashboardScreen.dart';

class BuyAirtime extends StatefulWidget {
  const BuyAirtime({super.key});

  @override
  State<BuyAirtime> createState() => _BuyAirtimeState();
}

class _BuyAirtimeState extends State<BuyAirtime> {
  final List<Map<String, dynamic>> data = [
    {
      'number': '08165786436',
      'amount': 'N 26,000.00',
      'date': 'June 30th, 11: 37',
      'status': 'Successful',
      'img': 'assets/images/icon-1.png'
    },
    {
      'number': '08165786436',
      'amount': 'N 26,000.00',
      'date': 'June 30th, 11: 37',
      'status': 'Successful',
      'img': 'assets/images/icon-1.png'
    },
    {
      'number': '08165786436',
      'amount': 'N 26,000.00',
      'date': 'June 30th, 11: 37',
      'status': 'Failed',
      'img': 'assets/images/icon-2.png'
    },
    {
      'number': '08165786436',
      'amount': 'N 26,000.00',
      'date': 'June 30th, 11: 37',
      'status': 'Successful',
      'img': 'assets/images/icon-1.png'
    },
    {
      'number': '08165786436',
      'amount': 'N 26,000.00',
      'date': 'June 30th, 11: 37',
      'status': 'Failed',
      'img': 'assets/images/icon-2.png'
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
        padding: const EdgeInsets.only(top: 54, left: 24, right: 24),
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
                    'Buy Airtime',
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
            Container(
              height: 125,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.8,
                    color: themeProvider.isDarkMode()
                        ? MyColor.borderDarkColor
                        : MyColor.borderColor,
                  ),
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        const Text(
                          'Total balance',
                          style: MyStyle.tx12Grey,
                        ),
                        Row(
                          children: [
                            Image.asset('assets/images/currency.png',
                                width: 15, color: themedata.tertiary),
                            Text(
                              '10,000.',
                              style: MyStyle.tx32Black
                                  .copyWith(color: themedata.tertiary),
                            ),
                            Text(
                              '20',
                              style: MyStyle.tx20Grey
                                  .copyWith(color: themedata.tertiary),
                            )
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BuyAirtimeConfirm()))
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: MyColor.greenColor,
                        padding: const EdgeInsets.only(
                            top: 6, bottom: 6, left: 24, right: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Text(
                            "Buy Airtime",
                            style: MyStyle.tx12White,
                          ),
                          Image.asset('assets/images/chevron-left.png')
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Row(
                    children: [
                      Text(
                        'Airtime History',
                        style: MyStyle.tx14Black
                            .copyWith(color: themedata.tertiary),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Image.asset('assets/images/down.png')
                    ],
                  ),
                  const Spacer(),
                  Text('View all',
                      style: MyStyle.tx12Black.copyWith(
                        color: themeProvider.isDarkMode()
                            ? const Color.fromARGB(255, 5, 6, 7)
                            : const Color(0xff30333A),
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            Expanded(
              // child: SingleChildScrollView(
              child: ListView.builder(
                  itemCount: data.length,
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    var list = data[index];
                    return Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        width: 0.4,
                        color: themeProvider.isDarkMode()
                            ? MyColor.borderDarkColor
                            : MyColor.borderColor,
                      ))),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 41,
                                width: 41,
                                padding: EdgeInsets.all(4.r),
                                decoration: BoxDecoration(
                                    color: themeProvider.isDarkMode()
                                        ? const Color(0XFF171717)
                                        : MyColor.grey01Color,
                                    borderRadius: BorderRadius.circular(12.3)),
                                child: Image.asset(
                                  list['img'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    list['number'],
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
                                          : const Color(0xff30333A),
                                    ),
                                  )
                                ],
                              ),
                              const Spacer(),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      list['amount'],
                                      style: MyStyle.tx12Black
                                          .copyWith(color: themedata.tertiary),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          list['status'],
                                          style: MyStyle.tx11Grey.copyWith(
                                              color:
                                                  list['status'] == 'Successful'
                                                      ? MyColor.dark01GreenColor
                                                      : Colors.red,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Container(
                                            width: 68,
                                            decoration: BoxDecoration(
                                                color: themedata.secondary,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Buy again',
                                                    style: MyStyle.tx11Grey
                                                        .copyWith(
                                                            color: MyColor
                                                                .dark01GreenColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                ],
                                              ),
                                            ))
                                      ],
                                    )
                                  ])
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          )
                        ],
                      ),
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
