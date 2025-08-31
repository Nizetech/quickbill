import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Values/utils.dart';
import 'package:jost_pay_wallet/common/success_screen.dart';
import 'package:provider/provider.dart';

class BuyDataSuccess extends StatefulWidget {
  final bool isData;
  final String amount;
  final String phone;
  const BuyDataSuccess(
      {super.key,
      this.isData = true,
      required this.amount,
      required this.phone});

  @override
  State<BuyDataSuccess> createState() => _BuyDataSuccessState();
}

class _BuyDataSuccessState extends State<BuyDataSuccess> {
  @override
  Widget build(BuildContext context) {
    final model = context.read<AccountProvider>();
    return SuccessScreen(
      title:
          widget.isData
          ? "Data purchase plan for ${widget.phone} was successful."
          : 'Airtime purchase of ${Utils.naira}${widget.amount} to ${widget.phone} was successful.',
      subtitle: widget.isData
          ? "Data typically delivers in seconds"
          : "Airtime typically delivers in seconds",
      onTap: () {
                  if (widget.isData) {
                    model.getDataHistory(isLoading: false);
          Get.close(3);
                  } else {
                    model.getAirtimeHistory(isLoading: false);
                    Get.close(3);
                  }
      },
    );
   
  }
}
