
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/BuyAirtime.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/data_history.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Home/widget/service_chip.dart';
import 'package:jost_pay_wallet/Ui/cable/cable_history.dart';
import 'package:jost_pay_wallet/Ui/electricity/electricity_history.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/appbar.dart';

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
                  onTap: () => Get.to(const BuyAirtime()),
                  title: 'Airtime',
                  icon: 'assets/images/call_s.svg',
                  height: 110,
                ),
                SizedBox(width: 10),
                ServiceChip(
                  onTap: () => Get.to(const DataHistory()),
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
                  onTap: () => Get.to(const CableHistory()),
                  title: 'Cable',
                  icon: 'assets/images/cable_s.svg',
                  height: 110,
                ),
                SizedBox(width: 10),
                ServiceChip(
                  onTap: () => Get.to(const ElectricityHistory()),
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
