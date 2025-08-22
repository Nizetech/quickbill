import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
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
  const CableElectricitySuccessScreen({
    super.key,
    this.isCable = true,
    this.isPending = false,
    this.data,
    this.isShowmax = false,
  });

  @override
  State<CableElectricitySuccessScreen> createState() =>
      _CableElectricitySuccessScreenState();
}

class _CableElectricitySuccessScreenState
    extends State<CableElectricitySuccessScreen> {
  @override
  Widget build(BuildContext context) {
    log('widget.data:==> ${widget.data} =>${widget.isShowmax}');
    final model = Provider.of<ServiceProvider>(context, listen: false);
    return widget.isPending
        ? PendingScreen(
            title: widget.isCable
                ? "Cable subscription is being processed please wait "
                : "Electricity subscription is being processed please wait",
            onTap: () {
              model.getCableTransactions(
                  isLoading: false, account: context.read<AccountProvider>());
              Get.close(3);
            },
         
          )
        : widget.isShowmax || !widget.isCable
            ? CableElectSuccessScreen(
                data: widget.data!,
                isCable: widget.isShowmax,
              )
            : SuccessScreen(
                title: "Cable subscription placed successfully",
                subtitle:
                    "Cable subscriptions are usually completed within minutes to hours.",
                onTap: () {
                  model.getCableTransactions(
                      isLoading: false,
                      account: context.read<AccountProvider>());
                  Get.close(3);
                },
              );
  }
}

class CableElectSuccessScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool isCable;
  const CableElectSuccessScreen({
    super.key,
    required this.data,
    required this.isCable,
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ServiceProvider>(context, listen: false);
    final themedata = Theme.of(context).colorScheme;
    log('data here:==> ${data['total_amount']}');
    return Scaffold(
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
                                : data['data']['token'].split(': ')[1],
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
                                  text: data['data']['token'].split(': ')[1]));
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
                      isCable ? data['requestId'] : data['data']['requestId'],
                  themedata: themedata),
              _buildInfo(
                  title: 'Transaction Date',
                  value: formatDateTime(DateTime.parse(isCable
                      ? data['transaction_date']
                      : data['data']['transaction_date'])),
                  themedata: themedata),
              _buildInfo(
                  title: 'Amount',
                  value:
                      "${Utils.naira} ${formatNumber(num.parse(isCable ? data['content']['transactions']['total_amount'].toString() : data['data']['content']['transactions']['amount'].toString()))}",
                  themedata: themedata),
              if (!isCable) ...[
                _buildInfo(
                    title: 'Units',
                    value: data['data']['units'],
                    themedata: themedata),
                _buildInfo(
                    title: 'Tarrif',
                    value: data['data']['tariff'],
                    themedata: themedata),
                _buildInfo(
                    title: 'Customer Address',
                    value: data['data']['customerAddress'],
                    themedata: themedata),
                _buildInfo(
                    title: 'Exchange Reference',
                    value: data['data']['exchangeReference'],
                    themedata: themedata),
                _buildInfo(
                    title: 'Main Token Units',
                    value: data['data']['units'],
                    themedata: themedata),
                _buildInfo(
                    title: 'Product Name',
                    value: data['data']['content']['transactions']
                        ['product_name'],
                    themedata: themedata),
                _buildInfo(
                    title: 'KCT1',
                    value: data['data']['kct1'] ?? 'N/A',
                    themedata: themedata),
                _buildInfo(
                    title: 'KCT2',
                    value: data['data']['kct2'] ?? 'N/A',
                    themedata: themedata),
              ],
              SizedBox(height: 20),
              CustomButton(
                text: 'Buy More',
                onTap: () {
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
          Text(
            value,
            maxLines: 1,
            style: MyStyle.tx12Black.copyWith(
              fontWeight: FontWeight.w400,
              color: themedata.tertiary,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
