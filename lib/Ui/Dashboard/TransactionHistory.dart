import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Provider/DashboardProvider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';


class Transactionhistory extends StatefulWidget {
  const Transactionhistory({super.key});

  @override
  State<Transactionhistory> createState() => _TransactionhistoryState();
}

class _TransactionhistoryState extends State<Transactionhistory> {
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

    final dashProvider = Provider.of<DashboardProvider>(context, listen: true);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 68, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => dashProvider.changeBottomIndex(0),
                  child: Image.asset(
                    'assets/images/arrow_left.png',
                    color: themeProvider.isDarkMode()
                        ? MyColor.mainWhiteColor
                        : MyColor.dark01Color,
                  ),
                ),
                const Spacer(),
                const Text(
                  'Download',
                  style: MyStyle.tx18Green,
                ), // Adds flexible space after the text
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text(
                  'Transaction History',
                  style: MyStyle.tx20Grey.copyWith(
                    color: themedata.tertiary,
                  ),
                ),
                const Spacer(),
                Image.asset(
                  'assets/images/search.png',
                  color: themedata.tertiary,
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Today, Jul 02',
                        style: MyStyle.tx14Black.copyWith(
                          color: themedata.tertiary,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 400, // Set a fixed height here
                      child: ListView.builder(
                        itemCount: data.length,
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
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
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Container(
                                      height: 41,
                                      width: 41,
                                      decoration: BoxDecoration(
                                        // color: MyColor.grey01Color,
                                        borderRadius:
                                            BorderRadius.circular(12.3),
                                      ),
                                      child: Image.asset(list['img']),
                                    ),
                                    const SizedBox(width: 6),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(list['number'],
                                            style: MyStyle.tx12Black.copyWith(
                                                color: themedata.tertiary)),
                                        const SizedBox(height: 4),
                                        Text(list['date'],
                                            style: MyStyle.tx12Black.copyWith(
                                                color: themeProvider
                                                        .isDarkMode()
                                                    ? const Color(0XFFCBD2EB)
                                                    : const Color(0xff30333A))),
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(list['amount'],
                                            style: MyStyle.tx12Black.copyWith(
                                                color: themedata.tertiary)),
                                        Row(
                                          children: [
                                            Text(
                                              list['status'],
                                              style: MyStyle.tx11Grey.copyWith(
                                                color: list['status'] ==
                                                        'Successful'
                                                    ? MyColor.dark01GreenColor
                                                    : Colors.red,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          );
                        },
                      ),
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
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Yesterday, Jul 01',
                        style: MyStyle.tx14Black.copyWith(
                          color: themedata.tertiary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 400, // Set a fixed height here
                      child: ListView.builder(
                        itemCount: data.length,
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
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
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Container(
                                      height: 41,
                                      width: 41,
                                      decoration: BoxDecoration(
                                        // color: MyColor.grey01Color,
                                        borderRadius:
                                            BorderRadius.circular(12.3),
                                      ),
                                      child: Image.asset(list['img']),
                                    ),
                                    const SizedBox(width: 6),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(list['number'],
                                            style: MyStyle.tx12Black.copyWith(
                                                color: themedata.tertiary)),
                                        const SizedBox(height: 4),
                                        Text(list['date'],
                                            style: MyStyle.tx12Black.copyWith(
                                                color: themeProvider
                                                        .isDarkMode()
                                                    ? const Color(0XFFCBD2EB)
                                                    : const Color(0xff30333A))),
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(list['amount'],
                                            style: MyStyle.tx12Black.copyWith(
                                                color: themedata.tertiary)),
                                        Row(
                                          children: [
                                            Text(
                                              list['status'],
                                              style: MyStyle.tx11Grey.copyWith(
                                                color: list['status'] ==
                                                        'Successful'
                                                    ? MyColor.dark01GreenColor
                                                    : Colors.red,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
