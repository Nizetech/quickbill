
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_bills/Values/Helper/helper.dart';
import 'package:quick_bills/Values/MyColor.dart';
import 'package:quick_bills/Values/MyStyle.dart';
import 'package:quick_bills/common/button.dart';

class SuccessScreen extends StatelessWidget {
  final String title;
  final String status;
  final String amount;
  final VoidCallback onTap;
  const SuccessScreen({
    super.key,
    required this.title,
    required this.status,
    required this.onTap,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 20,
      ),
          decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        color: MyColor.whiteColor,
          ),
          child: Column(
            children: [
          const SizedBox(height: 20),
          Image.asset(
            status == 'success'
                ? 'assets/images/success.png'
                : status == 'pending'
                    ? 'assets/images/pending.png'
                    : 'assets/images/failed.png',
            height: 180,
          ),
          const SizedBox(height: 10),
          Text(
            status == 'success'
                ? '🎉Success'
                : status == 'pending'
                    ? 'Your ${title.toLowerCase()} purchase is pending'
                    : 'Transaction Failed!',
            textAlign: TextAlign.center,
            style: MyStyle.tx14Black.copyWith(
              color: MyColor.blackColor,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          Text(
            "You've successfully purchased N${formatNumber(num.parse(amount))} $title.",
            textAlign: TextAlign.center,
            style: MyStyle.tx14Grey.copyWith(
              // color: MyColor.grey02Color,
              fontWeight: FontWeight.w500,
            ),
          ),
              SizedBox(height: 30),
              CustomButton(
                text: "Buy More",
            fontWeight: FontWeight.w500,
                onTap: onTap,
              ),
          SizedBox(height: 20),
            ],
          ),
    );
  }
}

void showSuccessScreen({
  required String title,
  required String status,
  required String amount,
  required VoidCallback onTap,
}) {
  showModalBottomSheet(
    context: Get.context!,
    isDismissible: false,
    backgroundColor: MyColor.whiteColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    builder: (context) => SuccessScreen(
      title: title,
      status: status,
      onTap: onTap,
      amount: amount,
    ),
  );
}
