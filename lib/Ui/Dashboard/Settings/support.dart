import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Settings/setting_screen.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Settings/faq.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/appbar.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Support'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                color: MyColor.secondaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/whatsapp.png'),
                  const SizedBox(width: 10),
                  Text(
                    'Reach us on WhatsApp',
                    style: MyStyle.tx16Black.copyWith(
                      fontSize: 14,
                      color: MyColor.primaryGreen,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            buildInfoCard(
              image: "assets/images/faq.svg",
              onTap: () => Get.to(() => const FaqScreen()),
              title: "FAQ",
            ),
            const SizedBox(height: 16),
            buildInfoCard(
              image: "assets/images/chat.svg",
              onTap: () {},
              title: "Contact us",
            ),
            const SizedBox(height: 16),
            buildInfoCard(
              image: "assets/images/link.svg",
              onTap: () {},
              title: "Visit our website",
            ),
          ],
        ),
      ),
    );
  }
}
