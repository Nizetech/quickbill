import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Provider/Auth_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final email = TextEditingController();
    void _validateForm(AuthProvider model) async {
      if (_formKey.currentState?.validate() ?? false) {
        // loginAccount();
        model.forgetPassword(email.text.trim());
      } else {
        // Form is invalid, no action needed here since warnings are shown automatically
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 1, 0),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: MyColor.blackColor, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: MyColor.blackColor,
                  size: 20,
                ),
              )),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer<AuthProvider>(builder: (context, model, _) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  width: 160,
                  child: Text(
                    'Forgot Password',
                    style: NewStyle.tx28White
                        .copyWith(fontSize: 24, color: MyColor.blackColor),
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
                TextFormField(
                  controller: email,
                
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  cursorColor: MyColor.greenColor,
                  style: MyStyle.tx16Black.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: NewStyle.authInputDecoration.copyWith(
                    hintText: 'Email address',
                  ),
                ),
                SizedBox(height: 60),
                CustomButton(
                    text: 'Verify',
                    isLoading: model.isLoading,
                    onTap: () => _validateForm(model)),
              ],
            ),
          ),
        );
      }),
    );
  }
}
