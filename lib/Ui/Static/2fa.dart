import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:provider/provider.dart';
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
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackBtn(),
        backgroundColor: Colors.transparent,
        title: Text(
          "Two-Factor Authentication",
          style: MyStyle.tx20Grey.copyWith(
            color: themedata.tertiary,
          ),
        ),
       
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
           
            Text(
              'Scan the QR Code with Google Authenticator.',
              style: NewStyle.tx28White.copyWith(
                fontSize: 16,
                color: themedata.tertiary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            QrImageView(
              data: 'FEQDSMIP7PH65YCB',
              version: QrVersions.auto,
              size: 150,
                gapless: true,
                dataModuleStyle: QrDataModuleStyle(
                  color: themedata.tertiary,
                  dataModuleShape: QrDataModuleShape.square,
                ),
                eyeStyle: QrEyeStyle(
                  eyeShape: QrEyeShape.square,
                  color: themedata.tertiary,
                )
            ),
            const SizedBox(height: 10),
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text: 'Alternatively, you can manually enter this secret key: ',
                style: NewStyle.tx28White.copyWith(
                  fontSize: 16,
                  color: themedata.tertiary,
                  fontWeight: FontWeight.w500,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'FEQDSMIP7PH65YCB',
                    style: NewStyle.tx28White.copyWith(
                      fontSize: 16,
                      color: themedata.tertiary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
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
            const SizedBox(height: 20),
            CustomButton(
              onTap: () {},
              text: 'Verify',
            ),
          ],
        ),
      ),
    );
  }
}
