import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TwoFAScreen extends StatefulWidget {
  const TwoFAScreen({super.key});

  @override
  State<TwoFAScreen> createState() => _TwoFAScreenState();
}

class _TwoFAScreenState extends State<TwoFAScreen> {
  String code = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackBtn(),
        backgroundColor: Colors.transparent,
        title: Text(
          "Two-Factor Authentication",
          style: NewStyle.tx28White.copyWith(
            fontSize: 20,
            color: MyColor.dark02Color,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Two-Factor Authentication',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            const Text(
              'Enable Two-Factor Authentication for added security.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            QrImageView(
              data: 'widget.orderID',
              version: QrVersions.auto,
              size: 150,
              gapless: false,
            ),
            const SizedBox(height: 28),
            OtpTextField(
              numberOfFields: 6,
              borderColor: Colors.white,
              fillColor: NewColor.inputFillColor,
              focusedBorderColor: MyColor.greenColor,
              textStyle: const TextStyle(
                  fontSize: 16,
                  height: 1.3,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
              filled: true,
              borderWidth: 0.68,
              borderRadius: const BorderRadius.all(Radius.circular(12.5)),
              showFieldAsBox: true,
              // clearText: clearText,
              autoFocus: true,
              onCodeChanged: (String code) {},
              onSubmit: (String verificationCode) {
                code = verificationCode;
              },
            ),
            const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }
}
