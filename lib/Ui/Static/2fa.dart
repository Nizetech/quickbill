import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/auth_provider.dart';
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
    final model = context.read<AccountProvider>();
    final auth = context.read<AuthProvider>();
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
            if (model.qrcode != null)
            QrImageView(
                  data: model.qrcode['qrcode_url'],
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
                children: [
                  TextSpan(
                    text: model.qrcode['secret'],
                    style: NewStyle.tx28White.copyWith(
                      fontSize: 16,
                      color: themedata.tertiary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
              
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: model.qrcode['secret']));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Secret key copied!')),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Icon(
                          Icons.copy,
                          size: 16,
                          color: themedata.primary,
                        ),
                      ),
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
              onCodeChanged: (String code) {
                setState(() {});
                if (code.length == 6) {
                  auth.confirmOtp(
                    {'code': code},
                    account: model,
                    isEnable2fa: true,
                  );
                }
              },
              onSubmit: (String verificationCode) {
                code = verificationCode;
                setState(() {});
                if (code.length == 6) {
                  auth.confirmOtp(
                    {'code': code},
                    account: model,
                    isEnable2fa: true,
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              onTap: () {
                auth.confirmOtp(
                  {
                    'code': code
                  },
                  account: model,
                  isEnable2fa: true,
                );
              },
              text: 'Verify',
            ),
          ],
        ),
      ),
    );
  }
}
