import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/common/success_screen.dart';
import 'package:provider/provider.dart';

class BuyCarScriptSuccess extends StatelessWidget {
  final bool isCar;
  const BuyCarScriptSuccess({super.key, required this.isCar});

  @override
  Widget build(BuildContext context) {
    final model = context.read<ServiceProvider>();
    return SuccessScreen(
      title:
          "Your order has been successfully placed. You will recieve an email for more details.",
      onTap: () {
        if (isCar) {
          model.getCarsTransactions(isLoading: false);
        } else {
          model.getScriptTransactions();
        }
        Get.close(3);
      },
    );
  }
}
