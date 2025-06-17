import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/bottom_nav.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';

class BuyCarSuccess extends StatefulWidget {
  const BuyCarSuccess({super.key});

  @override
  State<BuyCarSuccess> createState() => _BuyCarSuccessState();
}

class _BuyCarSuccessState extends State<BuyCarSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 54, left: 24, right: 24),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(100),
                      gradient: const LinearGradient(
                        colors: [
                          MyColor.greenColor,
                          Color(0xff00c26d),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      Text(
                        "Order Successful!",
                        style: MyStyle.tx16White.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Spacer(),
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.check,
                          color: MyColor.greenColor,
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 40,
              ),
              Text(
                "Your order has been successfully placed. You will recieve an email for more details.",
                textAlign: TextAlign.center,
                style: MyStyle.tx14Grey.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              TextButton(
                onPressed: () => Get.offAll(BottomNav()),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  side: BorderSide(color: MyColor.greenColor),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(
                  'Got it',
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
