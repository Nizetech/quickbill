import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jost_pay_wallet/Provider/DashboardProvider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/BuyAirtime.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/BuyData.dart';
import 'package:jost_pay_wallet/Ui/Domain/domain_screen.dart';
import 'package:jost_pay_wallet/Ui/Paint/paint_history.dart';
import 'package:jost_pay_wallet/Ui/Paint/paint_screen.dart';
import 'package:jost_pay_wallet/Ui/Scripts/script_screen.dart';
import 'package:jost_pay_wallet/Ui/car/carsell_screen.dart';
import 'package:jost_pay_wallet/Ui/car/repair_screen.dart';
import 'package:jost_pay_wallet/Ui/car/repairdetail_screen.dart';
import 'package:jost_pay_wallet/Ui/giftCard/buy_gift_card_screen.dart';
import 'package:jost_pay_wallet/Ui/pay4me/pay4me_screen.dart';
import 'package:jost_pay_wallet/Ui/promotions/social_boost.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

import '../Dashboard/DashboardScreen.dart';

class Services extends StatefulWidget {
  const Services({super.key});

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;

    final dashProvider = Provider.of<DashboardProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode()
          ? MyColor.dark02Color
          : MyColor.mainWhiteColor,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 68, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        dashProvider.changeBottomIndex(0);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DashboardScreen()));
                      },
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
                        'Services',
                        style: MyStyle.tx18Black
                            .copyWith(color: themedata.tertiary),
                      ),
                    ),
                    const Spacer(), // Adds flexible space after the text
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Bundles Package',
                        style: MyStyle.tx18Black.copyWith(
                            fontWeight: FontWeight.w400,
                            color: themedata.tertiary),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const BuyAirtime())),
                            child: Container(
                              width: 155,
                              height: 110,
                              decoration: BoxDecoration(
                                  color: themedata.secondaryContainer,
                                  borderRadius: BorderRadius.circular(13.5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    height: 41,
                                    width: 41,
                                    // padding: const EdgeInsets.all(13),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: themedata.surfaceContainer,
                                        shape: BoxShape.circle),
                                    child: Transform.translate(
                                      offset: const Offset(0, 10),
                                      child: Image.asset(
                                        "assets/images/smart-phone-01.png",
                                        height: 24,
                                        width: 24,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text('Airtime',
                                      style: MyStyle.tx9Green.copyWith()),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Center(
                                    child: Container(
                                      width: 52,
                                      height: 20,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: themedata.secondary,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text(
                                        'Buy Now',
                                        style: MyStyle.tx11Grey.copyWith(
                                            color: MyColor.greenColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 9),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const BuyData())),
                            child: Container(
                              width: 155,
                              height: 110,
                              decoration: BoxDecoration(
                                  color: themedata.secondaryContainer,
                                  borderRadius: BorderRadius.circular(13.5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    height: 41,
                                    width: 41,
                                    // padding: const EdgeInsets.all(13),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: themedata.surfaceContainer,
                                        shape: BoxShape.circle),
                                    child: Transform.translate(
                                      offset: const Offset(0, 10),
                                      child: Image.asset(
                                        "assets/images/smartphone-wifi.png",
                                        height: 24,
                                        width: 24,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'Data',
                                    style: MyStyle.tx9Green.copyWith(),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Center(
                                    child: Container(
                                      width: 52,
                                      height: 20,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: themedata.surfaceContainer,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text(
                                        'Buy Now',
                                        style: MyStyle.tx11Grey.copyWith(
                                            color: MyColor.greenColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 9),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
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
                                color: MyColor.outlineDashColor,
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
                        height: 27,
                      ),
                      Text(
                        'Finance',
                        style: MyStyle.tx18Black.copyWith(
                            fontWeight: FontWeight.w400,
                            color: themedata.tertiary),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Pay4meScreen(),
                                  ));
                            },
                            child: Container(
                              width: 155,
                              height: 110,
                              decoration: BoxDecoration(
                                  color: themedata.secondaryContainer,
                                  borderRadius: BorderRadius.circular(13.5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    height: 41,
                                    width: 41,
                                    // padding: const EdgeInsets.all(13),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: themedata.surfaceContainer,
                                        shape: BoxShape.circle),
                                    child: Transform.translate(
                                        offset: const Offset(0, 0),
                                        child: SvgPicture.asset(
                                          'assets/images/svg/money.svg',
                                          height: 24.r,
                                          width: 24.r,
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'Pay4me',
                                    style: MyStyle.tx9Green.copyWith(),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Center(
                                    child: Container(
                                      width: 52,
                                      height: 20,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: themedata.secondary,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text(
                                        'Try Now',
                                        style: MyStyle.tx11Grey.copyWith(
                                            color: MyColor.greenColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 9),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const BuyGiftCardScreen(),
                                  ));
                            },
                            child: Container(
                              width: 155,
                              height: 110,
                              decoration: BoxDecoration(
                                  color: themedata.secondaryContainer,
                                  borderRadius: BorderRadius.circular(13.5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    height: 41,
                                    width: 41,
                                    // padding: const EdgeInsets.all(13),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: themedata.surfaceContainer,
                                        shape: BoxShape.circle),
                                    child: Transform.translate(
                                        offset: const Offset(0, 0),
                                        child: SvgPicture.asset(
                                          'assets/images/svg/giftCard.svg',
                                          height: 24.r,
                                          width: 24.r,
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'Buy Gift Cards',
                                    style: MyStyle.tx9Green.copyWith(),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Center(
                                    child: Container(
                                      width: 52,
                                      height: 20,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: themedata.surfaceContainer,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text(
                                        'Buy Now',
                                        style: MyStyle.tx11Grey.copyWith(
                                            color: MyColor.greenColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 9),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
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
                                color: MyColor.outlineDashColor,
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
                        height: 38,
                      ),
                      Text(
                        'Web & Social services',
                        style: MyStyle.tx18Black.copyWith(
                            fontWeight: FontWeight.w400,
                            color: themedata.tertiary),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const DomainScreen(),
                              ));
                            },
                            child: Container(
                              width: 155,
                              height: 110,
                              decoration: BoxDecoration(
                                  color: themedata.secondaryContainer,
                                  borderRadius: BorderRadius.circular(13.5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    height: 41,
                                    width: 41,
                                    // padding: const EdgeInsets.all(13),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: themedata.surfaceContainer,
                                        shape: BoxShape.circle),
                                    child: Transform.translate(
                                        offset: const Offset(0, 0),
                                        child: SvgPicture.asset(
                                          'assets/images/svg/web-security.svg',
                                          height: 24.r,
                                          width: 24.r,
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'Hosting & Domain',
                                    style: MyStyle.tx9Green.copyWith(),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Center(
                                    child: Container(
                                      width: 52,
                                      height: 20,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: themedata.secondary,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text(
                                        'Buy Now',
                                        style: MyStyle.tx11Grey.copyWith(
                                            color: MyColor.greenColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 9),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SocialBoost(),
                              ));
                            },
                            child: Container(
                              width: 155,
                              height: 110,
                              decoration: BoxDecoration(
                                  color: themedata.secondaryContainer,
                                  borderRadius: BorderRadius.circular(13.5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    height: 41,
                                    width: 41,
                                    // padding: const EdgeInsets.all(13),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: themedata.surfaceContainer,
                                        shape: BoxShape.circle),
                                    child: Transform.translate(
                                        offset: const Offset(0, 0),
                                        child: SvgPicture.asset(
                                          'assets/images/svg/socialBoost.svg',
                                          height: 24.r,
                                          width: 24.r,
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'Social Boost',
                                    style: MyStyle.tx9Green.copyWith(),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Center(
                                    child: Container(
                                      width: 60,
                                      height: 20,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: themedata.secondary,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text(
                                        'Boost Now',
                                        style: MyStyle.tx11Grey.copyWith(
                                            color: MyColor.greenColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 9),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 23,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ScriptScreen(),
                          ));
                        },
                        child: Container(
                          width: 155,
                          height: 110,
                          decoration: BoxDecoration(
                              color: themedata.secondaryContainer,
                              borderRadius: BorderRadius.circular(13.5)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 12,
                              ),
                              Container(
                                height: 41,
                                width: 41,
                                // padding: const EdgeInsets.all(13),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: themedata.surfaceContainer,
                                    shape: BoxShape.circle),
                                child: Transform.translate(
                                    offset: const Offset(0, 0),
                                    child: SvgPicture.asset(
                                      'assets/images/svg/code.svg',
                                      height: 24.r,
                                      width: 24.r,
                                    )),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Scripts & Template',
                                style: MyStyle.tx9Green.copyWith(),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Center(
                                child: Container(
                                  width: 52,
                                  height: 20,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: themedata.secondary,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(
                                    'Buy Now',
                                    style: MyStyle.tx11Grey.copyWith(
                                        color: MyColor.greenColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 9),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
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
                                color: MyColor.outlineDashColor,
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
                        height: 38,
                      ),
                      Text(
                        'Automotive Care & Services',
                        style: MyStyle.tx18Black.copyWith(
                            fontWeight: FontWeight.w400,
                            color: themedata.tertiary),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const RepairdetailScreen(),
                              ));
                            },
                            child: Container(
                              width: 155,
                              height: 110,
                              decoration: BoxDecoration(
                                  color: themedata.secondaryContainer,
                                  borderRadius: BorderRadius.circular(13.5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    height: 41,
                                    width: 41,
                                    // padding: const EdgeInsets.all(13),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: themedata.surfaceContainer,
                                        shape: BoxShape.circle),
                                    child: Transform.translate(
                                        offset: const Offset(0, 0),
                                        child: SvgPicture.asset(
                                          'assets/images/svg/repair.svg',
                                          height: 24.r,
                                          width: 24.r,
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'Automobile & Repairs',
                                    style: MyStyle.tx9Green.copyWith(),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Center(
                                    child: Container(
                                      width: 52,
                                      height: 20,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: themedata.secondary,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text(
                                        'Buy Now',
                                        style: MyStyle.tx11Grey.copyWith(
                                            color: MyColor.greenColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 9),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const PaintHistory(),
                              ));
                            },
                            child: Container(
                              width: 155,
                              height: 110,
                              decoration: BoxDecoration(
                                  color: themedata.secondaryContainer,
                                  borderRadius: BorderRadius.circular(13.5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    height: 41,
                                    width: 41,
                                    // padding: const EdgeInsets.all(13),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: themedata.surfaceContainer,
                                        shape: BoxShape.circle),
                                    child: Transform.translate(
                                        offset: const Offset(0, 0),
                                        child: SvgPicture.asset(
                                          'assets/images/svg/spray.svg',
                                          height: 24.r,
                                          width: 24.r,
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'Paint & Spray booth',
                                    style: MyStyle.tx9Green.copyWith(),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Center(
                                    child: Container(
                                      width: 66,
                                      height: 20,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: themedata.secondary,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text(
                                        'Schedule Now',
                                        style: MyStyle.tx11Grey.copyWith(
                                            color: MyColor.greenColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 9),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 23,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const CarsellScreen(),
                          ));
                        },
                        child: Container(
                          width: 155,
                          height: 110,
                          decoration: BoxDecoration(
                              color: themedata.secondaryContainer,
                              borderRadius: BorderRadius.circular(13.5)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 12,
                              ),
                              Container(
                                height: 41,
                                width: 41,
                                // padding: const EdgeInsets.all(13),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: themedata.surfaceContainer,
                                    shape: BoxShape.circle),
                                child: Transform.translate(
                                    offset: const Offset(0, 0),
                                    child: SvgPicture.asset(
                                      'assets/images/svg/car.svg',
                                      height: 24.r,
                                      width: 24.r,
                                    )),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Car sales',
                                style: MyStyle.tx9Green.copyWith(),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Center(
                                child: Container(
                                  width: 52,
                                  height: 20,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: themedata.secondary,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(
                                    'Buy Now',
                                    style: MyStyle.tx11Grey.copyWith(
                                        color: MyColor.greenColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 9),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 27,
                      ),
                      // const SizedBox(
                      //   height: 24,
                      // ),
                      // SizedBox(
                      //   width: double.infinity, // Full width of the screen
                      //   height: 4, // Adjust height as needed
                      //   child: Stack(
                      //     children: [
                      //       // Bottom border
                      //       Positioned(
                      //         bottom: 0,
                      //         left: 0,
                      //         right: 0,
                      //         child: DottedBorder(
                      //           color: MyColor.borderColor,
                      //           strokeWidth: 1,
                      //           dashPattern: const [
                      //             6,
                      //             3
                      //           ], // Dash pattern: 6 units line, 3 units space
                      //           customPath: (size) => Path()
                      //             ..moveTo(0, 0)
                      //             ..lineTo(size.width, 0),
                      //           child: Container(
                      //             height:
                      //                 0, // The container for the border can have a height of 0
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // Row(
                      //   children: [
                      //     Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Align(
                      //           alignment: Alignment.centerLeft,
                      //           child: Text(
                      //             'Cable Bills',
                      //             style: MyStyle.tx18Black
                      //                 .copyWith(fontWeight: FontWeight.w400),
                      //           ),
                      //         ),
                      //         const SizedBox(
                      //           height: 20,
                      //         ),
                      //         InkWell(
                      //             onTap: () => Navigator.pushReplacement(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                     builder: (context) =>
                      //                         const CableBills())),
                      //             child: Container(
                      //               width: 155,
                      //               height: 110,
                      //               decoration: BoxDecoration(
                      //                      color: themedata.secondary
                      // .withValues(alpha: 0.6),
                      //                   borderRadius:
                      //                       BorderRadius.circular(13.5)),
                      //               child: Column(
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.center,
                      //                 mainAxisAlignment:
                      //                     MainAxisAlignment.center,
                      //                 children: [
                      //                   const SizedBox(
                      //                     height: 12,
                      //                   ),
                      //                   Container(
                      //                     height: 41,
                      //                     width: 41,
                      //                     // padding: const EdgeInsets.all(13),
                      //                     alignment: Alignment.center,
                      //                     decoration: const BoxDecoration(
                      //                color: themedata.secondary,
                      //                         shape: BoxShape.circle),
                      //                     child: Transform.translate(
                      //                       offset: const Offset(0, 0),
                      //                       child: Image.asset(
                      //                         "assets/images/tv-01.png",
                      //                         height: 24,
                      //                         width: 24,
                      //                       ),
                      //                     ),
                      //                   ),
                      //                   const SizedBox(
                      //                     height: 4,
                      //                   ),
                      //                   const Text(
                      //                     'Cable TV',
                      //                     style: MyStyle.tx9Green,
                      //                   ),
                      //                   const SizedBox(
                      //                     height: 4,
                      //                   ),
                      //                   Center(
                      //                     child: Container(
                      //                       width: 52,
                      //                       height: 20,
                      //                       alignment: Alignment.center,
                      //                       decoration: BoxDecoration(
                      //                  color: themedata.secondary,
                      //                           borderRadius:
                      //                               BorderRadius.circular(4)),
                      //                       child: const Text(
                      //                         'Buy Now',
                      //                         style: MyStyle.tx9Green,
                      //                       ),
                      //                     ),
                      //                   )
                      //                 ],
                      //               ),
                      //             )),
                      //       ],
                      //     ),
                      //     const Spacer(),
                      //     Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Align(
                      //           alignment: Alignment.centerLeft,
                      //           child: Text(
                      //             'Electricity',
                      //             style: MyStyle.tx18Black
                      //                 .copyWith(fontWeight: FontWeight.w400),
                      //           ),
                      //         ),
                      //         const SizedBox(
                      //           height: 20,
                      //         ),
                      //         InkWell(
                      //           onTap: () => Navigator.pushReplacement(
                      //               context,
                      //               MaterialPageRoute(
                      //                   builder: (context) =>
                      //                       const Electricity())),
                      //           child: Container(
                      //             width: 155,
                      //             height: 110,
                      //             decoration: BoxDecoration(
                      //                    color: themedata.secondary
                      // .withValues(alpha: 0.6),
                      //                 borderRadius:
                      //                     BorderRadius.circular(13.5)),
                      //             child: Column(
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.center,
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 const SizedBox(
                      //                   height: 12,
                      //                 ),
                      //                 Container(
                      //                   height: 41,
                      //                   width: 41,
                      //                   // padding: const EdgeInsets.all(13),
                      //                   alignment: Alignment.center,
                      //                   decoration: const BoxDecoration(
                      //              color: themedata.secondary,
                      //                       shape: BoxShape.circle),
                      //                   child: Transform.translate(
                      //                     offset: const Offset(0, 10),
                      //                     child: Image.asset(
                      //                       "assets/images/dashboard/electric-tower-02.png",
                      //                       height: 24,
                      //                       width: 24,
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 const SizedBox(
                      //                   height: 4,
                      //                 ),
                      //                 const Text(
                      //                   'Electricity',
                      //                   style: MyStyle.tx9Green,
                      //                 ),
                      //                 const SizedBox(
                      //                   height: 4,
                      //                 ),
                      //                 Center(
                      //                   child: Container(
                      //                     width: 52,
                      //                     height: 20,
                      //                     alignment: Alignment.center,
                      //                     decoration: BoxDecoration(
                      //                color: themedata.secondary,
                      //                         borderRadius:
                      //                             BorderRadius.circular(4)),
                      //                     child: const Text(
                      //                       'Buy Now',
                      //                       style: MyStyle.tx9Green,
                      //                     ),
                      //                   ),
                      //                 )
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 24,
                      // ),
                    ],
                  ),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
