import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';

import '../../../bottom_nav.dart';

class InvalidPurchase extends StatefulWidget {
  const InvalidPurchase({
    super.key,
  });

  @override
  State<InvalidPurchase> createState() => _InvalidPurchaseState();
}

class _InvalidPurchaseState extends State<InvalidPurchase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 54, left: 24, right: 24),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 200,
              ),
              // Image.asset('assets/images/Explode.png'),
              Icon(
                Icons.error,
                size: 100,
                color: MyColor.redColor,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "Invalid Input",
                textAlign: TextAlign.center,
                style: MyStyle.tx18Black.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.tertiary),
              ),
              SizedBox(height: 10),
              Text(
                "Looks like the phone number or network you entered isn’t correct. Please check and try again.",
                textAlign: TextAlign.center,
                style: MyStyle.tx18Black.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.tertiary),
              ),

              const SizedBox(
                height: 32,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: CustomButton(
                  onTap: () => Get.offAll(BottomNav()),
                  text: 'Got It',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
