import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
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
                        "Pay4me success!",
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
                "Your Pay4Me order has been successfully placed. Our team is reviewing your request, and your invoice will be paid within 24 hours. You will receive a status update once the payment is completed",
                textAlign: TextAlign.center,
                style: MyStyle.tx14Grey.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              TextButton(
                onPressed: () {
                  model.getPay4MeHistory(isLoading: false);
                  Get.close(3);
                },
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
