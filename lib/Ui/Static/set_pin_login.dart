
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
import '../../Values/MyColor.dart';
import '../../Values/MyStyle.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class SetPinLogin extends StatefulWidget {
  final bool isUpdate;
  final bool isFromAuth;
  const SetPinLogin({
    super.key,
    this.isUpdate = false,
    this.isFromAuth = false,
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
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final isDark = themeProvider.isDarkMode();
    return Scaffold(
      backgroundColor:
          isDark && !widget.isFromAuth ? MyColor.dark02Color : Colors.white,
      body: Consumer<AuthProvider>(builder: (context, model, _) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 70, right: 16.w, left: 16.w),
            child: Column(
              children: <Widget>[
              
                Align(
                  alignment: Alignment.centerLeft,
                  child: Transform.translate(
                    offset: Offset(-20, 0),
                    child: BackBtn(
                      isFromAuth: widget.isFromAuth,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.isUpdate ? "Update Access PIN" : "Access PIN Setup",
                    style: MyStyle.tx28Black.copyWith(
                        color: isDark && !widget.isFromAuth
                            ? MyColor.whiteColor
                            : MyColor.lightBlackColor),
                  ),  
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Set your 4-digit PIN for instant, secure account access.',
                  style: MyStyle.tx14Black.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: !widget.isFromAuth && isDark
                        ? MyColor.whiteColor
                        : MyColor.lightBlackColor,
                  ),
                ),
                const SizedBox(height: 28),
                OtpTextField(
                  numberOfFields: 4,
                  borderColor: Colors.white,
                  fillColor: NewColor.inputFillColor,
                  focusedBorderColor: MyColor.greenColor,
                  textStyle: TextStyle(
                      fontSize: 16,
                      height: 1.3,
                      fontWeight: FontWeight.w700,
                    color: MyColor.lightBlackColor,
                  ),
                  filled: true,
                  borderWidth: 0.68,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.5),
                  ),
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
                        if (widget.isFromAuth) {
                          model.updatePinLogin(
                              pin, context.read<AccountProvider>(),
                              isFromAuth: widget.isFromAuth);
                        } else {
                          model.updatePinLogin(
                              pin, context.read<AccountProvider>());
                        }
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
