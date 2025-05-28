import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Models/transactions.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/DashboardProvider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/widget/history_card.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:provider/provider.dart';

class Transactionhistory extends StatefulWidget {
  const Transactionhistory({super.key});

  @override
  State<Transactionhistory> createState() => _TransactionhistoryState();
}

class _TransactionhistoryState extends State<Transactionhistory> {

  Map<dynamic, List> groupByData = {};
  @override
  void initState() {
    super.initState();
    final account = Provider.of<AccountProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (account.transactionModel == null) {
      await account.getTrasactions();
      } else {
        await account.getTrasactions(isLoading: false);
      }
      if (account.transactionModel == null) {
        return;
      } else {
        log('transactionModel: ${account.transactionModel!.data!.length}');
      groupByData = groupBy(
        account.transactionModel!.data!,
        (obj) => obj.transDate.toString().substring(0, 10),
      );
        // Sort by date in descending order
        groupByData = Map.fromEntries(
          groupByData.entries.toList()
            ..sort((a, b) =>
                b.key.compareTo(a.key)), 
        );
        // Sort each group's transactions by time (descending)
        groupByData.forEach((key, value) {
          value.sort((a, b) => b.transDate.compareTo(a.transDate));
        });
      setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    // log('groupByData: $groupByData');
    final dashProvider = Provider.of<DashboardProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        leading: BackBtn(
          onTap: () => dashProvider.changeBottomIndex(0),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer<AccountProvider>(builder: (context, account, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Transaction History',
                style: MyStyle.tx20Grey.copyWith(
                  color: themedata.tertiary,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              groupByData.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Text(
                          'Transactions not found',
                          style: MyStyle.tx20Grey.copyWith(
                            color: themedata.tertiary,
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: RefreshIndicator(
                        onRefresh: () => account.getTrasactions(),
                        child: ListView.separated(
                            itemCount: groupByData.length,
                            separatorBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: DottedBorder(
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
                                ),
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
                                const SizedBox(height: 10),
                                ListView.builder(
                                  itemCount: value.length,
                                  padding: const EdgeInsets.all(0),
                                  shrinkWrap: true,
                                  // reverse: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    Transaction transaction = value[index];
                                    return HistoryCard(
                                        transaction: transaction);
                                  },
                                ),
                              ]);
                            }),
                      ),
                    )
            ],
          ),
        );
      }
      ),
    );
  }
}
