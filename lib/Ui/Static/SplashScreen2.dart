import 'package:jost_pay_wallet/Ui/Static/SplashScreen3.dart';
import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';


class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({super.key});

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {

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
              'assets/images/splash/splash-2.png', // Replace with your image asset
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
                currentStep: 2,
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
                    const Row(
                      children: [
                        Text(
                            'Electricity & Cable TV',
                            style: TextStyle(
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
                        const Text('Pay electricity bills easily and securely', style: MyStyle.tx18White,)
                      ],
                    ),
                    const SizedBox(height: 14,),
                    Row(
                      children: [
                        Image.asset("assets/images/splash/li-icon.png", width: 36, height: 36,),
                        const SizedBox(width: 8,),
                        const Text('Support for multiple electricity \nproviders', style: MyStyle.tx18White,)
                      ],
                    ),
                    const SizedBox(height: 14,),
                    Row(
                      children: [
                        Image.asset("assets/images/splash/li-icon.png", width: 36, height: 36,),
                        const SizedBox(width: 8,),
                        const Text('Schedule payment for later', style: MyStyle.tx18White,)
                      ],
                    ),
                    const SizedBox(height: 14,),
                    Row(
                      children: [
                        Image.asset("assets/images/splash/li-icon.png", width: 36, height: 36,),
                        const SizedBox(width: 8,),
                        const Text('Secure & reliable transaction', style: MyStyle.tx18White,)
                      ],
                    ),
                    const SizedBox(height: 36,),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SplashScreen3())),
                        style: TextButton.styleFrom(
                          backgroundColor: MyColor.splashBtn.withOpacity(0.7),
                          padding:
                          const EdgeInsets.symmetric(vertical: 16), // Padding
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text("Continue" ,style: MyStyle.tx16White,),
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
