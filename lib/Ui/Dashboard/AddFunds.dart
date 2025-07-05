import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/widget/balance_card.dart';
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
      body: Consumer<AccountProvider>(builder: (context, account, _) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10, // Top padding
              left: 24.0, // Left padding
              right: 24.0,
            ), // Padding around the widget
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: themeProvider.isDarkMode()
                            ? MyColor.borderDarkColor
                            : MyColor
                                .borderColor, // Set the color of the border
                        width: 0.5, // Set the width of the border
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
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
                        const Spacer(), // Adds flexible space between the image and the text
                        Transform.translate(
                          offset: const Offset(-26, 0),
                          child: Text(
                            'Wallet Activation',
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: MyColor.greenColor.withValues(alpha: 0.1),
                            border: Border.all(
                                color: MyColor.greenColor, width: 0.5),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                              'Choose a bank to enable deposits and access to jostPay Services',
                              textAlign: TextAlign.center,
                              style: MyStyle.tx16Gray.copyWith(
                                color: MyColor.greenColor,
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BalanceCard(
                          hasAddFund: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              color: !themeProvider.isDarkMode()
                                  ? Color(0xfffCFCFC)
                                  : Color(0xff171717),
                              border: Border.all(
                                  color: themeProvider.isDarkMode()
                                      ? MyColor.borderDarkColor
                                      : MyColor.borderColor,
                                  width: 0.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 30, 20, 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 78,
                                        width: 78,
                                        padding: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: !themeProvider.isDarkMode()
                                              ? Colors.white
                                              : Colors.black,
                                          border: Border.all(
                                              color: themeProvider.isDarkMode()
                                                  ? MyColor.borderDarkColor
                                                  : MyColor.whiteColor,
                                              width: 0.5),
                                        ),
                                        child: Image.asset(
                                          'assets/images/fidelity.png',
                                        ),
                                      ),
                                      Container(
                                        height: 78,
                                        width: 78,
                                        padding: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: !themeProvider.isDarkMode()
                                              ? Colors.white
                                              : Colors.black,
                                          border: Border.all(
                                              color: themeProvider.isDarkMode()
                                                  ? MyColor.borderDarkColor
                                                  : MyColor.borderColor,
                                              width: 0.5),
                                        ),
                                        child: Image.asset(
                                            'assets/images/wema.png'),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(10),
                                    ),
                                    color: !themeProvider.isDarkMode()
                                        ? Colors.white
                                        : Colors.black,
                                    border: Border.all(
                                        color: themeProvider.isDarkMode()
                                            ? MyColor.borderDarkColor
                                            : MyColor.borderColor,
                                        width: 0.5),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset('assets/images/lock.png',
                                          height: 20,
                                          width: 20,
                                          color: themeProvider.isDarkMode()
                                              ? Colors.white
                                              : Colors.black),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          'Wallet are managed & Powered by your preferred bank',
                                          style: MyStyle.tx12White.copyWith(
                                              fontSize: 12,
                                              color: themedata.tertiary),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
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
                            style: MyStyle.tx14Black
                                .copyWith(color: themedata.tertiary),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                            itemCount: data.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
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
                                            borderRadius:
                                                BorderRadius.circular(12.3)),
                                        child: Image.asset(
                                            'assets/images/dashboard/money-send-circle.png'),
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            list['type'],
                                            style: MyStyle.tx12Black.copyWith(
                                                color: themedata.tertiary),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            list['date'],
                                            style: MyStyle.tx12Black.copyWith(
                                                color: themeProvider
                                                        .isDarkMode()
                                                    ? const Color(0XFFCBD2EB)
                                                    : const Color(0xff30333A)),
                                          )
                                        ],
                                      ),
                                      const Spacer(),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              list['amount'],
                                              style: MyStyle.tx12Black.copyWith(
                                                  color: themedata.tertiary),
                                            ),
                                            Container(
                                                width: 91,
                                                decoration: BoxDecoration(
                                                    color: list['status'] ==
                                                            'Successful'
                                                        ? themedata.secondary
                                                        : MyColor.purpleColor
                                                            .withOpacity(0.22),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 2),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        list['status'],
                                                        style: MyStyle.tx12Black.copyWith(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: list['status'] ==
                                                                    'Successful'
                                                                ? MyColor
                                                                    .dark01GreenColor
                                                                : MyColor
                                                                    .darkPurpleColor),
                                                      ),
                                                      const SizedBox(
                                                        width: 4,
                                                      ),
                                                      Image.asset(list[
                                                                  'status'] ==
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
                            })
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
      ),
    );
  }
}
