import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jost_pay_wallet/Ui/Authentication/OtpScreen.dart';
import 'package:jost_pay_wallet/Ui/Authentication/SignInScreen.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:csc_picker/csc_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController passwordController = TextEditingController();

  String countryValue = "";

  final LocalAuthentication auth = LocalAuthentication();
  late String deviceId;
  bool fingerOn = false;
  String isLogin = "";

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final String _response = '';

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  }

  void _validateForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      // userRegister();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const OtpScreen()));
    } else {}
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 60, left: 24, right: 24),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignInScreen()));
                        },
                        child: Image.asset(
                          "assets/images/arrow_left.png",
                          fit: BoxFit.cover,
                        )),
                    const SizedBox(height: 28),
                    const SizedBox(
                        width: 250,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Create a ',
                                  style: MyStyle.tx28Black,
                                ),
                                Text(
                                  'Jostpay',
                                  style: MyStyle.tx28Green,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'account',
                                  style: MyStyle.tx28Black,
                                )
                              ],
                            )
                          ],
                        )),
                    const SizedBox(height: 20),
                    Text(
                      'First Name',
                      style: NewStyle.tx14SplashWhite.copyWith(
                          color: MyColor.lightBlackColor,
                          fontWeight: FontWeight.w700,
                          height: 2),
                    ),
                    TextFormField(
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: themedata.tertiary,
                        fontFamily: 'SF Pro Rounded',
                      ),
                      // controller: _fullNameController,
                      decoration: NewStyle.authInputDecoration,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the valid name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Last Name',
                      style: NewStyle.tx14SplashWhite.copyWith(
                          color: MyColor.lightBlackColor,
                          fontWeight: FontWeight.w700,
                          height: 2),
                    ),
                    TextFormField(
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: themedata.tertiary,
                        fontFamily: 'SF Pro Rounded',
                      ),
                      controller: _fullNameController,
                      decoration: NewStyle.authInputDecoration,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the valid name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Email',
                      style: NewStyle.tx14SplashWhite.copyWith(
                          color: MyColor.lightBlackColor,
                          fontWeight: FontWeight.w700,
                          height: 2),
                    ),
                    TextFormField(
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: themedata.tertiary,
                        fontFamily: 'SF Pro Rounded',
                      ),
                      controller: _emailController,
                      decoration: NewStyle.authInputDecoration,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Phone Number',
                      style: NewStyle.tx14SplashWhite.copyWith(
                          color: MyColor.lightBlackColor,
                          fontWeight: FontWeight.w700,
                          height: 2),
                    ),
                    TextFormField(
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: themedata.tertiary,
                        fontFamily: 'SF Pro Rounded',
                      ),
                      controller: _phoneNumberController,
                      decoration: NewStyle.authInputDecoration
                          .copyWith(hintText: "+234"),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        // else if (!RegExp(r'^\+(?:[0-9] ?){6,14}[0-9]$')
                        //     .hasMatch(value)) {
                        //   return 'Please enter a valid phone number';
                        // }
                        return null;
                      },
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Refer ID',
                      style: NewStyle.tx14SplashWhite.copyWith(
                          color: MyColor.lightBlackColor,
                          fontWeight: FontWeight.w700,
                          height: 2),
                    ),
                    TextFormField(
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: themedata.tertiary,
                        fontFamily: 'SF Pro Rounded',
                      ),
                      // controller: _phoneNumberController,
                      decoration: NewStyle.authInputDecoration,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Create Password',
                      style: NewStyle.tx14SplashWhite.copyWith(
                          color: MyColor.lightBlackColor,
                          fontWeight: FontWeight.w700,
                          height: 2),
                    ),
                    TextFormField(
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: themedata.tertiary,
                        fontFamily: 'SF Pro Rounded',
                      ),
                      controller: _passwordController,
                      obscureText: true,
                      decoration: NewStyle.authInputDecoration,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else if (value.length < 8) {
                          return 'Please enter at least 8 letters';
                        }
                        return null;
                      },
                    ),
                    const Text(
                      'Only letters, numbers and characters are allowed',
                      style: MyStyle.tx11Grey,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Confirm Password',
                      style: NewStyle.tx14SplashWhite.copyWith(
                          color: MyColor.lightBlackColor,
                          fontWeight: FontWeight.w700,
                          height: 2),
                    ),
                    TextFormField(
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: themedata.tertiary,
                        fontFamily: 'SF Pro Rounded',
                      ),
                      // controller: _passwordController,
                      obscureText: true,
                      decoration: NewStyle.authInputDecoration,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else if (value.length < 8) {
                          return 'Please enter at least 8 letters';
                        }
                        return null;
                      },
                    ),
                    const Text(
                      'Only letters, numbers and characters are allowed',
                      style: MyStyle.tx11Grey,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Column(children: [
                isLoading == true
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: MyColor.greenColor,
                      ))
                    : SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () => {_validateForm()},
                          style: TextButton.styleFrom(
                            backgroundColor: MyColor.greenColor,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Sign Up",
                            style: NewStyle.btnTx16SplashBlue
                                .copyWith(color: NewColor.mainWhiteColor),
                          ),
                        ),
                      ),
                const SizedBox(height: 117),
                Container(
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Text(
                      'Already have an account? ',
                      style: NewStyle.btnTx16SplashBlue.copyWith(
                          color: MyColor.signGray, fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInScreen())),
                      child: Row(
                        children: [
                          Image.asset('assets/images/signin-icon.png'),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Login',
                            style: NewStyle.btnTx16SplashBlue.copyWith(
                                color: MyColor.greenColor,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: 34),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
