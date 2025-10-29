import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:quick_bills/Models/transactions.dart';
import 'package:quick_bills/Provider/service_provider.dart';
import 'package:quick_bills/Ui/Dashboard/Home/receipt_screen.dart';
import 'package:quick_bills/Values/Helper/helper.dart';
import 'package:quick_bills/Values/MyColor.dart';
import 'package:quick_bills/Values/MyStyle.dart';
import 'package:quick_bills/utils/toast.dart';

class HistoryCard extends StatelessWidget {
  final AllTransaction transaction;
  const HistoryCard({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    Color getStatus(AllTransaction transaction) {
      if (transaction.status == 'pending' ||
          transaction.apiStatus == 'pending') {
        return MyColor.orange01Color;
      } else if (transaction.apiStatus == 'failed') {
        return MyColor.redColor;
      } else if (transaction.apiStatus == 'refunded') {
        return MyColor.purpleColor;
      } else if (transaction.status == 'success' || transaction.status == '1') {
        return MyColor.dark01GreenColor;
      } else {
        return MyColor.redColor;
      }
    }

    String getPhone(AllTransaction transaction) {
      return transaction.networkName!;
    }

    String getOperator(AllTransaction transaction) {
      return transaction.networkName!;
    }

    String refundedDesc(AllTransaction transaction) {
      if (transaction.type == 'data') {
        return 'Data | Refunded';
      } else if (transaction.type == 'airtime') {
        return 'Airtime | Refunded';
      } else {
        return '${transaction.type!.capitalizeFirst!} | Refunded';
      }
    }

    String getDescription(AllTransaction transaction) {
      return transaction.apiStatus == 'refunded'
          ? refundedDesc(transaction)
          : transaction.type != null
              ? transaction.type!.capitalizeFirst!
              : '';
    }

    // final model = context.read<ServiceProvider>();
    return Row(
      children: [
        Container(
          height: 41.r,
          width: 41.r,
          padding: EdgeInsets.all(6.r),
          decoration: BoxDecoration(
              color: MyColor.mainWhiteColor,
              border: Border.all(color: MyColor.borderColor),
              shape: BoxShape.circle),
          child: Icon(
            transaction.inOut == 'deposit'
                ? Iconsax.arrow_down
                : Iconsax.arrow_up_3,
            color: transaction.inOut == 'deposit'
                ? MyColor.greenColor
                : MyColor.redColor,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (transaction.type != null)
                Text(
                  getDescription(transaction),
                  maxLines: 1,
                  style: MyStyle.tx12Black.copyWith(
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 12.sp,
                    color: MyColor.blackColor,
                  ),
                ),
              if (transaction.type == 'data' || transaction.type == 'airtime')
                Text(
                  transaction.apiStatus == 'refunded'
                      ? refundedDesc(transaction)
                      : transaction.type == 'data'
                          ? transaction.networkName!
                          : '${getOperator(transaction).toUpperCase()}',
                  maxLines: 1,
                  style: MyStyle.tx12Black.copyWith(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: MyColor.blackColor),
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
                      color: MyColor.blackColor),
                ),
              ],
              SizedBox(height: 5.h),
              Text(
                formatDateTime(DateTime.parse(transaction.transDate!)),
                style: MyStyle.tx12Black.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  fontStyle: FontStyle.italic,
                  color: MyColor.blackColor,
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
            Text(
              '₦${formatNumber(num.parse(transaction.amount!))}',
              style: MyStyle.tx12Black.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                  color: MyColor.blackColor),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
              
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
                        (transaction.apiStatus?.contains('pending') ?? false) ||
                        getStatus(transaction) == MyColor.orange01Color) {
                      ErrorToast(
                          'No receipt available yet. Your order has not been completed.');
                    } else {
                      // if (transaction.type == 'electricity' ||
                      //     transaction.type == 'cable') {
                      //   model.getReceipt({
                      //     'id': transaction.id,
                      //     'type': transaction.type == 'electricity'
                      //         ? 'electricity'
                      //         : 'cable',
                      //   }, callback: () {
                      //     viewReceipt(
                      //       transaction: transaction,
                      //       getPhone: getPhone,
                      //       getOperator: getOperator,
                      //       context: context,
                      //     );
                      //   });
                      // } else {
                        viewReceipt(
                          transaction: transaction,
                          getPhone: getPhone,
                          getOperator: getOperator,
                          context: context,
                        );
                      // }
                    }
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: MyColor.lightGreen.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'View Details',
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
    required AllTransaction transaction,
    required String Function(AllTransaction transaction) getPhone,
    required String Function(AllTransaction transaction) getOperator,
    required BuildContext context,
  }) {
    // final model = context.read<ServiceProvider>();
    // if (transaction.type == Type.ELECTRICITY) {
    //   Get.to(CableElectSuccessScreen(
    //     data: model.receiptModel?.info?.toJson() ?? {},
    //     isCable: false,
    //     amount: transaction.amount!,
    //     isTransaction: true,
    //   ));
    // } else {
      Get.to(
        ReceiptScreen(
          status: '1',
        isDeposit: transaction.inOut == 'deposit',
          isRefunded: transaction.apiStatus == 'refunded',
        isElectricity: transaction.type == 'electricity',
        isCable: transaction.type == 'cable',
        serviceDetails: transaction.type!.capitalizeFirst!,
          referenceNo: transaction.reference!,
          amount: transaction.amount!,
        description: transaction.type!.capitalizeFirst!,
          date: transaction.transDate!.toString(),
        ),
      );
    }
  // }

}
