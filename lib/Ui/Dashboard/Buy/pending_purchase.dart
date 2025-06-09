import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';

import '../../../bottom_nav.dart';

class PendingPurchase extends StatefulWidget {
  final bool isData;
  final String amount;
  final String phone;
  const PendingPurchase(
      {super.key,
      this.isData = true,
      required this.amount,
      required this.phone});

  @override
  State<PendingPurchase> createState() => _PendingPurchaseState();
}

class _PendingPurchaseState extends State<PendingPurchase> {
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
              // Image.asset('assets/images/Explode.png'),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(100),
                      gradient: const LinearGradient(
                        colors: [
                          MyColor.orange01Color,
                          MyColor.yellowColor,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Purchase Pending',
                        style: MyStyle.tx16White.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.info,
                          color: MyColor.orange01Color,
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 40,
              ),
              Text(
                "Purchase pending. Awaiting network confirmation. You’ll be updated once successful or refunded if it fails. Thanks for your patience.",
                textAlign: TextAlign.center,
                style: MyStyle.tx18Black.copyWith(
                    fontWeight: FontWeight.w600,
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
