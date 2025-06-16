

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Models/transactions.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/BuyAirtimeConfirm.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/BuyData.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class HistoryCard extends StatelessWidget {
  final Datum transaction;
  const HistoryCard({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    Color getStatus(Datum transaction) {
      if (transaction.type == Type.SPRAY && transaction.status == '2') {
        return MyColor.dark01GreenColor;
      } else if (transaction.type == Type.SPRAY && transaction.status == '1') {
        return MyColor.orange01Color;
      } else if (transaction.status == 'success' || transaction.status == '1') {
        return MyColor.dark01GreenColor;
      } else if (transaction.status == 'pending') {
        return MyColor.orange01Color;
      } else {
        return MyColor.redColor;
      }
    }

    String getOperator(Datum transaction) {
      String operator = transaction.details!
          .split(' Operator: ')[1]
          .split(',')[0]
          .toString()
          .split('Airtime')[0]
          .capitalizeFirst!;
      return operator;
    }

    String getPhone(Datum transaction) {
      return transaction.details!.split(' Phone: ')[1].split(',')[0].toString();
    }

    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Row(
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
          child: SvgPicture.asset(transaction.type != null &&
                      transaction.type == Type.DATA ||
                  transaction.type != null && transaction.type == Type.AIRTIME
              ? 'assets/images/phone.svg'
              : transaction.type != null && transaction.type == Type.DEPOSIT
                  ? 'assets/images/svg/deposit.svg'
                  : 'assets/images/svg/money.svg'),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (transaction.type != null &&
                      transaction.type != Type.DATA &&
                      transaction.type != Type.AIRTIME)
                    Text(
                      transaction.type!.name.capitalizeFirst!,
                      style: MyStyle.tx14Grey.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: themeProvider.isDarkMode()
                              ? const Color(0XFFCBD2EB)
                              : const Color(0xff30333A)),
                    ),
                  if (transaction.type == Type.DATA ||
                      transaction.type == Type.AIRTIME)
                    Text(
                      '${getOperator(transaction).toUpperCase()} - ${transaction.type!.name.capitalizeFirst!}',
                      style: MyStyle.tx14Grey.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: themeProvider.isDarkMode()
                              ? const Color(0XFFCBD2EB)
                              : const Color(0xff30333A)),
                    ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                transaction.reference!,
                style: MyStyle.tx14Grey.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: themeProvider.isDarkMode()
                        ? const Color(0XFFCBD2EB)
                        : const Color(0xff30333A)),
              ),
              //  Clipboard.setData(const ClipboardData(
              //                     text: "420516-51443-7897-SPR"));
              //                 Fluttertoast.showToast(
              //                     msg: "Copied to clipboard");
              //               },
              //               child: Padding(
              //                 padding: const EdgeInsets.all(6),
              //                 child: SvgPicture.asset(
              //                   isDark
              //                       ? 'assets/images/svg/copy-dark.svg'
              //                       : 'assets/images/svg/copy.svg',
              //                 ),
              //               ),
              //             ),
              SizedBox(height: 5.h),
              Text(
                formatDateTime(transaction.transDate!),
                style: MyStyle.tx14Grey.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: themeProvider.isDarkMode()
                        ? const Color(0XFFCBD2EB)
                        : const Color(0xff30333A)),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  '₦${formatNumber(num.parse(transaction.amount!))}',
                  style: MyStyle.tx14Grey.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                      color: themeProvider.isDarkMode()
                          ? const Color(0XFFCBD2EB)
                          : const Color(0xff30333A)),
                ),
                if (transaction.type == Type.DATA ||
                    transaction.type == Type.AIRTIME)
                  GestureDetector(
                    onTap: () {
                      if (transaction.type == Type.DATA) {
                        Get.to(BuyData(
                          phone: getPhone(transaction),
                          network: getOperator(transaction),
                        ));
                      } else {
                        Get.to(BuyAirtimeConfirm(
                          phone: getPhone(transaction),
                          network: getOperator(transaction),
                          amount: transaction.amount,
                        ));
                      }
                    },
                    child: Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: SvgPicture.asset('assets/images/refresh.svg')),
                  ),
              ],
            ),
           
            const SizedBox(height: 5),
            Row(
              children: [
                CircleAvatar(
                  radius: 7,
                  backgroundColor: getStatus(transaction),
                  child: Icon(
                    getStatus(transaction) == MyColor.dark01GreenColor
                        ? Icons.done
                        : Icons.close,
                    size: 10,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 5.w),
                GestureDetector(
                  onTap: () {
                    // Get.to(BuyAirtimeConfirm(
                    //   phone: item.phone,
                    //   network: item.networkName,
                    // ));
                  },
                  child: Container(
                      width: 68,
                      decoration: BoxDecoration(
                          color: themedata.secondary,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'View Receipt',
                              style: MyStyle.tx11Grey.copyWith(
                                  color: MyColor.dark01GreenColor,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
