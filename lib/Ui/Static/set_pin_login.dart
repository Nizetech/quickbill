
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
import '../../Values/MyColor.dart';
import '../../Values/MyStyle.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class SetPinLogin extends StatefulWidget {
  final bool isUpdate;
  const SetPinLogin({
    super.key,
    this.isUpdate = false,
  });

  @override
  State<SetPinLogin> createState() => _SetPinLoginState();
}

class _SetPinLoginState extends State<SetPinLogin> {
  late SharedPreferences sharedPreferences;
  String pin = "";
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
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.isUpdate ? "Update PIN Login" :
                    "Set PIN Login",
                    style: MyStyle.tx28Black,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Set your 4-digit PIN to login to your account',
                  style: MyStyle.tx14Black,
                ),
                const SizedBox(height: 28),
                OtpTextField(
                  numberOfFields: 4,
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
                  onCodeChanged: (String code) {
                    pin = code;
                  },
                  onSubmit: (String code) {
                    pin = code;
                  },
                ),
                SizedBox(height: 40),
                CustomButton(
                    text: 'Confirm',
                    onTap: () {
                      if (pin.isEmpty && pin.length < 4) {
                        return;
                      } else {
                        model.updatePinLogin(
                            pin, context.read<AccountProvider>());
                      }
                    })
              ],
            ),
          ),
        );
      }),
    );
  }
}
