import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/bottom_nav.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';

class Pay4meSuccessScreen extends StatefulWidget {
  const Pay4meSuccessScreen({super.key});

  @override
  State<Pay4meSuccessScreen> createState() => _Pay4meSuccessScreenState();
}

class _Pay4meSuccessScreenState extends State<Pay4meSuccessScreen> {
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
                "Your Pay4Me order has been successfully placed. Our team is reviewing your request, and your invoice will be paid within 24 hours. You will receive a status update once the payment is completed",
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
