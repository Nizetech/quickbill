import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/common/pending_screen.dart';
import 'package:jost_pay_wallet/common/success_screen.dart';
import 'package:provider/provider.dart';

class CableElectricitySuccessScreen extends StatefulWidget {
  final bool isCable;
  final bool isPending;
  final Map<String, dynamic>? data;
  const CableElectricitySuccessScreen({
    super.key,
    this.isCable = true,
    this.isPending = false,
    this.data,
  });

  @override
  State<CableElectricitySuccessScreen> createState() =>
      _CableElectricitySuccessScreenState();
}

class _CableElectricitySuccessScreenState
    extends State<CableElectricitySuccessScreen> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ServiceProvider>(context, listen: false);
    return widget.isPending
        ? PendingScreen(
            title: widget.isCable
                ? "Cable subscription is being processed please wait "
                : "Electricity subscription is being processed please wait",
            onTap: () {
              Get.close(3);
            },
          )
        : SuccessScreen(
            title: widget.isCable
                ? "Cable subscription placed successfully"
                : "Electricity subscription placed successfully. \nToken: ${widget.data?['token']} \n Unit: ${widget.data?['unit']} Kwh",
            subtitle: widget.isCable
                ? "Cable subscriptions are usually completed within minutes to hours."
                : "Electricity subscriptions complete within minutes to hours.",
            onTap: () {
              if (widget.isCable) {
                model.getCableTransactions(
                    isLoading: false, account: context.read<AccountProvider>());
              } else {
                model.getElectricityTransactions(
                    isLoading: false, account: context.read<AccountProvider>());
              }
              Get.close(3);
            },
          );
  }
}
