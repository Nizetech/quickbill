import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_bills/Ui/Dashboard/Home/widget/service_chip.dart';
import 'package:quick_bills/Ui/airtime/purchase_airtime.dart';
import 'package:quick_bills/Ui/data/buy_data.dart';
import 'package:quick_bills/Ui/cable/buy_cable_bills.dart';
import 'package:quick_bills/Ui/electricity/buy_electricity.dart';
import 'package:quick_bills/Values/MyColor.dart';
import 'package:quick_bills/Values/MyStyle.dart';
import 'package:quick_bills/common/appbar.dart';

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
    return Scaffold(
      appBar: appBar(title: 'Services', isBack: false),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Services',
              style: MyStyle.tx16Black.copyWith(
                color: MyColor.blackColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Choose what you'd like to do",
              style: MyStyle.tx14Black.copyWith(
                color: MyColor.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ServiceChip(
                  onTap: () => Get.to(const PurchaseAirtime()),
                  title: 'Airtime',
                  icon: 'assets/images/call_s.svg',
                  height: 110,
                ),
                SizedBox(width: 10),
                ServiceChip(
                  onTap: () => Get.to(const BuyData()),
                  title: 'Data',
                  icon: 'assets/images/data_s.svg',
                  height: 110,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ServiceChip(
                  onTap: () => Get.to(const BuyCableBills()),
                  title: 'Cable',
                  icon: 'assets/images/cable_s.svg',
                  height: 110,
                ),
                SizedBox(width: 10),
                ServiceChip(
                  onTap: () => Get.to(const BuyElectricity()),
                  title: 'Electricity',
                  icon: 'assets/images/elect_s.svg',
                  height: 110,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
