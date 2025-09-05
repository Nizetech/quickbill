import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/card_fund_summary.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/kyc_web.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/virtual_account_creation.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/widget/balance_card.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:jost_pay_wallet/common/text_field.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
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
      'detail': 'Funds should be received after 2 mins of payment',
      'fee': '0.5375%',
    },
    {
      'image': 'assets/images/bank-3.png',
      'title': 'Card Transfer',
      'detail': 'Funds should be received after 2 mins of payment',
      'fee': '1.2%',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Consumer<AccountProvider>(builder: (context, model, _) {
        return SafeArea(
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
                        style: MyStyle.tx18Black
                            .copyWith(color: themedata.tertiary),
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
                  child: Column(
                    children: [
                      if (model.userModel?.user?.virtualAccount == false) ...[
                        _buildDepositMethodCard(
                          context: context,
                          image: 'assets/images/vir_acc.png',
                          themedata: themedata,
                          themeProvider: themeProvider,
                          isRecommended: true,
                          title: 'Virtual Account',
                          detail:
                              'Get a virtual account. Deposit appear almost immediately.',
                          fee: '0.5375%',
                          onTap: () {
                            if (model.userModel?.user?.idVerified == false) {
                              Get.to(const KycWebview());
                              ErrorToast(
                                  'You need to verify your account to create a virtual account');
                              // return;
                            } else {
                              Get.to(
                                const VirtualAccountCreation(),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 10),
                      ],
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return _buildDepositMethodCard(
                            context: context,
                            image: depositMethods[index]['image'],
                            themedata: themedata,
                            themeProvider: themeProvider,
                            title: depositMethods[index]['title'],
                            detail: depositMethods[index]['detail'],
                            fee: depositMethods[index]['fee'],
                            onTap: model.userModel?.user?.isActive == false
                                ? () {
                                    Get.to(() => const KycWebview());
                                  }
                                : () {
                                    if (index == 0) {
                                      _showAmountInputDialog(context,
                                          isCard: false, themedata: themedata);
                                    } else {
                                      _showAmountInputDialog(context,
                                          isCard: true, themedata: themedata);
                                    }
                                  },
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemCount: depositMethods.length,
                      ),
                    ],
                  ),
                )),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildDepositMethodCard({
    required BuildContext context,
    required String image,
    required ColorScheme themedata,
    required ThemeProvider themeProvider,
    required String title,
    required String detail,
    required String fee,
    bool isRecommended = false,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: !themeProvider.isDarkMode()
              ? Color(0xfffCFCFC)
              : Color(0xff171717),
          border: Border.all(
            color: themeProvider.isDarkMode()
                ? MyColor.borderDarkColor.withValues(alpha: .2)
                : MyColor.borderColor.withValues(alpha: .2),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8.8)),
      child: Column(
        children: [
          Row(
            children: [
              if (isRecommended)
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: MyColor.yellowColor.withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Recommended',
                    style: MyStyle.tx12Black.copyWith(
                      color: Color(0xff854D0E),
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              Text(
                '${fee} deposit fee included',
                style: MyStyle.tx12Black.copyWith(
                  color: MyColor.grey03Color,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: themeProvider.isDarkMode()
                        ? MyColor.borderDarkColor.withValues(alpha: .2)
                        : MyColor.borderColor.withValues(alpha: .2),
                    width: 1,
                  ),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Image.asset(
                  image,
                  height: 20,
                ),
              ),
              SizedBox(
                width: 15),
              Expanded(
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          MyStyle.tx16Black.copyWith(color: themedata.tertiary),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      detail,
                      style: MyStyle.tx14Black.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          // Adding the button
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 36,
              // width: 120.w,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: MyColor.greenColor,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Text(
                isRecommended ? 'Activate Now' : 'Deposit Now',
                style: MyStyle.tx14White,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showAmountInputDialog(BuildContext context,
      {required bool isCard, required ColorScheme themedata}) {
    final TextEditingController amountController = TextEditingController();
    final account = Provider.of<AccountProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            'Amount to Deposit',
            style: MyStyle.tx16Black.copyWith(color: themedata.tertiary),
          ),
          content: CustomTextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            text: 'Enter amount',
          ),
          actions: <Widget>[
            CustomButton(
              text: 'Confirm',
              onTap: () {
                final amount = double.tryParse(amountController.text);
                if (amount == null || amount < 0) {
                  Navigator.of(context).pop();
                  ErrorToast('Please enter a valid amount');
                  return;
                }
                if (account.userModel?.user?.idVerified == false &&
                    amount > 20000) {
                  Navigator.of(context).pop();
                  ErrorToast(
                      "You must complete full verification on your account before you can deposit more than 20,000 NGN.");
                  return;
                } else {
                  Navigator.of(context).pop();
                  Get.to(CardFundSummary(
                      amount: amount.toString(), isCard: isCard));
                
                }
              },
            ),
          ],
        );
      },
    );
  }
}
