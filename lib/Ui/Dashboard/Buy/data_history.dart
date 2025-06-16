import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
// ignore: unused_import
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/BuyAirtimeConfirm.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/BuyData.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/widget/balance_action_card.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/utils.dart';
import 'package:jost_pay_wallet/common/status_view_receipt.dart';
import 'package:provider/provider.dart';

class DataHistory extends StatefulWidget {
  const DataHistory({super.key});

  @override
  State<DataHistory> createState() => _DataHistoryState();
}

class _DataHistoryState extends State<DataHistory> {
  @override
  void initState() {
    super.initState();
    var model = Provider.of<AccountProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (model.dataHistoryModel == null) {
        model.getDataHistory();
      } else {
        model.getDataHistory(isLoading: false);
      }
      if (model.networkProviderModel == null) {
        model.getNetworkProviders();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      body: Consumer<AccountProvider>(builder: (context, model, _) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
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
                        'Buy Data',
                        style: MyStyle.tx18Black
                            .copyWith(color: themedata.tertiary),
                      ),
                    ),
                    const Spacer(), // Adds flexible space after the text
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                BalanceActionCard(
                    title: 'Buy Data',
                    onTap: () {
                      Get.to(const BuyData());
                    }),
                const SizedBox(
                  height: 36,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Data History',
                            style: MyStyle.tx14Black
                                .copyWith(color: themedata.tertiary),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Image.asset('assets/images/down.png')
                        ],
                      ),
                      // const Spacer(),
                      // Text('View all',
                      //     style: MyStyle.tx12Black.copyWith(
                      //       color: themeProvider.isDarkMode()
                      //           ? const Color.fromARGB(255, 5, 6, 7)
                      //           : const Color(0xff30333A),
                      //     ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (model.dataHistoryModel != null)
                  Expanded(
                    child: ListView.builder(
                        itemCount: model.dataHistoryModel!.data!.length,
                        padding: const EdgeInsets.all(0),
                        itemBuilder: (context, index) {
                          var item = model.dataHistoryModel!.data![index];
                          return Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                              width: 0.4,
                              color: themeProvider.isDarkMode()
                                  ? MyColor.borderDarkColor
                                  : MyColor.borderColor,
                            ))),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 41.r,
                                      width: 41.r,
                                      padding: EdgeInsets.all(6.r),
                                      decoration: BoxDecoration(
                                          color: themeProvider.isDarkMode()
                                              ? const Color(0XFF171717)
                                              : const Color(0XFFF4F5F6),
                                          shape: BoxShape.circle),
                                      child: SvgPicture.asset(
                                          'assets/images/phone.svg'),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${item.phone!} - ${item.networkName!}",
                                          style: MyStyle.tx12Black.copyWith(
                                              color: themedata.tertiary),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          formatDateTime(
                                            item.createdAt!,
                                          ),
                                          //  dateFormat.format(item.createdAt!),
                                          style: MyStyle.tx12Black.copyWith(
                                            color: themeProvider.isDarkMode()
                                                ? const Color(0XFFCBD2EB)
                                                : const Color(0xff30333A),
                                          ),
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                Utils.naira +
                                                    formatNumber(num.parse(
                                                        item.amount!)),
                                                style: MyStyle.tx12Black
                                                    .copyWith(
                                                        color:
                                                            themedata.tertiary),
                                              ),
                                              SizedBox(width: 5),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(BuyData(
                                                    phone: item.phone,
                                                    network: item.networkName,
                                                  ));
                                                },
                                                child: SvgPicture.asset(
                                                    'assets/images/refresh.svg'),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          StatusViewReceipt(
                                            status: item.status!,
                                            onTap: () {},
                                          ),
                                        ])
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                )
                              ],
                            ),
                          );
                        }),
                    // ),
                  )
              ],
            ),
          ),
        );
      }),
    );
  }
}
