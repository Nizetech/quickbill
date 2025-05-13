import 'package:jost_pay_wallet/Ui/Authentication/SignUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';


class SplashScreenAfter extends StatefulWidget {
  const SplashScreenAfter({super.key});

  @override
  State<SplashScreenAfter> createState() => _SplashScreenAfterState();
}

class _SplashScreenAfterState extends State<SplashScreenAfter> {
  int pageIndex = 0;

  final List<Map<String, dynamic>> data = [
    {
      'image': 'assets/images/splash-1.png',
      'title': 'Data & Airtime',
      'detail1': 'Covert your airtime to cash on the go',
      'detail2': 'Over 5+ services provider supported',
      'detail3': 'Instant Recharge',
      'detail4': 'Easy recharge for yourself & others',
    },
    {
      'image': 'assets/images/splash/splash-2.png',
      'title': 'Electricity & Cable TV',
      'detail1': 'Pay electricity bills easily and securely',
      'detail2': 'Support for multiple electricity providers',
      'detail3': 'Schedule payment for later',
      'detail4': 'Secure & reliable transaction',
    },
    {
      'image': 'assets/images/splash/splash-3.png',
      'title': 'Bulk Email & SMS',
      'detail1': 'Reach multiple recipient with just a tap',
      'detail2': 'Personalize messages with names',
      'detail3': 'Fast like a speed of light',
      'detail4': 'Schedule sms to be sent later',
    },
    {
      'image': 'assets/images/splash/splash-4.png',
      'title': 'Pay4me',
      'detail1': 'Available for transaction worldwide',
      'detail2': 'Easy Payment for purchase',
      'detail3': 'Support various platform (upwork,fiverr)',
      'detail4': 'Accessible all time',
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Full screen background image
          Positioned.fill(
            child: Image.asset(
              data[pageIndex]['image'], // Replace with your image asset
              fit: BoxFit.cover, // Cover the entire screen
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 61, left: 24, right: 24), // Set top padding here
            child: Align(
              alignment: Alignment.topCenter,
                child: LinearProgressBar(
                maxSteps: 5,
                progressType: LinearProgressBar.progressTypeLinear,
                currentStep: pageIndex + 1,
                progressColor: Colors.white,
                backgroundColor: MyColor.progressBarBack,
                valueColor: const AlwaysStoppedAnimation<Color>(MyColor.progressBar),
                semanticsLabel: "Label",
                semanticsValue: "Value",
                minHeight: 8,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 446,
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6), // Black color with opacity
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(23.7),  // Top left corner
                  topRight: Radius.circular(23.7), // Top right corner
                ),
              ),// Black color with opacity
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        data[pageIndex]['title'],
                        style: const TextStyle(
                          fontSize: 34,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'SF Pro Rounded'
                        )
                      )
                    ],
                  ),
                  const SizedBox(height: 36,),
                  Row(
                    children: [
                      Image.asset("assets/images/splash/li-icon.png", width: 36, height: 36,),
                      const SizedBox(width: 8,),
                      Text(data[pageIndex]['detail1'], style: MyStyle.tx18White,)
                    ],
                  ),
                  const SizedBox(height: 14,),
                  Row(
                    children: [
                      Image.asset("assets/images/splash/li-icon.png", width: 36, height: 36,),
                      const SizedBox(width: 8,),
                      Text(data[pageIndex]['detail2'], style: MyStyle.tx18White,)
                    ],
                  ),
                  const SizedBox(height: 14,),
                  Row(
                    children: [
                      Image.asset("assets/images/splash/li-icon.png", width: 36, height: 36,),
                      const SizedBox(width: 8,),
                      Text(data[pageIndex]['detail3'], style: MyStyle.tx18White,)
                    ],
                  ),
                  const SizedBox(height: 14,),
                  Row(
                    children: [
                      Image.asset("assets/images/splash/li-icon.png", width: 36, height: 36,),
                      const SizedBox(width: 8,),
                      Text(data[pageIndex]['detail4'], style: MyStyle.tx18White,)
                    ],
                  ),
                  const SizedBox(height: 36,),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () => {
                          if(pageIndex == 3) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpScreen()))
                          }
                          else
                            setState(() {
                              pageIndex++;
                            })
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF1cfc03).withOpacity(0.6),
                          padding:
                          const EdgeInsets.symmetric(vertical: 16), // Padding
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(pageIndex != 3 ? "Continue" : "Get me in",style: MyStyle.tx16White,),
                    ),
                  )
                ],
              )
            ),
          ),
        ],
      ),
    );
  }
}
