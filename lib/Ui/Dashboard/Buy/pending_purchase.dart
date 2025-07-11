import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Values/utils.dart';
import 'package:jost_pay_wallet/common/failed_screen.dart';
import 'package:jost_pay_wallet/common/pending_screen.dart';
import 'package:provider/provider.dart';

class PendingFailedPurchase extends StatelessWidget {
  final bool isData;
final String? plan;
  final String? phone;
  final String? amount;
  final bool isFailed;
  const PendingFailedPurchase(
      {super.key,
    this.isData = false,
    this.plan,
    this.phone,
    this.amount,
      this.isFailed = false,
});

  @override
  Widget build(BuildContext context) {
    final model = context.read<AccountProvider>();
    return isFailed
        ? FailedScreen(
            title:
                "We couldn’t process your ${isData ? "data" : "airtime"} transaction at the moment, \nplease try again later.",
            onTap: () {
            if (isData) {
              model.getDataHistory(isLoading: false);
              Get.close(3);
            } else {
              model.getAirtimeHistory(isLoading: false);
              Get.close(4);
            }
          })
        : PendingScreen(
            title: isData
                ? "Data purchase of $plan plan for $phone is currently processing."
                : ": Airtime purchase of ${Utils.naira} $amount to $phone is being processed. Please wait",
            onTap: () {
            if (isData) {
                    model.getDataHistory(isLoading: false);
                    Get.close(3);
                  } else {
                    model.getAirtimeHistory(isLoading: false);
                    Get.close(4);
                  }
          }
         
       
    );
    
  }
}
