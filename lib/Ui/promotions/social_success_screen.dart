import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class SocialSuccessScreen extends StatefulWidget {
  final bool isGiftCard;
  const SocialSuccessScreen({super.key, this.isGiftCard = false});

  @override
  State<SocialSuccessScreen> createState() => _SocialSuccessScreenState();
}

class _SocialSuccessScreenState extends State<SocialSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AccountProvider>(context, listen: false);
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
                        widget.isGiftCard
                            ? 'Gift Card Purchased'
                            : 'Purchase Successful!',
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
              // Image.asset('assets/images/successB.png'),
              const SizedBox(
                height: 40,
              ),
              Text(
                widget.isGiftCard
                    ? "Your gift card has been purchased successfully!\n We will confirm as soon as possible."
                    :

            "Thank your for your purchase. Your Social Boost is now being processed.",
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
                  if (widget.isGiftCard) {
                    model.getGiftCradHistory(isLoading: false);
                  } else {
                    model.getSociaBoostHistory(isLoading: false);
                  }
                  Get.close(4);
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
