
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Models/transactions.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/BuyAirtimeConfirm.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/BuyData.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/receipt_script.dart';
import 'package:jost_pay_wallet/Ui/Paint/paint_history.dart';
import 'package:jost_pay_wallet/Ui/Scripts/script_history.dart';
import 'package:jost_pay_wallet/Ui/cable/cable_electricity_success.dart';
import 'package:jost_pay_wallet/Ui/cable/cable_history.dart';
import 'package:jost_pay_wallet/Ui/car/car_history.dart';
import 'package:jost_pay_wallet/Ui/electricity/electricity_history.dart';
import 'package:jost_pay_wallet/Ui/repair/repairdetail_screen.dart';
import 'package:jost_pay_wallet/Ui/giftCard/gift_card_history.dart';
import 'package:jost_pay_wallet/Ui/pay4me/pay4me_history.dart';
import 'package:jost_pay_wallet/Ui/promotions/social_boost_history.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
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
      } else if (transaction.status == 'pending' ||
          transaction.apiStatus == 'pending') {
        return MyColor.orange01Color;
      } else if (transaction.apiStatus == 'failed') {
        return MyColor.redColor;
      } else if (transaction.apiStatus == 'refunded') {
        return MyColor.purpleColor;
      } else if (transaction.status == 'success' || transaction.status == '1') {
        return MyColor.dark01GreenColor;
      } else if (transaction.type == Type.AUTOREPAIR &&
          transaction.status!.isNotEmpty) {
        return MyColor.dark01GreenColor;
      } else {
        return MyColor.redColor;
      }
    }

    bool isSpecialTransactionService(Datum transaction) {
      if (transaction.type == Type.PAY4_ME ||
          transaction.type == Type.GIFTCARD) {
        return true;
      } else {
        return false;
      }
    }

    String getPhone(Datum transaction) {
      return transaction.details!.split(' Phone: ')[1].split(',')[0].toString();
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

    String refundedDesc(Datum transaction) {
      if (transaction.type == Type.DATA) {
        return 'Data | Refunded';
      } else if (transaction.type == Type.AIRTIME) {
        return 'Airtime | Refunded';
      } else if (transaction.type == Type.SCRIPT) {
        return 'Script | Refunded';
      } else if (transaction.type == Type.GIFTCARD) {
        return 'Gift Card | Refunded';
      } else if (transaction.type == Type.PAY4_ME) {
        return 'Pay4Me | Refunded';
      } else if (transaction.type == Type.SOCIALBOOST) {
        return 'Social Boost | Refunded';
      } else if (transaction.type == Type.MOTORS) {
        return 'Motors | Refunded';
      } else if (transaction.type == Type.AUTOREPAIR) {
        return 'Auto Repair | Refunded';
      } else if (transaction.type == Type.SPRAY) {
        return 'Spray | Refunded';
      } else if (transaction.type == Type.ELECTRICITY) {
        return 'Electricity | Refunded';
      } else if (transaction.type == Type.CABLE) {
        return 'Cable | Refunded';
      } else {
        return '${transaction.type!.name.capitalizeFirst!} | Refunded';
      }
    }

    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    final model = context.read<ServiceProvider>();
    // log('transaction:==> ${transaction.toJson()}');
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
              if (transaction.type != Type.DATA &&
                  transaction.type != Type.AIRTIME)
                Text(
                  transaction.apiStatus == 'refunded'
                      ? refundedDesc(transaction)
                      : transaction.type != null
                          ? transaction.type == Type.SCRIPT
                              ? transaction.details!
                                  .split(' name: ')[1]
                                  .toString()
                              : transaction.type == Type.AUTOREPAIR
                                  ? "AutoRepair - ${transaction.details}"
                                  : transaction.type == Type.SOCIALBOOST
                                      ? transaction.details!
                                          .split(' name: ')[1]
                                          .toString()
                                      : transaction.type == Type.GIFTCARD
                                          ? transaction.details!
                                          : transaction.type == Type.MOTORS
                                              ? transaction.details!
                                                  .split(' name: ')[1]
                                                  .toString()
                                              : transaction.type == Type.PAY4_ME
                                                  ? transaction.details!
                                                      .split(' link: ')[1]
                                                      .toString()
                                                  : (transaction.type ==
                                                              Type
                                                                  .ELECTRICITY ||
                                                          transaction.type ==
                                                              Type.CABLE)
                                                      ? transaction.details!
                                                          .split(' ID: ')[1]
                                                          .toString()
                                                      : transaction.type!.name
                                                          .capitalizeFirst!
                          : transaction.details!,
                  maxLines: 1,
                  style: MyStyle.tx12Black.copyWith(
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 12.sp,
                    color: themeProvider.isDarkMode()
                        ? const Color(0XFFCBD2EB)
                        : const Color(0xff30333A),
                  ),
                ),
              if (transaction.type == Type.DATA ||
                  transaction.type == Type.AIRTIME)
                Text(
                  transaction.apiStatus == 'refunded'
                      ? refundedDesc(transaction)
                      : transaction.type == Type.DATA
                          ? transaction.details!
                              .split(' Plan: ')[1]
                              .split(',')[1]
                          : '${getPhone(transaction)} - ${getOperator(transaction).toUpperCase()}',
                  maxLines: 1,
                  style: MyStyle.tx12Black.copyWith(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: themeProvider.isDarkMode()
                          ? const Color(0XFFCBD2EB)
                          : const Color(0xff30333A)),
                ),
              if (transaction.reference != null &&
                  transaction.reference!.isNotEmpty) ...[
                const SizedBox(height: 5),
                Text(
                  transaction.reference!,
                  maxLines: 1,
                  style: MyStyle.tx12Black.copyWith(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: themeProvider.isDarkMode()
                          ? const Color(0XFFCBD2EB)
                          : const Color(0xff30333A)),
                ),
              ],
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
                style: MyStyle.tx12Black.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  fontStyle: FontStyle.italic,
                  color: themeProvider.isDarkMode()
                      ? const Color(0XFFCBD2EB)
                      : const Color(0xff30333A),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 25),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  '₦${formatNumber(num.parse(transaction.amount!))}',
                  style: MyStyle.tx12Black.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                      color: themeProvider.isDarkMode()
                          ? const Color(0XFFCBD2EB)
                          : const Color(0xff30333A)),
                ),
                if (transaction.type != Type.DEPOSIT)
                  GestureDetector(
                    onTap: () {
                      if (transaction.type == Type.DATA) {
                        Get.to(BuyData(
                          phone: getPhone(transaction),
                          network: getOperator(transaction),
                        ));
                      } else if (transaction.type == Type.AIRTIME) {
                        Get.to(BuyAirtimeConfirm(
                          phone: getPhone(transaction),
                          network: getOperator(transaction),
                          amount: transaction.amount,
                        ));
                      } else if (transaction.type == Type.SCRIPT) {
                        Get.to(ScriptHistory());
                      } else if (transaction.type == Type.GIFTCARD) {
                        Get.to(GiftCardHistory());
                      } else if (transaction.type == Type.PAY4_ME) {
                        Get.to(PayForMeHistory());
                      } else if (transaction.type == Type.SOCIALBOOST) {
                        Get.to(SocialBoostHistory());
                      } else if (transaction.type == Type.SPRAY) {
                        Get.to(PaintHistory());
                      } else if (transaction.type == Type.ELECTRICITY) {
                        Get.to(ElectricityHistory());
                      } else if (transaction.type == Type.CABLE) {
                        Get.to(CableHistory());
                      } else if (transaction.type == Type.MOTORS) {
                        Get.to(CarHistory());
                      } else {
                        Get.to(RepairdetailScreen());
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: SvgPicture.asset('assets/images/refresh.svg'),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                transaction.apiStatus == 'refunded'
                    ? CircleAvatar(
                        radius: 7,
                        backgroundColor: MyColor.purpleColor,
                        child: Icon(
                          Icons.check,
                          size: 10,
                          color: Colors.white,
                        ),
                      )
                    : transaction.apiStatus != null &&
                                transaction.apiStatus!.contains('pending') ||
                            isSpecialTransactionService(transaction) &&
                                transaction.status == '0' ||
                            getStatus(transaction) == MyColor.orange01Color
                        ? CircleAvatar(
                            radius: 7,
                            backgroundColor: MyColor.pending,
                            child:
                                SvgPicture.asset('assets/images/pending.svg'))
                        : CircleAvatar(
                            radius: 7,
                            backgroundColor: getStatus(transaction),
                            child: Icon(
                              getStatus(transaction) ==
                                          MyColor.dark01GreenColor ||
                                      isSpecialTransactionService(
                                              transaction) &&
                                          transaction.status == '1' 
                                  ? Icons.done
                                  : Icons.close,
                              size: 10,
                              color: Colors.white,
                            ),
                          ),
                SizedBox(width: 5.w),
                GestureDetector(
                  onTap: () {
                    if (transaction.apiStatus == 'refunded') {
                      viewReceipt(
                        transaction: transaction,
                        getPhone: getPhone,
                        getOperator: getOperator,
                        context: context,
                      );
                    } else if ((transaction.apiStatus != null &&
                            transaction.apiStatus!.contains('pending')) ||
                        getStatus(transaction) != MyColor.dark01GreenColor ||
                        transaction.apiStatus!.contains('pending') ||
                        (isSpecialTransactionService(transaction) &&
                            transaction.status == '0') ||
                        getStatus(transaction) == MyColor.orange01Color) {
                      ErrorToast(
                          'No receipt available yet. Your order has not been completed.');
                    } else {
                      if (transaction.type == Type.ELECTRICITY ||
                          transaction.type == Type.CABLE) {
                        model.getReceipt({
                          'id': transaction.id,
                          'type': transaction.type == Type.ELECTRICITY
                              ? 'electricity'
                              : 'cable',
                        }, callback: () {
                          viewReceipt(
                            transaction: transaction,
                            getPhone: getPhone,
                            getOperator: getOperator,
                            context: context,
                          );
                        });
                      } else {
                        viewReceipt(
                          transaction: transaction,
                          getPhone: getPhone,
                          getOperator: getOperator,
                          context: context,
                        );
                      }
                    }
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: themedata.secondary,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 5),
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

  void viewReceipt({
    required Datum transaction,
    required String Function(Datum transaction) getPhone,
    required String Function(Datum transaction) getOperator,
    required BuildContext context,
  }) {
    final model = context.read<ServiceProvider>();
    if (transaction.type == Type.ELECTRICITY) {
      Get.to(CableElectSuccessScreen(
        data: model.receiptModel?.info?.toJson() ?? {},
        isCable: false,
        amount: transaction.amount!,
        isTransaction: true,
      ));
    } else {
    Get.to(
      ReceiptScreen(
        status: '1',
          isDeposit: transaction.type == Type.DEPOSIT,
          isRefunded: transaction.apiStatus == 'refunded',
        isElectricity: transaction.type == Type.ELECTRICITY,
        isCable: transaction.type == Type.CABLE,
        serviceDetails: transaction.type == Type.DATA
            ? "Data - ${getPhone(transaction)}"
            : transaction.type == Type.AIRTIME
                ? "Airtime"
                : transaction.type != null
                    ? transaction.type!.name.capitalizeFirst!
                    : transaction.details!,
        referenceNo: transaction.reference!,
        amount: transaction.amount!,
        description: transaction.type == Type.DATA ||
                transaction.type == Type.AIRTIME
            ? '${getOperator(transaction).toUpperCase()} - ${transaction.type!.name.capitalizeFirst!}'
            : transaction.details!,
        date: transaction.transDate!.toString(),
        ),
      );
    }
  }
}
