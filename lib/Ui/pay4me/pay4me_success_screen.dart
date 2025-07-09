import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/common/success_screen.dart';
import 'package:provider/provider.dart';

class Pay4meSuccessScreen extends StatefulWidget {
  const Pay4meSuccessScreen({super.key});

  @override
  State<Pay4meSuccessScreen> createState() => _Pay4meSuccessScreenState();
}

class _Pay4meSuccessScreenState extends State<Pay4meSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    final model = context.read<AccountProvider>();
    return SuccessScreen(
      title: 
                "Your Pay4Me order has been successfully placed. Our team is reviewing your request, and your invoice will be paid within 24 hours. You will receive a status update once the payment is completed",
      onTap: () {
                  model.getPay4MeHistory(isLoading: false);
                  Get.close(3);
      },
    );

  }
}
