import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_bills/Provider/auth_provider.dart';
import 'package:quick_bills/Ui/Settings/edit_profile.dart';
import 'package:quick_bills/Values/MyStyle.dart';
import 'package:quick_bills/common/button.dart';
import 'package:quick_bills/common/text_field.dart';

class ForgotPassword extends StatelessWidget {
  final bool isPin;
  const ForgotPassword({super.key, required this.isPin});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final email = TextEditingController();
    void validateForm(AuthProvider model) async {
      if (formKey.currentState?.validate() ?? false) {
        // loginAccount();
        model.forgetPassword(email.text.trim());
      } else {
        // Form is invalid, no action needed here since warnings are shown automatically
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
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
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/logo.png',
                  width: 170,
                  height: 46,
                ),
                const SizedBox(height: 30),
                Text(
                  isPin ? 'Forgot Pin' : 'Forgot Password',
                  style: MyStyle.tx16Black.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'Enter your email address and we will send you a link to reset your password',
                  style: MyStyle.tx16Gray.copyWith(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                requiredLabel('Email address'),
                CustomTextField(
                  text: 'Email address',
                  controller: email,
                  isAuth: !isPin,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
               
                SizedBox(height: 60),
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
