import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/widget/balance_action_card.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/receipt_script.dart';
import 'package:jost_pay_wallet/Ui/giftCard/buy_gift_card_screen.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/utils.dart';
import 'package:jost_pay_wallet/common/status_view_receipt.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
import 'package:provider/provider.dart';

class GiftCardHistory extends StatefulWidget {
  const GiftCardHistory({super.key});

  @override
  State<GiftCardHistory> createState() => _GiftCardHistoryState();
}

class _GiftCardHistoryState extends State<GiftCardHistory> {
  @override
  void initState() {
    super.initState();
    var model = Provider.of<AccountProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (model.giftCardHistoryModel == null) {
        model.getGiftCradHistory();
      } else {
        model.getGiftCradHistory(isLoading: false);
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
                        'Gift Card',
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
                    title: Platform.isIOS ? 'View Gift Card' : 'Buy Gift Card',
                    onTap: () {
                      Platform.isIOS
                          ? launchWeb(Utils.giftcardLink)
                          :
                      Get.to(const BuyGiftCardScreen());
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
                            'Gift Card History',
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
                  height: 16,
                ),
                if (model.giftCardHistoryModel != null)
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await model.getGiftCradHistory();
                      },
                      child: ListView.builder(
                          itemCount: model.giftCardHistoryModel!.data!.length,
                          padding: const EdgeInsets.all(0),
                          itemBuilder: (context, index) {
                            var item = model.giftCardHistoryModel!.data![index];
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
                                            'assets/images/svg/money.svg'),
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.giftName!,
                                              maxLines: 1,
                                              style: MyStyle.tx12Black.copyWith(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: themedata.tertiary),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              item.reference ?? "",
                                              maxLines: 1,
                                              style: MyStyle.tx12Black.copyWith(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: themedata.tertiary),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              formatDateTime(
                                                item.updatedAt!,
                                              ),
                                              //  dateFormat.format(item.createdAt!),
                                              style: MyStyle.tx12Black.copyWith(
                                                color: themeProvider
                                                        .isDarkMode()
                                                    ? const Color(0XFFCBD2EB)
                                                    : const Color(0xff30333A),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 25),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              Utils.naira +
                                                  formatNumber(num.parse(
                                                      item.giftAmount!)),
                                              style: MyStyle.tx12Black.copyWith(
                                                  color: themedata.tertiary),
                                            ),
                                            SizedBox(
                                              height: 8.h,
                                            ),
                                            StatusViewReceipt(
                                              status: item.reloadlyStatus!,
                                              isServices: true,
                                              onTap: () {
                                                if (item.status != '1' ||
                                                    !item.reloadlyStatus!
                                                            .toLowerCase()
                                                            .contains(
                                                                'complete') &&
                                                        !item.reloadlyStatus!
                                                            .toLowerCase()
                                                            .contains(
                                                                'success')) {
                                                  ErrorToast(
                                                      'No receipt available yet. Your order has not been completed.');
                                                } else {
                                                  Get.to(ReceiptScreen(
                                                    status: item.status!,
                                               
                                                    serviceDetails:
                                                        item.giftName ?? "",
                                                    description:
                                                        "${item.giftCountryName}, ${item.giftQty} cards ",
                                                    referenceNo:
                                                        item.reference!,
                                                    amount: item.giftAmount!,
                                                    date: item.updatedAt!
                                                        .toString(),
                                                  ));
                                                }
                                              },
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
                    ),
                  )
              ],
            ),
          ),
        );
      }),
    );
  }
}
