import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/utils.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:jost_pay_wallet/common/pending_screen.dart';
import 'package:jost_pay_wallet/common/success_screen.dart';
import 'package:provider/provider.dart';

class CableElectricitySuccessScreen extends StatefulWidget {
  final bool isCable;
  final bool isPending;
  final Map<String, dynamic>? data;
  final bool isShowmax;
  final String amount;
  final bool isTransaction;
  const CableElectricitySuccessScreen({
    super.key,
    this.isCable = true,
    this.isPending = false,
    this.data,
    this.isShowmax = false,
    required this.amount,
    this.isTransaction = false,
  });

  @override
  State<CableElectricitySuccessScreen> createState() =>
      _CableElectricitySuccessScreenState();
}

class _CableElectricitySuccessScreenState
    extends State<CableElectricitySuccessScreen> {
  @override
  Widget build(BuildContext context) {
    // log('widget.data:==> ${widget.data} =>${widget.isShowmax}');
    final model = Provider.of<ServiceProvider>(context, listen: false);
    return widget.isPending || widget.data?.isEmpty == true
        ? PendingScreen(
            title: widget.isCable
                ? "Cable subscription is being processed please wait "
                : "Electricity subscription is being processed please wait",
            onTap: () {
              if (widget.isCable) {
                model.getCableTransactions(
                    isLoading: false, account: context.read<AccountProvider>());
                Get.close(3);
              } else {
                model.getElectricityTransactions(
                    isLoading: false, account: context.read<AccountProvider>());
              Get.close(3);
              }
            },
         
          )
        : widget.isShowmax || !widget.isCable
            ? CableElectSuccessScreen(
                data: widget.data ?? {},
                isCable: widget.isShowmax,
                amount: widget.amount,
                isTransaction: widget.isTransaction,
              )
            : SuccessScreen(
                title: "Cable subscription placed successfully",
                subtitle:
                    "Cable subscriptions are usually completed within minutes to hours.",
                onTap: () {
                  if (widget.isTransaction) {
                    Get.back();
                  } else 
                  if (widget.isCable) {
                    model.getCableTransactions(
                        isLoading: false,
                        account: context.read<AccountProvider>());
                    Get.close(3);
                  } else {
                    model.getElectricityTransactions(
                        isLoading: false,
                        account: context.read<AccountProvider>());
                  Get.close(3);
                  }
                  
                },
              );
  }
}

class CableElectSuccessScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool isCable;
  final String amount;
  final bool isTransaction;
  const CableElectSuccessScreen({
    super.key,
    required this.data,
    required this.isCable,
    required this.amount,
    this.isTransaction = false,
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ServiceProvider>(context, listen: false);
    final themedata = Theme.of(context).colorScheme;
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    // log('Success data:==> ${data}');
    return data.isEmpty
        ? PendingScreen(
            title: "Cable subscription is being processed please wait ",
            onTap: () {
              if (isCable) {
                model.getCableTransactions(
                    isLoading: false, account: context.read<AccountProvider>());
              } else {
                model.getElectricityTransactions(
                    isLoading: false, account: context.read<AccountProvider>());
              }
              Get.close(3);
                        
            },
          )
        : Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Center(
                child: Image.asset(
                  'assets/images/success_sm.png',
                  height: 90,
                  width: 150,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 17, vertical: 5),
                decoration: BoxDecoration(
                  color: MyColor.greenColor.withValues(alpha: .05),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text('Purchase Successful!',
                    style: TextStyle(
                      fontSize: 12,
                      color: MyColor.greenColor,
                      fontWeight: FontWeight.w400,
                    )),
              ),
              const SizedBox(
                height: 40,
              ),
              FittedBox(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                  decoration: BoxDecoration(
                    color: Color(0xffF9F9F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            isCable
                                ? data['purchased_code']
                                      : data['token']?.toString() ??
                                          data['data']?['Token']?.toString() ??
                                          data['data']?['mainToken']
                                              ?.toString() ??
                                          data['data']?['token']?.toString() ??
                                          'N/A',
                                
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: MyColor.greenColor,
                                  ),  
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(
                                          text: data['token']?.toString() ??
                                              data['data']?['Token']
                                                  ?.toString() ??
                                              data['data']?['token']
                                                  ?.toString() ??
                                              data['data']?['mainToken']
                                                  ?.toString() ??
                                              'N/A'

                                      ),
                                    );
                              Fluttertoast.showToast(
                                  msg: "Copied to clipboard");
                            },
                            child: SvgPicture.asset(
                              'assets/images/copy.svg',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        isCable
                            ? "Kindly copy & enter this token  purchased code into your system"
                            : 'Kindly copy & enter this token into your meter recharge',
                        textAlign: TextAlign.center,
                        style: MyStyle.tx12Black.copyWith(
                          fontWeight: FontWeight.w400,
                          color: themedata.tertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildInfo(
                  title: 'Reference ID',
                  value:
                      isCable
                            ? data['requestId'] 
                            : data['reference']?.toString() ??
                                data['data']?['requestId']?.toString() ??
                                data['data']?['requestid']?.toString() ??
                                'N/A',
                  themedata: themedata),
              _buildInfo(
                  title: 'Transaction Date',
                  value: formatDateTime(DateTime.parse(isCable
                      ? data['transaction_date']
                            : data['created_at'] ??
                                data['data']?['transaction_date'])),
                  themedata: themedata),
              _buildInfo(
                  title: 'Amount',
                  value:
                            "${Utils.naira} ${formatNumber(num.parse(data['amount'] ?? amount))}",
                  themedata: themedata),
              if (!isCable) ...[
                _buildInfo(
                    title: 'Units',
                          value: data['unit'] ??
                              data['data']?['Units']?.toString() ??
                              data['data']?['mainTokenUnits']?.toString() ??
                              data['data']?['units']?.toString() ??
                              'N/A',
                    themedata: themedata),
                _buildInfo(
                          title: isTransaction ? "Meter No:" : 'Tarrif',
                          value: isTransaction
                              ? data['title'].toString().split(' /')[1]
                              : data['data']?['Tariff'] ??
                                  data['data']?['tariff'] ??
                                  'N/A',
                    themedata: themedata),
                _buildInfo(
                    title: 'Customer Address',
                          value: data['data']?['CustomerAddress'] ??
                              data['data']?['customerAddress'] ??
                              data['data']?['customerAddress'] ??
                              'N/A',
                    themedata: themedata),
                      // _buildInfo(
                      //           title: !isTransaction
                      //               ? 'Exchange Reference'
                      //               : 'Meter No:',
                      //           value: isTransaction
                      //               ? data['title'].toString().split(' /')[1]
                      //               : data['data']?['ExchangeReference'] ??
                      //                   data['data']?['exchangeReference'] ??
                      //                   data['data']?['exchangeReference'] ??
                      //                   'N/A',
                      // themedata: themedata),
                      // _buildInfo(
                      //     title: 'Main Token Units',
                      //           value: data['unit'] ??
                      //               data['data']?['Units'] ??
                      //               data['data']?['units'] ??
                      //               data['data']?['unit'] ??
                      //               'N/A',
                      //     themedata: themedata),
                _buildInfo(
                    title: 'Product Name',
                          value: data['title'] != null
                              ? data['title'].toString().split(' /')[0]
                              : data['data']?['content']?['transactions']
                                      ?['product_name'] ??
                                  data['data']?['content']?['transactions']
                                      ?['product_name'] ??
                                  'N/A',

                    themedata: themedata),
                _buildInfo(
                    title: 'KCT1',
                          value: data['data']?['kct1'] ?? 'N/A',
                    themedata: themedata),
                _buildInfo(
                    title: 'KCT2',
                          value: data['data']?['kct2'] ?? 'N/A',
                    themedata: themedata),
              ],
                    SizedBox(height: 20),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: Platform.isAndroid
                          ? () => launchWeb(Utils.playStoreLink)
                          : () => launchWeb(Utils.appleLink),
                      child: Image.asset(themeProvider.isDarkMode()
                          ? 'assets/images/dark_rate.png'
                          : 'assets/images/light_rate.png'),
                    ),
                    SizedBox(height: 30),
              SizedBox(height: 20),
              CustomButton(
                text: 'Buy More',
                onTap: () {
                        if (isTransaction) {
                          Get.back();
                        } else {
                  if (isCable) {
                    model.getCableTransactions(
                        isLoading: false,
                        account: context.read<AccountProvider>());
                  } else {
                    model.getElectricityTransactions(
                        isLoading: false,
                        account: context.read<AccountProvider>());
                          }
                          Get.close(3);
                        }
                },
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfo({
    required String title,
    required String value,
    required ColorScheme themedata,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: MyStyle.tx12Black.copyWith(
              fontWeight: FontWeight.w400,
              color: themedata.tertiary,
            ),
          ),
          SizedBox(width: 30),
          Expanded(
            child: Text(
              value,
              maxLines: 1,
              textAlign: TextAlign.end,
              style: MyStyle.tx12Black.copyWith(
                fontWeight: FontWeight.w400,
                color: themedata.tertiary,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
