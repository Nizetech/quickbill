import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/common/failed_screen.dart';
import 'package:jost_pay_wallet/common/pending_screen.dart';
import 'package:provider/provider.dart';

class PendingFailedPurchase extends StatelessWidget {
  final bool isData;

  final bool isFailed;
  const PendingFailedPurchase(
      {super.key,
    this.isData = false,
      this.isFailed = false,
});

  @override
  Widget build(BuildContext context) {
    final model = context.read<AccountProvider>();
    return isFailed
        ? FailedScreen(onTap: () {
            if (isData) {
              model.getDataHistory(isLoading: false);
              Get.close(3);
            } else {
              model.getAirtimeHistory(isLoading: false);
              Get.close(4);
            }
          })
        : PendingScreen(onTap: () {
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
