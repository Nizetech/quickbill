import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Models/transactions.dart';
import 'package:jost_pay_wallet/Provider/Account_Provider.dart';
import 'package:jost_pay_wallet/Provider/DashboardProvider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/widget/history_card.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
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
  Map<dynamic, List> groupByData = {};
  @override
  void initState() {
    super.initState();
    final account = Provider.of<AccountProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (account.transactionModel == null) {
        account.getTrasactions();
      }
      if (account.transactionModel == null) return;
      // groupByData = groupBy(account.transactionModel!,
      //     (obj) => obj['created_at'].substring(0, 10));
      groupByData = groupBy(
        account.transactionModel!.data!,
        (obj) => obj.transDate.toString().substring(0, 10),
      );
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    log('groupByData: $groupByData');
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
            Expanded(
              child: ListView.separated(
                  itemCount: groupByData.length,
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  separatorBuilder: (context, index) {
                    return DottedBorder(
                      child: SizedBox(
                        height: 0,
                      ),
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
                    );
                  },
                  itemBuilder: (context, i) {
                    String key = groupByData.keys.elementAt(i);
                    List value = groupByData[key]!;
                    return Column(children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          isToday(DateTime.parse(key)),
                          style: MyStyle.tx14Black.copyWith(
                            color: themedata.tertiary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListView.builder(
                        itemCount: value.length,
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          Transaction transaction = value[index];
                          return HistoryCard(transaction: transaction);
                        },
                      ),
                    ]);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
