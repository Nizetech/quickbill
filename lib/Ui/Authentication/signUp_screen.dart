import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quick_bills/Provider/auth_provider.dart';
import 'package:quick_bills/Ui/Authentication/complete_info.dart';
import 'package:quick_bills/Ui/Authentication/signIn_screen.dart';
import 'package:quick_bills/Ui/Dashboard/Settings/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:quick_bills/Values/MyStyle.dart';
import 'package:quick_bills/common/button.dart';
import 'package:quick_bills/common/text_field.dart';
import 'package:quick_bills/common/upgrader.dart';
import 'package:quick_bills/constants/constants.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  final bool isOnboarding;
  const SignUpScreen({super.key, this.isOnboarding = false});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController passwordController = TextEditingController();

  String countryValue = "";

  // final LocalAuthentication auth = LocalAuthentication();
  late String deviceId;
  bool fingerOn = false;
  String isLogin = "";
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _lastName = TextEditingController();
  final _firstName = TextEditingController();

  // static Future<void> saveToken(String token) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString("token", token);
  // }
  final box = Hive.box(kAppName);

  void _validateForm(AuthProvider model) async {
    if (_formKey.currentState?.validate() ?? false) {
      print(
          "${_emailController.text.trim()}, ${_firstName.text.trim()}, ${_lastName.text.trim()}");
      // return;
      model.updateUserData({
        "email": _emailController.text.trim(),
        "first_name": _firstName.text.trim(),
        "last_name": _lastName.text.trim(),
      });
      Get.to(() => const CompleteInfoScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AuthProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: widget.isOnboarding
            ? null
            : BackBtn(
                onTap: () => Get.back(),
              ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer<AuthProvider>(builder: (context, ctr, _) {
        return AppUpgrader(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Form(
                    key: _formKey,
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
                          'Create an account',
                          style: MyStyle.tx16Black.copyWith(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Enter your personal data to create your account.',
                          style: MyStyle.tx16Gray.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 28),
                        requiredLabel('First Name'),
                        CustomTextField(
                          text: 'Enter your first name',
                          isAuth: true,
                          controller: _firstName,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the valid name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        requiredLabel('Last Name'),
                        CustomTextField(
                          text: 'Enter your last name',
                          isAuth: true,
                          controller: _lastName,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the valid name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        requiredLabel('Email'),
                        CustomTextField(
                          text: 'Enter your email address',
                          isAuth: true,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                      text: 'Continue',
                      isLoading: model.isLoading,
                      onTap: () {
                        _validateForm(model);
                      }),
                  const SizedBox(height: 20),
                  Center(
                    child: Text.rich(TextSpan(
                      text: 'Already have an account? ',
                      style: MyStyle.tx14Black.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: MyStyle.tx14Black.copyWith(
                            fontSize: 13,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print("Login");
                              Get.offAll(() => const SignInScreen());
                            },
                        ),
                      ],
                    )),
                  ),
                  const SizedBox(height: 34)
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
