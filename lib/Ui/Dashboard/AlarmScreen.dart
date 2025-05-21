import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  String selectedAccountName = "";
  String type = "all";
  TextEditingController searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
    // getHistoryInfo();
    // getWalletName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: BackBtn(),
        title: Text(
          "Recent Notifications",
          style: NewStyle.tx28White.copyWith(
            fontSize: 20,
            color: MyColor.dark02Color,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            
  

            // Container(
            //     height: 0.5,
            //     decoration: const BoxDecoration(color: Color(0x33D1D1D1))),
            const SizedBox(height: 12),
            ListView.builder(
              itemCount: 3,
              padding: const EdgeInsets.all(0),
              itemBuilder: (context, index) {
                // var list = dData[index];
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 12, bottom: 18),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            child: Image.asset(
                              // list['type'] == "buy"
                              //     ? "assets/images/buy.png"
                              //     :
                              "assets/images/sell.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            // Use Expanded to properly handle the layout
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      // list['type'] == "buy"
                                      //     ? "Buy"
                                      //     :
                                      "Sell",
                                      style: NewStyle.tx28White.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              NewColor.splashContentWhiteColor),
                                    ),
                                    Text(
                                      '+ 20.00',
                                      // list['type'] == "buy"
                                      //     ?
                                      //      "+ ${NumberFormat('#,###.####').format(double.parse(list['coin_amount']))} ${list['coin_code']}"
                                      //     : "- ${NumberFormat('#,###.####').format(double.parse(list['coin_amount']))} ${list['coin_code']}",
                                      style: NewStyle.tx28White.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              // list['type'] == "buy"
                                              //       ? NewColor.mainWhiteColor
                                              //       :
                                              const Color(0xFFA73E03)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 1),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Date',
                                      // "${list['created_at']}",
                                      style: NewStyle.tx14SplashWhite.copyWith(
                                          fontSize: 10,
                                          color: NewColor.txGrayColor),
                                    ),
                                    Text(
                                      'Status',
                                      // "${list['status']}",
                                      style: NewStyle.tx28White.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF017F04)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 1),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      // list['type'] == "buy"
                                      //     ? "Paid"
                                      //     :
                                      "Got",
                                      style: NewStyle.tx14SplashWhite.copyWith(
                                          fontSize: 10,
                                          color: NewColor.txGrayColor),
                                    ),
                                    Text(
                                      'Amount',
                                      // "${NumberFormat('#,###.####').format(double.parse(list['paid_amount']))} USD",
                                      style: NewStyle.tx28White.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF999999)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 1),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Invoice",
                                      style: NewStyle.tx14SplashWhite.copyWith(
                                          fontSize: 10,
                                          color: NewColor.txGrayColor),
                                    ),
                                    Text(
                                      // "${list['invoice']}",
                                      'title',
                                      style: NewStyle.tx28White.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFFBFBFBF)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: 0.5,
                        decoration:
                            const BoxDecoration(color: Color(0x33D1D1D1))),
                  ],
                );
              },
            )
            // :
            //  Align(
            //   alignment: Alignment.topCenter,
            //   child: Text("There is no completed history",
            //     style: NewStyle.tx28White.copyWith(
            //       fontSize: 14,
            //       fontWeight: FontWeight.w400,
            //     ),
            //   ),
            // ),
            
          ],
        ),
      ),
    );
  }
}
