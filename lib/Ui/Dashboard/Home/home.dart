import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/dashboard_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/buy_data.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/purchase_airtime.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Home/widget/account_tile.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Home/widget/banner.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Home/widget/history_card.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Home/widget/home_appbar.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Home/widget/service_chip.dart';
import 'package:jost_pay_wallet/Ui/cable/buy_cable_bills.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:provider/provider.dart';
import 'dart:core';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AccountProvider accountProvider;
  @override
  void initState() {
    accountProvider = Provider.of<AccountProvider>(context, listen: false);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
   
      await accountProvider.getUserBalance();
      await accountProvider.getNotification();
      // await accountProvider.getProfileImage(isLoading: false);
      if (accountProvider.transactionModel == null) {
        await accountProvider.getTrasactions();
      } else {
        await accountProvider.getTrasactions(isLoading: false);
      }
      if (accountProvider.userModel == null) {
        await accountProvider.getUserProfile();
      } else {
        await accountProvider.getUserProfile(isLoading: false);
      }
    });
  }

  FutureOr refresh() async {
    await accountProvider.getTrasactions();
  }

  FutureOr refreshAll() async {
    await accountProvider.getTrasactions();
    await accountProvider.getNotification();
    await accountProvider.getUserProfile();
  }

  double showTotalValue = 0.0;
  var trxPrivateKey = "";

  @override
  Widget build(BuildContext context) {
    
    final dashProvider = Provider.of<DashboardProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Consumer<AccountProvider>(builder: (context, model, _) {
       
        return RefreshIndicator(
          onRefresh: () async {
            await refreshAll();
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      HomeAppBar(),
                      const SizedBox(height: 20),
                      DashboardTile(),
                      const SizedBox(height: 10),
                      AddFundsBtn(),
                      const SizedBox(height: 10),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Quick actions',
                                      style: MyStyle.tx16Black.copyWith(
                                        color: MyColor.blackColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "Choose what you would like to do",
                                      style: MyStyle.tx14Black.copyWith(
                                        color: MyColor.grey02Color,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      dashProvider.changeBottomIndex(1),
                                  child: Text(
                                    'See all',
                                    style: MyStyle.tx28Black.copyWith(
                                      color: MyColor.blackColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                ServiceChip(
                                  onTap: () => Get.to(const PurchaseAirtime()),
                                  title: 'Airtime',
                                  icon: 'assets/images/call.svg',
                                ),
                                const SizedBox(width: 10),
                                ServiceChip(
                                  onTap: () => Get.to(const BuyData()),
                                  title: 'Data',
                                  icon: 'assets/images/data.svg',
                                ),
                                const SizedBox(width: 10),
                                ServiceChip(
                                  onTap: () => Get.to(const BuyCableBills()),
                                  title: 'Cable',
                                  icon: 'assets/images/cable.svg',
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Visibility(
                              visible: dashProvider.promotionBanner,
                              child: BannerAds(),
                            ),
                            const SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Recent Transactions',
                                  style: MyStyle.tx14Black,
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      dashProvider.changeBottomIndex(3),
                                  child: Text(
                                    'View all',
                                    style: MyStyle.tx28Black.copyWith(
                                      color: MyColor.blackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            if (accountProvider.dashBoardHistory != null &&
                                accountProvider
                                    .dashBoardHistory!.data!.isNotEmpty)
                              ListView.separated(
                                separatorBuilder: (_, i) => SizedBox(
                                  height: 12,
                                ),
                                padding: EdgeInsets.only(bottom: 50),
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var item = accountProvider
                                      .dashBoardHistory!.data![index];
                                  return HistoryCard(
                                    transaction: item,
                                  );
                                },
                                shrinkWrap: true,
                                itemCount: accountProvider
                                            .dashBoardHistory!.data!.length >
                                        5
                                    ? 5
                                    : accountProvider
                                        .dashBoardHistory!.data!.length,
                              )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
