import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Provider/DashboardProvider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/BuyAirtime.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/data_history.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/widget/service_tile.dart';
import 'package:jost_pay_wallet/Ui/Domain/domain_screen.dart';
import 'package:jost_pay_wallet/Ui/Paint/paint_history.dart';
import 'package:jost_pay_wallet/Ui/Scripts/script_history.dart';
import 'package:jost_pay_wallet/Ui/cable/cable_history.dart';
import 'package:jost_pay_wallet/Ui/electricity/electricity_history.dart';
import 'package:jost_pay_wallet/Ui/repair/repairdetail_screen.dart';
import 'package:jost_pay_wallet/Ui/giftCard/gift_card_history.dart';
import 'package:jost_pay_wallet/Ui/promotions/social_boost_history.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

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
                          ServiceTile(
                            icon: 'assets/images/svg/airtime.svg',
                            title: 'Buy Airtime',
                            isTransform: true,
                            page: const BuyAirtime(),
                          ),
                          const Spacer(),
                          ServiceTile(
                            icon: 'assets/images/data.svg',
                            title: 'Buy Data',
                            isTransform: true,
                            page: const DataHistory(),
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
                        'Utilities & Digital',
                        style: MyStyle.tx18Black.copyWith(
                            fontWeight: FontWeight.w400,
                            color: themedata.tertiary),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          ServiceTile(
                            icon: 'assets/images/electricity.svg',
                            title: 'Electricity Token',
                            page: const ElectricityHistory(),
                          ),
                     
                          
                          const Spacer(),
                          if (Platform.isAndroid)
                          ServiceTile(
                            icon: 'assets/images/giftcard.svg',
                            title: 'Buy Gift Card',
                            page: const GiftCardHistory(),
                            )
                          else
                            ServiceTile(
                              icon: 'assets/images/cable.svg',
                              title: 'Buy Cable Tv',
                              page: const CableHistory(),
                            )
                        ],
                      ),
                      if (Platform.isAndroid) ...[
                        const SizedBox(
                          height: 10,
                        ),
                        ServiceTile(
                          icon: 'assets/images/cable.svg',
                          title: 'Buy Cable Tv',
                          page: const CableHistory(),
                        ),
                      ],
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
                          ServiceTile(
                            icon: 'assets/images/domain.svg',
                            title: 'Web Hosting',
                            page: const DomainScreen(),
                          ),
                          // todo uncomment this
                          const Spacer(),
                          if (Platform.isAndroid)
                            ServiceTile(
                            icon: 'assets/images/boost.svg',
                            title: 'Try Social Boost',
                            page: const SocialBoostHistory(),
                            )
                       
                        ],
                      ),
                  
                      if (Platform.isAndroid)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ServiceTile(
                            icon: 'assets/images/script.svg',
                            title: 'Buy Scripts',
                            page: ScriptHistory(),
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
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          ServiceTile(
                            icon: 'assets/images/svg/repair.svg',
                            title: 'Vehicle Repairs',
                            page: const RepairdetailScreen(),
                          ),
                          const Spacer(),
                          ServiceTile(
                            icon: 'assets/images/svg/spray.svg',
                            title: 'Paint & Spray',
                            page: const PaintHistory(),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 10),
                      // ServiceTile(
                      //   icon: 'assets/images/car.svg',
                      //   title: 'Buy Cars',
                      //   page: CarHistory(),
                      //   // const CarsellScreen(),
                      // ),
                 
                      const SizedBox(
                        height: 27,
                      ),
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
