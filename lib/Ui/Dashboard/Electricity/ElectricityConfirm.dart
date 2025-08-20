import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/AddFunds.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Electricity/ElectricitySuccess.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';

import '../../../bottom_nav.dart';

class ElectricityConfirm extends StatefulWidget {
  const ElectricityConfirm({super.key});


  @override
  State<ElectricityConfirm> createState() => _ElectricityConfirmState();
}

class _ElectricityConfirmState extends State<ElectricityConfirm> {


  final List<Map<String,dynamic>> data = [
    {
      'img': 'assets/images/elec-1.png',
      'title': 'Ibadan Electricity'
    },
    {
      'img': 'assets/images/elec-2.png',
      'title': 'Ikeja Electricity'
    },
    {
      'img': 'assets/images/elec-3.png',
      'title': 'Abuja Electricity'
    },
    {
      'img': 'assets/images/elec-1.png',
      'title': 'Ibadan Electricity'
    },
    {
      'img': 'assets/images/elec-2.png',
      'title': 'Ikeja Electricity'
    },
    {
      'img': 'assets/images/elec-3.png',
      'title': 'Abuja Electricity'
    },
  ];

  final List<Map<String, dynamic>> bundles = [
    {
      'title': '1GB(1 day)',
      'price': 'N350',
      'reduce': '5% off'
    },
    {
      'title': '1GB(1 day)',
      'price': 'N350',
      'reduce': '5% off'
    },
    {
      'title': '1GB(1 day)',
      'price': 'N350',
      'reduce': '5% off'
    },
  ];

  int selectedItem = 0;
  String selectedBundle = '';

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
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNav())),
                  child: Image.asset(
                    'assets/images/arrow_left.png',
                  ),
                ),
                const Spacer(),
                Transform.translate(
                  offset: const Offset(-20, 0),
                  child: const Text(
                    'Electricity Bills Summary',
                    style: MyStyle.tx18Black,
                  ),
                ),
                const Spacer(), // Adds flexible space after the text
              ],
            ),
            const SizedBox(height: 30,),
            Container(
              height: 125,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 0.8,
                      color: MyColor.borderColor
                  ),
                  borderRadius: BorderRadius.circular(16)
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        const Text('Total balance', style: MyStyle.tx12Grey,),
                        Row(
                          children: [
                            Image.asset('assets/images/currency.png', width: 15,),
                            const Text('10,000.', style: MyStyle.tx32Black,),
                            const Text('20', style: MyStyle.tx20Grey,)
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddFunds()))
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: MyColor.greenColor,
                        padding: const EdgeInsets.only(top: 6, bottom: 6, left: 24, right: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Text(
                            "Add fund",
                            style: MyStyle.tx12White,
                          ),
                          Image.asset('assets/images/arrow-up.png')
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30,),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                boxShadow: const [MyStyle.widgetShadow],
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset('assets/images/elec-1.png'),
                  ),
                  const SizedBox(height: 12,),
                  Text('Data Package Summary', style: MyStyle.tx14Black.copyWith(
                      fontFamily: 'Roboto'
                  ),),
                  const SizedBox(height: 24,),
                  Row(
                    children: [
                      const Text('Bill Package', style: MyStyle.tx12Grey,),
                      const Spacer(),
                      Text('Prepaid', style: MyStyle.tx12Black.copyWith(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'SF Pro Rounded'
                      ),),
                    ],
                  ),
                  const SizedBox(height: 12,),
                  Row(
                    children: [
                      const Text('Token number', style: MyStyle.tx12Grey,),
                      const Spacer(),
                      Text('12345678902102482', style: MyStyle.tx12Black.copyWith(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'SF Pro Rounded'
                      ),),
                    ],
                  ),
                  const SizedBox(height: 12,),
                  Row(
                    children: [
                      const Text('Date', style: MyStyle.tx12Grey,),
                      const Spacer(),
                      Text('12 Jul 2024', style: MyStyle.tx12Black.copyWith(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'SF Pro Rounded'
                      ),),
                    ],
                  ),
                  const SizedBox(height: 12,),
                  Row(
                    children: [
                      const Text('Customer Name', style: MyStyle.tx12Grey,),
                      const Spacer(),
                      Text('Azeez Maxwell', style: MyStyle.tx12Black.copyWith(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'SF Pro Rounded'
                      ),),
                    ],
                  ),
                  const SizedBox(height: 12,),
                  Row(
                    children: [
                      const Text('Transaction Ref', style: MyStyle.tx12Grey,),
                      const Spacer(),
                      Text('678ER46323JR', style: MyStyle.tx12Black.copyWith(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'SF Pro Rounded'
                      ),),
                    ],
                  ),
                  const SizedBox(height: 12,),
                  SizedBox(
                    width: double.infinity, // Full width of the screen
                    height: 4, // Adjust height as needed
                    child: Stack(
                      children: [
                        // Bottom border
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: DottedBorder(
                            color: MyColor.borderColor,
                            strokeWidth: 1,
                            dashPattern: const [6, 3], // Dash pattern: 6 units line, 3 units space
                            customPath: (size) => Path()
                              ..moveTo(0, 0)
                              ..lineTo(size.width, 0),
                            child: Container(
                              height: 0, // The container for the border can have a height of 0
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Row(
                    children: [
                      const Text('Amount', style: MyStyle.tx12Grey,),
                      const Spacer(),
                      Text('N 350', style: MyStyle.tx14Black.copyWith(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'SF Pro Rounded'
                      ),),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30,),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: MyColor.greenColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ElectricitySuccess()));
                },
                child: Text(
                  "Confirm",
                  style: NewStyle.btnTx16SplashBlue
                      .copyWith(color: NewColor.mainWhiteColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
