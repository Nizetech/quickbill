import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/kyc/capture_id_card.dart';
import 'package:jost_pay_wallet/Ui/kyc/widget/info_wrap.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:provider/provider.dart';

class IdVerificationInfo extends StatelessWidget {
  const IdVerificationInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    final account = Provider.of<AccountProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Transform.translate(
                      offset: const Offset(-20, 0), child: BackBtn()),
                  const Spacer(),
                  Transform.translate(
                    offset: const Offset(-20, 0),
                    child: Text(
                      'KYC Verification',
                      style:
                          MyStyle.tx18Black.copyWith(color: themedata.tertiary),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 30),
              Image.asset(
                themeProvider.isDarkMode()
                    ? 'assets/images/id_info_dr.png'
                    : 'assets/images/id_info.png',
              ),
              const SizedBox(height: 30),
              InfoWrap(
                child: Column(
                  children: [
                    Text(
                        'Before taking your passport photo please make sure that',
                        style: MyStyle.tx14Black.copyWith(
                          color: themedata.tertiary,
                          fontWeight: FontWeight.w400,
                        )),
                    const SizedBox(height: 10),
                    _buildInfo('Your ID isn\'t expired', themedata),
                    _buildInfo('Take a clear photo', themedata),
                    _buildInfo('Capture your entire ID', themedata),
                  ],
                ),
              ),
              const Spacer(),
              CustomButton(
                radius: 60,
                text: 'Continue',
                onTap: () {
                  Get.to(() => const CaptureIdCard());
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  _buildInfo(String text, ColorScheme themedata) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Icon(Icons.check_circle, color: themedata.tertiary),
            const SizedBox(width: 10),
            Text(text,
                style: MyStyle.tx14Black.copyWith(
                  color: themedata.tertiary,
                  fontWeight: FontWeight.w400,
                )),
          ],
        ),
      );
}
