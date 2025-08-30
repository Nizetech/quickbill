
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/utils.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:provider/provider.dart';

class ReceiptScreen extends StatefulWidget {
  final String referenceNo, date, serviceDetails, amount, status;
  final bool isElectricity, isCable;

  final String? description;
  const ReceiptScreen({
    super.key,
    this.description,
    required this.status,
    required this.referenceNo,
    required this.date,
    required this.serviceDetails,
    required this.amount,
    this.isElectricity = false,
    this.isCable = false,
  });

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  String electricityDesc = '';
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackBtn(),
        // title: Text(
        //   "Receipt",
        //   style: MyStyle.tx18Black.copyWith(color: theme.tertiary),
        // ),    
      ),
      backgroundColor:
          themeProvider.isDarkMode() ? MyColor.dark02Color : Color(0xffF4F4F4),
      body: Consumer<ServiceProvider>(builder: (context, model, child) {
        if (widget.isElectricity) {
          electricityDesc =
              "Electricity: ${model.receiptModel?.info?.title}, Token: ${model.receiptModel?.info?.token}, Units: ${model.receiptModel?.info?.unit}, ${model.receiptModel?.info?.customerName?.contains('N/A') ?? false ? "Customer Name: ${model.receiptModel?.info?.customerName}," : ''} ${model.receiptModel?.info?.kct1 != 'N/A' ? "KCT1: ${model.receiptModel?.info?.kct1}," : ''} ${model.receiptModel?.info?.kct2 != 'N/A' ? "KCT2: ${model.receiptModel?.info?.kct2}," : ''}";
        }
        return SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Image.asset(
              'assets/images/jostpay.png',
              height: 20,
            ),
            SizedBox(height: 10),
            Text("JostPay Limited (RC: 1152230, Tax-ID: 18912605-0001)",
                textAlign: TextAlign.center,
                style: MyStyle.tx14Black.copyWith(
                  color: theme.tertiary,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                )),
            // SizedBox(height: 5),
            Text("Okun-Ajah Community Rd, Eti-Osa 106104, Lagos, Nigeria.",
                textAlign: TextAlign.center,
                style: MyStyle.tx14Grey.copyWith(
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                  color: MyColor.grey,
                )),
            SizedBox(height: 10),
            _wrap(
              themeProvider: themeProvider,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Thank you for your purchase",
                          style: MyStyle.tx18Black.copyWith(
                            color: theme.tertiary,
                          )),
                      SizedBox(width: 5),
                      Icon(Icons.check_circle, color: MyColor.greenColor)
                    ],
                  ),
                  Text(
                      widget.status == "1"
                          ? "Your payment was successful"
                          : "Your payment was not successful",
                      style: MyStyle.tx14Grey.copyWith(
                        fontWeight: FontWeight.w300,
                        color: MyColor.grey,
                      )),
                ],
              ),
            ),
            SizedBox(height: 10),
            _wrap(
              hasCurve: true,
              themeProvider: themeProvider,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Reference No:",
                          style: MyStyle.tx14Grey.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: MyColor.grey,
                          )),
                      SizedBox(width: 20),
                      Expanded(
                        child: Text(widget.referenceNo,
                            textAlign: TextAlign.end,
                            style: MyStyle.tx18Black.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: theme.tertiary,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 5),
            _wrap(
              themeProvider: themeProvider,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Date",
                          style: MyStyle.tx14Grey.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: MyColor.grey,
                          )),
                      SizedBox(width: 20),
                      Expanded(
                        child: Text(
                            DateFormat('dd/MM/yyyy - hh:mm a')
                                .format(DateTime.parse(widget.date)),
                            textAlign: TextAlign.end,
                            style: MyStyle.tx18Black.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: theme.tertiary,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 7),
            Stack(
              children: [
                _wrap(
                    hasPadding: false,
                    themeProvider: themeProvider,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            "# Service Details",
                            style: MyStyle.tx14Grey.copyWith(
                              fontSize: 16,
                              color: MyColor.grey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        _divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            widget.serviceDetails,
                            style: MyStyle.tx14Grey.copyWith(
                              fontSize: 16,
                              color: MyColor.grey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        if (widget.description != null) ...[
                          _divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Description",
                                    style: MyStyle.tx14Grey.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: MyColor.grey,
                                    )),
                                SizedBox(width: 20),
                                Expanded(
                                  child: Text(
                                      widget.isElectricity
                                          ? electricityDesc
                                          : widget.description!,
                                      textAlign: TextAlign.end,
                                      style: MyStyle.tx18Black.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: theme.tertiary,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                        _divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Amount",
                                  style: MyStyle.tx14Grey.copyWith(
                                    fontSize: 16,
                                    color: MyColor.grey,
                                    fontWeight: FontWeight.w400,
                                  )),
                              SizedBox(width: 20),
                              Expanded(
                                child: Text(
                                    Utils.naira +
                                        formatNumber(num.parse(widget.amount)),
                                    textAlign: TextAlign.end,
                                    style: MyStyle.tx18Black.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: theme.tertiary,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                Positioned(
                  right: 10,
                  child: Image.asset(
                    'assets/images/stamp.png',
                    height: 80,
                    width: 80,
                  ),
                )
              ],
            ),
            SizedBox(height: 7),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: themeProvider.isDarkMode()
                      ? Color(0xff232121)
                      : Color(0xffEAE9E9),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15),
                    top: Radius.circular(5),
                  )),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Total Amount Paid-",
                          style: MyStyle.tx14Grey.copyWith(
                            fontSize: 16,
                            color: MyColor.grey,
                            fontWeight: FontWeight.w400,
                          )),
                      SizedBox(width: 20),
                      Expanded(
                        child: Text(
                            Utils.naira +
                                formatNumber(num.parse(widget.amount)),
                            textAlign: TextAlign.end,
                            style: MyStyle.tx18Black.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: theme.tertiary,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Total Method-",
                          style: MyStyle.tx14Grey.copyWith(
                            fontSize: 16,
                            color: MyColor.grey,
                            fontWeight: FontWeight.w400,
                          )),
                      SizedBox(width: 20),
                      Expanded(
                        child: Text("From Wallet",
                            textAlign: TextAlign.end,
                            style: MyStyle.tx18Black.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: theme.tertiary,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            CustomButton(
              radius: 50,
              text: 'Go back',
              onTap: () {
                Navigator.pop(context);
              },
            )
          ]),
        );
      }),
    );
  }

  _divider() => SizedBox(
        height: 1,
        child: Divider(
          color: Color(0xff1B1B1B),
          thickness: 1,
        ),
      );

  Widget _wrap({
    required ThemeProvider themeProvider,
    required Widget child,
    bool hasPadding = true,
    bool hasCurve = false,
  }) =>
      Container(
        width: double.infinity,
        padding: !hasPadding
            ? null
            : EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: hasCurve
              ? BorderRadius.vertical(
                  top: Radius.circular(15),
                  bottom: Radius.circular(5),
                )
              : BorderRadius.circular(5),
          color: themeProvider.isDarkMode() ? Colors.black : Colors.white,
        ),
        child: child,
      );
}
