import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/utils.dart';
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
  void initState() {
    super.initState();
  }

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
                      Text(
                        widget.isData ? 'Data Purchased' : 'Airtime Purchased',
                        style: MyStyle.tx16White.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
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
