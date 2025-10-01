import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/common/pending_screen.dart';
import 'package:jost_pay_wallet/common/success_screen.dart';
import 'package:provider/provider.dart';

class Pay4meSuccessScreen extends StatefulWidget {
  final bool isPending;
  const Pay4meSuccessScreen({super.key, this.isPending = false});

  @override
  State<Pay4meSuccessScreen> createState() => _Pay4meSuccessScreenState();
}

class _Pay4meSuccessScreenState extends State<Pay4meSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    final model = context.read<AccountProvider>();
    return widget.isPending
        ? PendingScreen(
            title: "Pay4Me subscription is being processed please wait",
            onTap: () {
              model.getPay4MeHistory(isLoading: false);
              Get.close(3);
            },
          )
        : SuccessScreen(
      title: "Pay4Me order placed successfully",
      subtitle: "Pay4Me orders are usually completed within 24 hours.",
      onTap: () {
                  model.getPay4MeHistory(isLoading: false);
                  Get.close(3);
      },
    );

  }
}
