import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';


class PendingPurchase extends StatefulWidget {
  final bool isData;
  final String amount;
  final String phone;
  final bool isFailed;
  const PendingPurchase(
      {super.key,
      this.isData = true,
      this.isFailed = false,
      required this.amount,
      required this.phone});

  @override
  State<PendingPurchase> createState() => _PendingPurchaseState();
}

class _PendingPurchaseState extends State<PendingPurchase> {

  @override
  Widget build(BuildContext context) {
    final model = context.read<AccountProvider>();
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
                      gradient: LinearGradient(
                        colors: widget.isFailed
                            ? [
                                MyColor.redColor,
                                const Color(0xFFF7786F),
                              ]
                            : [

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
                        widget.isFailed
                            ? 'Transaction Failed'
                            :
                        'Purchase Pending',
                        style: MyStyle.tx16White.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.info,
                          color: widget.isFailed
                              ? MyColor.redColor
                              : MyColor.orange01Color,
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 40,
              ),
              Text(
                widget.isFailed
                    ? "Please check your phone number and network selection, then try again."
                    :
                "Purchase pending. Awaiting network confirmation. You’ll be updated once successful or refunded if it fails. Thanks for your patience.",
                textAlign: TextAlign.center,
                style: MyStyle.tx18Black.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.tertiary),
              ),

              const SizedBox(
                height: 32,
              ),
              OutlinedButton(
                onPressed: () {
                  if (widget.isData) {
                    model.getDataHistory(isLoading: false);
                    Get.close(2);
                  } else {
                    model.getAirtimeHistory(isLoading: false);
                    Get.close(3);
                  }
                },
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
                  'Got It',
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
