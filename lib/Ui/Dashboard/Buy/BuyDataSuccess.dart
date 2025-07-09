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
          'You have successfully purchased ${Utils.naira}${widget.amount}  \n${widget.isData ? "data bundle" : "airtime"} to ${widget.phone}',
      onTap: () {
                  if (widget.isData) {
                    model.getDataHistory(isLoading: false);
                    Get.close(2);
                  } else {
                    model.getAirtimeHistory(isLoading: false);
                    Get.close(3);
                  }
      },
    );
   
  }
}
