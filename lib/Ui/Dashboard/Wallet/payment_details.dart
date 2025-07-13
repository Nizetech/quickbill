import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:provider/provider.dart';

class PaymentPayment extends StatelessWidget {
  final String amount;
  final String bankId;
  const PaymentPayment({super.key, required this.amount, required this.bankId});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      body: Consumer<AccountProvider>(builder: (context, model, _) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
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
                        "Payment Details",
                        style: MyStyle.tx18Black
                            .copyWith(color: themedata.tertiary),
                      ),
                    ),
                    const Spacer(), // Adds flexible space after the text
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: MyColor.greenColor.withValues(alpha: .1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Complete your deposit by following the instructions below",
                            style: MyStyle.tx14Black
                                .copyWith(color: MyColor.greenColor),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    MyColor.grey02Color.withValues(alpha: .3)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Invoice',
                                    style: MyStyle.tx16Black.copyWith(
                                      color: themedata.tertiary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    model.invoiceModel!.invoiceNumber!,
                                    style: MyStyle.tx16Black.copyWith(
                                      color: themedata.tertiary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Amount',
                                    style: MyStyle.tx16Black.copyWith(
                                      color: themedata.tertiary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "$amount NGN",
                                    style: MyStyle.tx16Black.copyWith(
                                      color: themedata.tertiary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                             
                           
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: themeProvider.isDarkMode()
                                ? MyColor.dark02Color
                                : MyColor.grey01Color,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kindly Make Payment To:',
                                style: MyStyle.tx14Black.copyWith(
                                  color: themedata.tertiary,
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
                                themedata: themedata,
                              ),
                              _details(
                                title: 'Account Name:',
                                value: model.invoiceModel!.accountName!,
                                themedata: themedata,
                              ),
                              _details(
                                title: 'Account Number:',
                                value: model.invoiceModel!.accountNumber!,
                                themedata: themedata,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: MyColor.redColor.withValues(alpha: .08),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: MyColor.redColor.withValues(alpha: .3),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'INSTRUCTION',
                                style: MyStyle.tx14Black.copyWith(
                                  color: MyColor.darkRed,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text.rich(
                                TextSpan(
                                  text:
                                      "Ensure you include the deposit invoice ",
                                  style: MyStyle.tx14Black.copyWith(
                                    color: MyColor.darkRed,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          "${model.invoiceModel!.invoiceNumber} ",
                                      style: MyStyle.tx16Black.copyWith(
                                        color: MyColor.darkRed,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "as the transfer remark for faster processing.",
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        CustomButton(
                          text: 'I have Paid',
                          onTap: () => model.createDeposit({
                            'invoice_number': model.invoiceModel!.invoiceNumber,
                            'amount': amount,
                            'payment_method': 'bank',
                            'bank_id': int.parse(bankId),
                          }),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Once you make payment tap "I have paid".',
                          style: MyStyle.tx12Black.copyWith(
                            color: themedata.tertiary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        

                      ],
                    ),
                  ),
                ),
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
    required ColorScheme themedata,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: MyStyle.tx14Black.copyWith(
              color: themedata.tertiary,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: MyStyle.tx16Black.copyWith(
              color: themedata.tertiary,
            ),
          ),
        ],
      );
}
