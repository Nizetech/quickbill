import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quick_bills/Provider/account_provider.dart';
import 'package:quick_bills/Provider/auth_provider.dart';
import 'package:quick_bills/Ui/authentication/signUp_screen.dart';
import 'package:quick_bills/Ui/authentication/forget_password.dart';
import 'package:quick_bills/Ui/Settings/edit_profile.dart';
import 'package:quick_bills/Values/NewStyle.dart';
import 'package:flutter/material.dart';
import 'package:quick_bills/Values/MyColor.dart';
import 'package:quick_bills/Values/MyStyle.dart';
import 'package:quick_bills/bottom_nav.dart';
import 'package:quick_bills/common/button.dart';
import 'package:quick_bills/common/text_field.dart';
import 'package:quick_bills/common/upgrader.dart';
import 'package:quick_bills/constants/constants.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // final LocalAuthentication auth = LocalAuthentication();
  late String deviceId;
  bool fingerOn = false;
  String isLogin = "";

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _validateForm(AuthProvider model) async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });

      final Map<String, dynamic> body = {
        "email": _emailController.text.trim(),
        "password": _passwordController.text.trim(),
      };
      model.login(body);
    } else {
      // Form is invalid, no action needed here since warnings are shown automatically
    }
  }

  final box = Hive.box(kAppName);
  String pin = '';
  String token = '';
  bool useEmailLogin = false;
  @override
  void initState() {
    super.initState();
    box.put(kExistingUser, true);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      token = await box.get(kAccessToken, defaultValue: "");
      if (token.isNotEmpty) {
        Get.offAll(BottomNav());
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    log("isEmailLogin: $useEmailLogin");
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer2<AuthProvider, AccountProvider>(
          builder: (context, model, account, _) {
        return SafeArea(
          child: AppUpgrader(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40),
                          Image.asset(
                            'assets/images/logo.png',
                            width: 170,
                            height: 46,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            'Welcome Back!',
                            style: MyStyle.tx16Black.copyWith(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Enter your login details below',
                            style: MyStyle.tx16Gray.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 28),
                          requiredLabel('Email address'),
                          CustomTextField(
                            text: 'Email address',
                            // isAuth: true,
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid email address';
                              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),
                          requiredLabel('Password'),
                          CustomTextField(
                            text: 'Enter your password',
                            isPassword: true,
                            controller: _passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              } else if (value.length < 8) {
                                return 'Please enter at least 8 letters';
                              }
                              return null;
                            },
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () {
                                Get.to(ForgotPassword(
                                  isPin: false,
                                  // pinEnabled == '1',
                                ));
                              },
                              child: Text(
                                'Forgot Password?',
                                style: NewStyle.tx14SplashWhite.copyWith(
                                  color: MyColor.blueColor,
                                  decoration: TextDecoration.underline,
                                  decorationColor: MyColor.blueColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                        text: 'Login',
                        isLoading: model.isLoading,
                        onTap: () {
                          _validateForm(model);
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text.rich(TextSpan(
                        text: 'Don’t have an account? ',
                        style: MyStyle.tx14Black.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign up',
                            style: MyStyle.tx14Black.copyWith(
                              fontSize: 13,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.to(const SignUpScreen()),
                          ),
                        ],
                      )),
                    ),
                    const SizedBox(height: 34)
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
