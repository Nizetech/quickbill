import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jost_pay_wallet/Provider/auth_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/appbar.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:jost_pay_wallet/common/text_field.dart';

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
      appBar: appBar(title: 'Change Password'),
      body: Consumer<AuthProvider>(builder: (context, model, _) {
        return Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Change Password',
                  style: MyStyle.tx16Black,
                ),
                const SizedBox(height: 7),
                Text(
                  'Update your password below',
                  style: MyStyle.tx14Black.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'Carefully enter your correct password',
                  style: MyStyle.tx16Gray.copyWith(
                    color:
                        MyColor.blackColor,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Current Password',
                  style: MyStyle.tx16Black
                      .copyWith(
                 
                      fontWeight: FontWeight.w700,
                      height: 2),
                ),
                CustomTextField(
                  text: 'Enter your current password',
                  controller: currentPwd,
                  keyboardType: TextInputType.emailAddress,
                  isPassword: true,
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
                  style: MyStyle.tx16Black
                      .copyWith(
                    
                      fontWeight: FontWeight.w700,
                      height: 2),
                ),
                CustomTextField(
                  text: 'Enter your new password',
                  controller: newPwd,
                  keyboardType: TextInputType.emailAddress,
                  isPassword: true,
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
                  style: MyStyle.tx16Black.copyWith(
                      color:
                      MyColor.blackColor,
                      fontWeight: FontWeight.w700,
                      height: 2),
                ),
                CustomTextField(
                  text: 'Enter your confirm password',
                  controller: cfmPwd,
                  keyboardType: TextInputType.emailAddress,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your confirm password';
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
