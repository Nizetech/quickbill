import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';

import '../DashboardScreen.dart';

class ElectricitySuccess extends StatefulWidget {
  const ElectricitySuccess({super.key});


  @override
  State<ElectricitySuccess> createState() => _ElectricitySuccessState();
}

class _ElectricitySuccessState extends State<ElectricitySuccess> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 54, left: 24, right: 24),
        child:
        Column(
          children: [
            const SizedBox(height: 200,),
            Image.asset('assets/images/Explode.png'),
            const SizedBox(height: 40,),
            Text('Your electricity token purchase was', style: MyStyle.tx18Black.copyWith(
                color: const Color(0xFF565B66)
            ),),
            Text('successful', style: MyStyle.tx18Black.copyWith(
                color: const Color(0xFF565B66)
            ),),
            const SizedBox(height: 32,),
            GestureDetector(
              onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DashboardScreen())),
              child: Text('Share Receipt', style: MyStyle.tx16Green.copyWith(
                  fontWeight: FontWeight.w600
              ),),
            )
          ],
        ),

      ),
    );
  }
}
