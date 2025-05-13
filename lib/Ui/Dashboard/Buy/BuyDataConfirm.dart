import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/BuyData.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/BuyDataSuccess.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:provider/provider.dart';

class BuyDataConfirm extends StatefulWidget {
  const BuyDataConfirm({super.key});

  @override
  State<BuyDataConfirm> createState() => _BuyDataConfirmState();
}

class _BuyDataConfirmState extends State<BuyDataConfirm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 54, left: 24, right: 24),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const BuyData())),
                  child: Image.asset(
                    'assets/images/arrow_left.png',
                    color: themeProvider.isDarkMode()
                        ? MyColor.mainWhiteColor
                        : MyColor.dark01Color,
                  ),
                ),
                const Spacer(),
                Transform.translate(
                  offset: const Offset(-20, 0),
                  child: Text(
                    'Buy Data',
                    style: MyStyle.tx18Black.copyWith(
                      color: themedata.tertiary,
                    ),
                  ),
                ),
                const Spacer(), // Adds flexible space after the text
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  boxShadow: const [MyStyle.widgetShadow],
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset('assets/images/operator-1.png'),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Data Package Summary',
                    style: MyStyle.tx14Black.copyWith(
                        color: themedata.tertiary, fontFamily: 'Roboto'),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Data Plan',
                        style: MyStyle.tx12Grey,
                      ),
                      const Spacer(),
                      Text(
                        '1GB+3min daily plan',
                        style: MyStyle.tx12Black.copyWith(
                            color: themedata.tertiary,
                            fontFamily: 'SF Pro Rounded'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Expiry Date',
                        style: MyStyle.tx12Grey,
                      ),
                      const Spacer(),
                      Text(
                        '1 day',
                        style: MyStyle.tx12Black.copyWith(
                            color: themedata.tertiary,
                            fontFamily: 'SF Pro Rounded'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Carrier',
                        style: MyStyle.tx12Grey,
                      ),
                      const Spacer(),
                      Text(
                        'MTN Direct Top-up (Prepaid)',
                        style: MyStyle.tx12Black.copyWith(
                            color: themedata.tertiary,
                            fontFamily: 'SF Pro Rounded'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Phone Number',
                        style: MyStyle.tx12Grey,
                      ),
                      const Spacer(),
                      Text(
                        '09078637583',
                        style: MyStyle.tx12Black.copyWith(
                            color: themedata.tertiary,
                            fontFamily: 'SF Pro Rounded'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
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
                            color: themeProvider.isDarkMode()
                                ? MyColor.borderDarkColor
                                : MyColor.borderColor,
                            strokeWidth: 1,
                            dashPattern: const [
                              6,
                              3
                            ], // Dash pattern: 6 units line, 3 units space
                            customPath: (size) => Path()
                              ..moveTo(0, 0)
                              ..lineTo(size.width, 0),
                            child: Container(
                              height:
                                  0, // The container for the border can have a height of 0
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Amount',
                        style: MyStyle.tx12Grey,
                      ),
                      const Spacer(),
                      Text(
                        'N 350',
                        style: MyStyle.tx14Black.copyWith(
                            fontWeight: FontWeight.w600,
                            color: themedata.tertiary,
                            fontFamily: 'SF Pro Rounded'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
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
                          builder: (context) => const BuyDataSuccess()));
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
