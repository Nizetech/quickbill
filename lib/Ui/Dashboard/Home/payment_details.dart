import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/appbar.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:provider/provider.dart';

class PaymentPayment extends StatelessWidget {
  final String amount;
  final String bankId;
  const PaymentPayment({super.key, required this.amount, required this.bankId});

  @override
  Widget build(BuildContext context) {
log("amount:==> $amount");
    return Scaffold(
      appBar: appBar(title: 'Deposit wallet'),
      body: Consumer<AccountProvider>(builder: (context, model, _) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text.rich(
                  TextSpan(
                    text: "Send exactly ",
                    children: [
                      // TextSpan(text: "₦${formatNumber(num.parse(amount))}"),
                      TextSpan(
                        text: "₦${formatNumber(num.parse(amount))} ",
                        style: MyStyle.tx14Black.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(text: "to the account details below"),
                    ],
                  ),
                  style: MyStyle.tx14Black.copyWith(
                    color: MyColor.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20),
         
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account details',
                      style: MyStyle.tx16Black.copyWith(
                        color: MyColor.blackColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Divider(
                      thickness: .2,
                      color: MyColor.grey02Color,
                    ),
                    SizedBox(height: 10),
                    _details(
                      title: 'Bank Name:',
                      value: model.invoiceModel!.bankName!,
                    ),
                    _details(
                      title: 'Account Name:',
                      value: model.invoiceModel!.accountName!,
                    ),
                    _details(
                      title: 'Account Number:',
                      value: model.invoiceModel!.accountNumber!,
                    ),
                  ],
                ),
                Spacer(),
                CustomButton(
                  text: 'I have sent ${formatNumber(num.parse(amount))}',
                  fontWeight: FontWeight.w500,
                  onTap: () => model.createDeposit({
                    'invoice_number': model.invoiceModel!.invoiceNumber,
                    'amount': int.parse(amount),
                    'payment_method': 'bank',
                    'bank_id': int.parse(bankId),
                  }),
                ),
                SizedBox(height: 40),
              
              ],
            ),
          ),
        );
      }),
    );
  }

  _details({
    required String title,
    required String value,
  }) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: MyStyle.tx16Black.copyWith(
                color: MyColor.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                textAlign: TextAlign.end,
                value,
                style: MyStyle.tx14Black.copyWith(
                  color: MyColor.blackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Clipboard.setData(
                  ClipboardData(text: value),
                );
                Fluttertoast.showToast(msg: 'Copied to clipboard');
              },
              child: SvgPicture.asset('assets/images/copy.svg'),
            ),
          ],
        ),
      );
}
