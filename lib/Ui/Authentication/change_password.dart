import 'package:flutter/material.dart';
import 'package:quick_bills/Provider/account_provider.dart';
import 'package:quick_bills/Ui/Dashboard/Settings/edit_profile.dart';
import 'package:provider/provider.dart';

import 'package:quick_bills/Provider/auth_provider.dart';
import 'package:quick_bills/Values/MyStyle.dart';
import 'package:quick_bills/common/appbar.dart';
import 'package:quick_bills/common/button.dart';
import 'package:quick_bills/common/text_field.dart';

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
          "cur_password": currentPwd.text.trim(),
          "new_password": newPwd.text.trim(),
        });
      } 
    }

    return Scaffold(
      appBar: appBar(title: 'Change Password'),
      body: Consumer<AuthProvider>(builder: (context, model, _) {
        return Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                 
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
                      
                        const SizedBox(height: 20),
                        requiredLabel('Current Password'),
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
                        requiredLabel('New Password'),
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
                        requiredLabel('Confirm Password'),
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
                            } else if (value != newPwd.text.trim()) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 40),
                     
                      ],
                    ),
                  ),
                ),
                CustomButton(
                    text: 'Reset',
                    isLoading: model.isLoading,
                    onTap: () => validateForm(model)),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      }),
    );
  }
}
