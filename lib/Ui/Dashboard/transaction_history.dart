

import 'package:flutter/material.dart';
import 'package:quick_bills/Models/transactions.dart';
import 'package:quick_bills/Provider/account_provider.dart';
import 'package:quick_bills/Provider/dashboard_provider.dart';
import 'package:quick_bills/Ui/Dashboard/Home/widget/history_card.dart';
import 'package:quick_bills/Values/Helper/helper.dart';
import 'package:quick_bills/Values/MyColor.dart';
import 'package:quick_bills/Values/MyStyle.dart';
import 'package:quick_bills/common/appbar.dart';
import 'package:provider/provider.dart';

class Transactionhistory extends StatefulWidget {
  const Transactionhistory({super.key});

  @override
  State<Transactionhistory> createState() => _TransactionhistoryState();
}
class _TransactionhistoryState extends State<Transactionhistory> {
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
    final account = context.watch<AccountProvider>();
    final dashProvider = Provider.of<DashboardProvider>(context, listen: true);
    return Scaffold(
      appBar: appBar(
        onTap: () => dashProvider.changeBottomIndex(0),
        title: 'Transaction History',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
            account.transGroupByData.isEmpty
                ? Expanded(
                    child: Center(
                      child: Text(
                        'Transactions not found',
                        style: MyStyle.tx20Grey.copyWith(
                          color: MyColor.mainWhiteColor,
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => account.getTrasactions(),
                      child: ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          itemCount: account.transGroupByData.length,
                          separatorBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Divider(
                                color: Colors.grey,
                                thickness: .2,
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
                                    color: MyColor.blackColor,
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
                                  AllTransaction transaction = value[index];
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
