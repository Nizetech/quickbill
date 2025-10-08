import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jost_pay_wallet/Provider/DashboardProvider.dart';
import 'package:jost_pay_wallet/Provider/InternetProvider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Services.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Settings/SettingScreen.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/TransactionHistory.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Home/home.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> with WidgetsBindingObserver {
  List body = [
    const HomeScreen(),
    const Services(),
    const SettingScreen(),
    const Transactionhistory(),
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
                padding: const EdgeInsets.only(
                    top: 10.5, bottom: 10.5, left: 24, right: 24),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _navItem(
                            image: "assets/images/home_icon.svg",
                            title: "Home",
                            index: 0,
                            dashProvider: dashProvider,
                            onTap: () {
                              dashProvider.changeBottomIndex(0);
                            }),
                        _navItem(
                            image: "assets/images/service_icon.svg",
                            title: "Services",
                            index: 1,
                            dashProvider: dashProvider,
                            onTap: () {
                              dashProvider.changeBottomIndex(1);
                            }),
                        _navItem(
                            image: "assets/images/deposit_icon.svg",
                            title: "Deposit",
                            index: 2,
                            dashProvider: dashProvider,
                            onTap: () {
                              dashProvider.changeBottomIndex(2);
                            }),
                        _navItem(
                            image: "assets/images/history_icon.svg",
                            title: "History",
                            index: 3,
                            dashProvider: dashProvider,
                            onTap: () {
                              dashProvider.changeBottomIndex(3);
                            }),
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

  Widget _navItem({
    required String image,
    required String title,
    required int index,
    required DashboardProvider dashProvider,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            image,
            height: 24,
            width: 24,
            fit: BoxFit.contain,
            color: dashProvider.currentIndex == index
                ? MyColor.primaryColor
                : MyColor.textGreyColor,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: NewStyle.tx28White.copyWith(
              fontSize: 10,
              color: dashProvider.currentIndex == index
                  ? MyColor.primaryColor
                  : MyColor.textGreyColor,
            ),
          )
        ],
      ),
    );
  }

}
