import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Home/bank_werbview.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Home/deposit_details.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/appbar.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:jost_pay_wallet/constants/api_constants.dart';
import 'package:jost_pay_wallet/constants/constants.dart';
import 'package:provider/provider.dart';

class DepositSummary extends StatefulWidget {
  final String amount;
  final bool isCard;
  const DepositSummary({super.key, required this.amount, this.isCard = false});

  @override
  State<DepositSummary> createState() => _DepositSummaryState();
}

class _DepositSummaryState extends State<DepositSummary> {
  String bankCharge = '';
  String amount = '';
  // final box = Hive.box(kAppName);
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     setState(() {
  //       bankCharge = (num.parse(widget.amount) *
  //               (widget.isCard ? 1.2 / 100 : 0.54 / 100))
  //           .toString();
  //       amount = (num.parse(widget.amount) - num.parse(bankCharge)).toString();
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Deposit wallet'),
      body: Consumer2<AccountProvider, ServiceProvider>(
          builder: (context, model, service, _) {
        return Padding(
          padding: const EdgeInsets.only(top: 10, left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Review & pay',
                style: MyStyle.tx16Black,
              ),
              Text(
                'Review transactions',
                style: MyStyle.tx16Black.copyWith(
                  fontWeight: FontWeight.w400,
                  color: MyColor.grey,
                ),
              ),
              const SizedBox(height: 50),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'You are about tu fund your wallet with',
                          style: MyStyle.tx16Black.copyWith(
                            fontWeight: FontWeight.w400,
                            color: MyColor.grey,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '₦ ${formatNumber(num.parse(widget.amount))}',
                          style: MyStyle.tx16Black.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Image.asset(
                    widget.isCard
                        ? 'assets/images/card_fund.png'
                        : 'assets/images/manual_fund.png',
                    height: 100,
                  ),
                ],
              ),
              Spacer(),
              CustomButton(
                text: 'Fund Wallet',
                onTap: widget.isCard
                    ? () async {
                        model.cardDeposit(
                            amount: int.parse(widget.amount.split('.')[0]));
                      }
                    : () => Get.to(
                          DepositDetails(
                            amount: widget.amount,
                          ),
                        ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        );
      }),
    );
  }
}
