import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/bottom_nav.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';

class SocialSuccessScreen extends StatefulWidget {
  const SocialSuccessScreen({super.key});

  @override
  State<SocialSuccessScreen> createState() => _SocialSuccessScreenState();
}

class _SocialSuccessScreenState extends State<SocialSuccessScreen> {
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
            children: [
              const SizedBox(
                height: 200,
              ),
              Image.asset('assets/images/successB.png'),
              const SizedBox(
                height: 40,
              ),
              Text(
                "Your ad has been placed successfully! Our team will review and publish it shortly. You'll soon reach new customers and drive real results for your business. Thank you for choosing us to help grow your brand",
                textAlign: TextAlign.center,
                style: MyStyle.tx14Grey.copyWith(
                    color: Theme.of(context).colorScheme.tertiary, height: 2.5),
              ),
              const SizedBox(
                height: 32,
              ),
              GestureDetector(
                onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BottomNav())),
                child: Text(
                  'Go Homepage',
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
