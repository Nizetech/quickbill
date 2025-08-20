import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
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
      title: isCar
          ? "Car purchase request submitted successfully."
          : "Script purchased successfully. A download link has been sent to your email.",
      subtitle: isCar
          ? "We process car orders within a few minutes."
          : "Script purchase is instant. Please check your email.",
      onTap: () {
        if (isCar) {
          model.getCarsTransactions(
              isLoading: false, account: context.read<AccountProvider>());
        } else {  
          model.getScriptTransactions(account: context.read<AccountProvider>());
        }
        Get.close(3);
      },
    );
  }
}
