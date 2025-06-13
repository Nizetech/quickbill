import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Provider/DashboardProvider.dart';
import 'package:jost_pay_wallet/Provider/InternetProvider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Services.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Settings/SettingScreen.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/TransactionHistory.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/WalletScreen.dart';
import 'package:jost_pay_wallet/Ui/Support/SupportScreen.dart';
import 'package:jost_pay_wallet/Ui/Support/about_scren.dart';
import 'package:jost_pay_wallet/Ui/Support/faq_screen.dart';
import 'package:jost_pay_wallet/Ui/Support/privacy_screen.dart';
import 'package:jost_pay_wallet/Ui/Support/terms_screen.dart';
import 'package:jost_pay_wallet/Ui/promotions/promo_screen.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:wallet_connect_dart_v2/sign/sign-client/client/sign_client.dart';


// SignClient? signClient;

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> with WidgetsBindingObserver {
  List body = [
    const WalletScreen(),
    const Services(),
    const Transactionhistory(),
    const PromoScreen(),
    const SettingScreen(),
    const TermsScreen(),
    const PrivacyScreen(),
    const AboutUsScreen(),
    const FaqScreen(),
    const SupportScreen(),
  ];

  _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        actionsPadding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
        backgroundColor: MyColor.darkGrey01Color,
        content: Text(
          'Do you want to exit an App ?',
          style: MyStyle.tx18RWhite.copyWith(fontSize: 14),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'No',
              style: MyStyle.tx18RWhite.copyWith(fontSize: 14),
            ),
          ),
          TextButton(
            onPressed: () {
              exit(0);
            },
            child: Text(
              'Yes',
              style: MyStyle.tx18RWhite.copyWith(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  late InternetProvider _internetProvider;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late SharedPreferences sharedPreferences;


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _internetProvider = Provider.of<InternetProvider>(context, listen: true);
    final dashProvider = Provider.of<DashboardProvider>(context, listen: true);

    return Scaffold(
        key: _scaffoldKey,
        extendBody: true,
        bottomNavigationBar: IntrinsicHeight(
          child: Column(
            children: [
              // no internet error message
              Visibility(
                visible: !_internetProvider.isOnline,
                child: Container(
                  height: 38,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: const BoxDecoration(color: MyColor.redColor),
                  child: Center(
                    child: Text(
                      'No connection',
                      style: MyStyle.tx18RWhite.copyWith(fontSize: 16),
                    ),
                  ),
                ),
              ),

              // bottom navigation
              Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(top: 10.5, bottom: 10.5),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              dashProvider.changeBottomIndex(0);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // SvgPicture.asset(
                                //   'assets/images/dashboard/home/filled.svg',
                                //   height: 24,
                                //   width: 24,
                                //   colorFilter: ColorFilter.mode(
                                //       dashProvider.currentIndex == 0
                                //           ? MyColor.greenColor
                                //           : MyColor.signGray,
                                //       BlendMode.srcIn),
                                // ),
                                Image.asset(
                                  "assets/images/dashboard/home.png",
                                  height: 24,
                                  width: 24,
                                  fit: BoxFit.contain,
                                  color: dashProvider.currentIndex == 0
                                      ? MyColor.greenColor
                                      : MyColor.signGray,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Home",
                                  style: NewStyle.tx28White.copyWith(
                                    fontSize: 10,
                                    color: dashProvider.currentIndex == 0
                                        ? MyColor.greenColor
                                        : MyColor.signGray,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              dashProvider.changeBottomIndex(1);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  "assets/images/dashboard/shop.png",
                                  height: 24,
                                  width: 24,
                                  fit: BoxFit.contain,
                                  color: dashProvider.currentIndex == 1
                                      ? MyColor.greenColor
                                      : MyColor.signGray,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Services",
                                  style: NewStyle.tx28White.copyWith(
                                    fontSize: 10,
                                    color: dashProvider.currentIndex == 1
                                        ? MyColor.greenColor
                                        : MyColor.signGray,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              dashProvider.changeBottomIndex(2);
                              dashProvider.changeDefaultCoin("");
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  "assets/images/dashboard/cards.png",
                                  height: 24,
                                  width: 24,
                                  fit: BoxFit.contain,
                                  color: dashProvider.currentIndex == 2
                                      ? MyColor.greenColor
                                      : MyColor.signGray,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "History",
                                  style: NewStyle.tx28White.copyWith(
                                    fontSize: 10,
                                    color: dashProvider.currentIndex == 2
                                        ? MyColor.greenColor
                                        : MyColor.signGray,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              dashProvider.changeBottomIndex(3);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  "assets/images/dashboard/promo.png",
                                  height: 24,
                                  width: 24,
                                  fit: BoxFit.contain,
                                  color: dashProvider.currentIndex == 3
                                      ? MyColor.greenColor
                                      : MyColor.signGray,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Promotion",
                                  style: NewStyle.tx28White.copyWith(
                                    fontSize: 10,
                                    color: dashProvider.currentIndex == 3
                                        ? MyColor.greenColor
                                        : MyColor.signGray,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              dashProvider.changeBottomIndex(4);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  "assets/images/dashboard/profile.png",
                                  height: 24,
                                  width: 24,
                                  fit: BoxFit.contain,
                                  color: dashProvider.currentIndex == 4
                                      ? MyColor.greenColor
                                      : MyColor.signGray,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Profile",
                                  style: NewStyle.tx28White.copyWith(
                                    fontSize: 10,
                                    color: dashProvider.currentIndex == 4
                                        ? MyColor.greenColor
                                        : MyColor.signGray,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Platform.isIOS ? 20 : 5),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: WillPopScope(
          onWillPop: () {
            return _onWillPop();
          },
          child: body[dashProvider.currentIndex],
        ));
  }
}
