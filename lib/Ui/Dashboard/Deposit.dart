import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/bank_transfer.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/deposit_details.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/widget/balance_card.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

import '../../Values/MyColor.dart';


class Deposit extends StatefulWidget {
  const Deposit({super.key});

  @override
  State<Deposit> createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  // final bool _isSwitched = false;
  final List<Map<String, dynamic>> depositMethods = [
    {
      'image': 'assets/images/bank_i.png',
      'title': 'Bank Transfer',
      'detail': 'Deposit: 0% fee | Credit in 24hrs',
    },
    {
      'image': 'assets/images/bank-3.png',
      'title': 'Add via Card',
      'detail': 'Funds should be received after 2 mins of payment',
    },
    {
      'image': 'assets/images/ussd.png',
      'title': 'Add Manually',
      'detail': 'Deposit: 0% fee | Credit in 24hrs',
    },
    // {
    //   'image': 'assets/images/ussd.png',
    //   'title': 'USSD',
    //   'detail': 'Funds should be received after 2 mins of payment',
    // },
   
    // {
    //   'image': 'assets/images/tether.png',
    //   'title': 'USDT',
    //   'detail': 'Funds should be received after 5 mins of payment',
    // },
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              BalanceCard(),
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
                      for (int i = 0; i < depositMethods.length; i++) ...[
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
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: themedata.secondary
                                        .withValues(alpha: 0.7),
                                    borderRadius: BorderRadius.circular(13.5)),
                                child: Image.asset(depositMethods[i]['image']),
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
                                      depositMethods[i]['title'] ?? 'No Title',
                                      style: MyStyle.tx16Black
                                          .copyWith(color: themedata.tertiary),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      depositMethods[i]['detail'] ??
                                          'No Detail',
                                      style: MyStyle.tx14Black.copyWith(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    // Adding the button
                                    GestureDetector(
                                      onTap: () {
                                        if (i == 0) {
                                          _showAmountInputDialog(context);
                                        } else {
                                          Get.to(DepositDetails(
                                            title: depositMethods[i]['title'],
                                          ));
                                        }
                                      },
                                      child: Container(
                                        height: 36,
                                        // width: 120.w,
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        decoration: BoxDecoration(
                                          color: MyColor.greenColor,
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: const Text(
                                          'Deposit Now',
                                          style: MyStyle.tx14White,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              )),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showAmountInputDialog(BuildContext context) {
    final TextEditingController amountController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Amount'),
          content: TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter amount',
              border: OutlineInputBorder(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Deposit'),
              onPressed: () {
                final amount = double.tryParse(amountController.text);
                if (amount != null && amount > 0) {
                  Navigator.of(context).pop();
                  Get.to(BankTransferScreen(amount: amount));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a valid amount'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
