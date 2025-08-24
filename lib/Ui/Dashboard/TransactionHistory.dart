

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

  // Map<dynamic, List> groupByData = {};
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
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    final account = context.watch<AccountProvider>();
    final dashProvider = Provider.of<DashboardProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        leading: BackBtn(
          onTap: () => dashProvider.changeBottomIndex(0),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
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
            account.transGroupByData.isEmpty
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
                          itemCount: account.transGroupByData.length,
                          separatorBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
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
                                child: SizedBox(
                                  height: 0,
                                ),
                              ),
                            );
                          },
                          itemBuilder: (context, i) {
                            String key =
                                account.transGroupByData.keys.elementAt(i);
                            List value = account.transGroupByData[key]!;
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
                              ListView.separated(
                                separatorBuilder: (_, i) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Divider(
                                    color: Colors.grey,
                                    thickness: .2,
                                  ),
                                ),
                                itemCount: value.length,
                                padding: const EdgeInsets.all(0),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  Datum transaction = value[index];
                                  return HistoryCard(transaction: transaction);
                                },
                              ),
                            ]);
                          }),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
