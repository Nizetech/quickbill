import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Provider/auth_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final cfmPwd = TextEditingController();
    final newPwd = TextEditingController();
    final currentPwd = TextEditingController();
    void validateForm(AuthProvider model) async {
      if (formKey.currentState?.validate() ?? false) {
        // loginAccount();
        model.changePassword({
          "current_password": currentPwd.text.trim(),
          "new_password": newPwd.text.trim(),
          "confirm_password": cfmPwd.text.trim()
        });
      } else {
        // Form is invalid, no action needed here since warnings are shown automatically
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: BackBtn(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer<AuthProvider>(builder: (context, model, _) {
        return Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  'Change Password',
                  style: NewStyle.tx28White
                      .copyWith(fontSize: 24, color: MyColor.blackColor),
                ),
                const SizedBox(height: 7),
                const Text(
                  'Carefully enter your correct password',
                  style: MyStyle.tx16Gray,
                ),
                const SizedBox(height: 20),
                Text(
                  'Current Password',
                  style: NewStyle.tx14SplashWhite.copyWith(
                      color: MyColor.lightBlackColor,
                      fontWeight: FontWeight.w700,
                      height: 2),
                ),
                TextFormField(
                  style: MyStyle.tx14Black,
                  controller: currentPwd,
                  obscureText: true,
                  decoration: NewStyle.authInputDecoration
                      .copyWith(hintText: 'Enter your current password'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your current password';
                    } else if (value.length < 8) {
                      return 'Please enter at least 8 letters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'New Password',
                  style: NewStyle.tx14SplashWhite.copyWith(
                      color: MyColor.lightBlackColor,
                      fontWeight: FontWeight.w700,
                      height: 2),
                ),
                TextFormField(
                  style: MyStyle.tx14Black,
                  controller: newPwd,
                  obscureText: true,
                  decoration: NewStyle.authInputDecoration
                      .copyWith(hintText: 'Enter your new password'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your new password';
                    } else if (value.length < 8) {
                      return 'Please enter at least 8 letters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Confirm Password',
                  style: NewStyle.tx14SplashWhite.copyWith(
                      color: MyColor.lightBlackColor,
                      fontWeight: FontWeight.w700,
                      height: 2),
                ),
                TextFormField(
                  style: MyStyle.tx14Black,
                  controller: cfmPwd,
                  obscureText: true,
                  decoration: NewStyle.authInputDecoration
                      .copyWith(hintText: 'Enter your confirm password'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please re-enter your password';
                    } else if (value.length < 8) {
                      return 'Please enter at least 8 letters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40),
                CustomButton(
                    text: 'Verify',
                    isLoading: model.isLoading,
                    onTap: () => validateForm(model)),
              ],
            ),
          ),
        );
      }),
    );
  }
}
