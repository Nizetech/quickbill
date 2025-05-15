import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';

import '../../../bottom_nav.dart';

class BuyDataSuccess extends StatefulWidget {
  const BuyDataSuccess({super.key});

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
                'You have successfully purchased N350',
                style: MyStyle.tx18Black
                    .copyWith(color: Theme.of(context).colorScheme.tertiary),
              ),
              Text(
                'data bundle to 09087653678',
                style: MyStyle.tx18Black
                    .copyWith(color: Theme.of(context).colorScheme.tertiary),
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
