import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/utils.dart';

import '../../../bottom_nav.dart';

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 54, left: 24, right: 24),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 200,
              ),
              Image.asset('assets/images/Explode.png'),
              const SizedBox(
                height: 40,
              ),
              Text(
                'You have successfully purchased ${Utils.naira}${widget.amount}',
                style: MyStyle.tx18Black
                    .copyWith(color: Theme.of(context).colorScheme.tertiary),
              ),
              Text(
                ' ${widget.isData ? "data bundle" : "airtime"} to ${widget.phone}',
                style: MyStyle.tx18Black
                    .copyWith(color: Theme.of(context).colorScheme.tertiary),
              ),
              const SizedBox(
                height: 32,
              ),
              OutlinedButton(
                onPressed: () => Get.offAll(BottomNav()),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: MyColor.splashBtn,
                    width: 1.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Buy more',
                  style:
                      MyStyle.tx16Green.copyWith(fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
