
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Provider/DashboardProvider.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
import '../../Values/MyColor.dart';
import '../../Values/MyStyle.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  final bool isForgetPass;
  final bool is2Fa;
  const OtpScreen(
      {super.key,
      required this.email,
      this.isForgetPass = false,
      this.is2Fa = false});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late SharedPreferences sharedPreferences;
  late String emailCode;

  bool isLoading = false;
  bool clearText = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<AuthProvider>(builder: (context, model, _) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 70, right: 16.w, left: 16.w),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        "assets/images/arrow_left.png",
                        fit: BoxFit.cover,
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Verify it's you",
                    style: MyStyle.tx28Black,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                widget.is2Fa
                    ? const Text(
                        'Enter your Google Authenticator code to verify your identity',
                        style: MyStyle.tx14Black,
                      )
                    :
                Row(
                  children: [
                    Text('We send a code to ', style: MyStyle.tx16Gray),
                    Text(
                      truncateEmail(widget.email),
                      style: MyStyle.tx16Green,
                    )
                  ],
                ),
                if (!widget.is2Fa)
                const Row(
                  children: [
                    Text(
                      'Enter it here to verify your identity',
                      style: MyStyle.tx16Gray,
                    )
                  ],
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
                  clearText: clearText,
                  autoFocus: true,
                  onCodeChanged: (String code) {},
                  onSubmit: (String verificationCode) {
                    emailCode = verificationCode;
                  },
                ),
                const SizedBox(height: 14),
                if (!widget.is2Fa)
                TextButton(
                  onPressed: () {
                    model.resendOtp(widget.email);
                    setState(() {
                      clearText = true;
                    });
                  },
                  child: Text("Resend Code",
                      style: MyStyle.tx16Green
                          .copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
                ),
                const SizedBox(height: 28),
                isLoading == true
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: MyColor.greenColor,
                      ))
                    : SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            if (emailCode.isEmpty) {
                              ErrorToast("Please enter OTP");
                            } else {
                              model.confirmOtp(
                                  account: context.read<AccountProvider>(),
                                  dashProvider:
                                      context.read<DashboardProvider>(),
                                  is2fa: widget.is2Fa,
                                  isForgetPass: widget.isForgetPass,
                                  {
                                    "email": widget.email,
                                    "code": emailCode,
                                  });
                            }
                          },
                          
                          style: TextButton.styleFrom(
                            backgroundColor: MyColor.greenColor,
                            padding: const EdgeInsets.symmetric(
                                vertical: 16), // Padding
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                            ),
                          ),
                          child: Text(
                            "Confirm",
                            style: NewStyle.btnTx16SplashBlue
                                .copyWith(color: NewColor.mainWhiteColor),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      }
      ),
    );
  }
}
