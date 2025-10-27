import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quick_bills/Provider/auth_provider.dart';
import 'package:quick_bills/Ui/Dashboard/Settings/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:quick_bills/Values/MyColor.dart';
import 'package:quick_bills/Values/MyStyle.dart';
import 'package:quick_bills/common/button.dart';
import 'package:quick_bills/common/text_field.dart';
import 'package:quick_bills/common/upgrader.dart';
import 'package:quick_bills/constants/constants.dart';
import 'package:quick_bills/utils/toast.dart';
import 'package:provider/provider.dart';

class CompleteInfoScreen extends StatefulWidget {
  const CompleteInfoScreen({super.key});

  @override
  State<CompleteInfoScreen> createState() => _CompleteInfoScreenState();
}

class _CompleteInfoScreenState extends State<CompleteInfoScreen> {
  TextEditingController passwordController = TextEditingController();

  String countryValue = "";

  // final LocalAuthentication auth = LocalAuthentication();
  late String deviceId;
  bool fingerOn = false;
  String isLogin = "";
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String selectedCountryCode = '234';
  String selectedCountry = 'NG';

  final box = Hive.box(kAppName);

  void _validateForm(AuthProvider model) async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_confirmPasswordController.text != _passwordController.text) {
        ErrorToast("Password does not match");
        return;
      } else {
        if (!isChecked) {
          ErrorToast("Please agree to the terms and privacy policy");
          return;
        } else {
          model.updateUserData({
            "password": _passwordController.text.trim(),
            "phone": _phoneNumberController.text.trim(),
            "country": "Nigeria",
            // "confirm_password": _confirmPasswordController.text.trim(),
          });

          model.createAccount();
        }
      }
    }
  }

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AuthProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackBtn(
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
                          'Complete your info.',
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
                        const SizedBox(height: 40),
                        requiredLabel('Phone Number'),
                        CustomTextField(
                          isAuth: true,
                          controller: _phoneNumberController,
                          text: 'Enter your phone number',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a phone number';
                            } else if (value.length < 10) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        requiredLabel('Password'),
                        CustomTextField(
                          isAuth: true,
                          text: 'Enter your password',
                          keyboardType: TextInputType.visiblePassword,
                          isPassword: true,
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            } else if (value.length < 8) {
                              return 'Please enter at least 8 letters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        requiredLabel('Confirm Password'),
                        CustomTextField(
                          isAuth: true,
                          text: 'Re-enter your password',
                          controller: _confirmPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter confirm password';
                            } else if (value.length < 8) {
                              return 'Please enter at least 8 letters';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                      text: 'Register',
                      isLoading: model.isLoading,
                      onTap: () {
                        _validateForm(model);
                      }),
                  const SizedBox(height: 20),
                  Row(children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        },
                        activeColor: MyColor.primaryColor,
                        checkColor: MyColor.mainWhiteColor,
                        side: BorderSide(color: MyColor.primaryColor),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text.rich(TextSpan(
                      text: 'I agree to the ',
                      style: MyStyle.tx14Black.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: 'Terms',
                          style: MyStyle.tx14Black.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationColor: MyColor.primaryColor,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(
                          text: ' and ',
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: MyStyle.tx14Black.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationColor: MyColor.primaryColor,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    )),
                  ]),
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
