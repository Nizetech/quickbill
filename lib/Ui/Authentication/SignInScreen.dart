import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jost_pay_wallet/Ui/Authentication/OtpScreen.dart';
import 'package:jost_pay_wallet/Ui/Authentication/SignUpScreen.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/DashboardScreen.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  late String deviceId;
  bool fingerOn = false;
  String isLogin = "";

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final String _response = "";

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _validateForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });

      final Map<String, dynamic> body = {
        "email": _emailController.text,
        "password": _passwordController.text,
      };

      loginAccount();
    } else {
      // Form is invalid, no action needed here since warnings are shown automatically
    }
  }

  loginAccount() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const OtpScreen()));
    // Navigator.pushReplacement(context,
    //     MaterialPageRoute(builder: (context) => const DashboardScreen()));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 81, left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    const Row(
                      children: [
                        Text(
                          'Hi There! 👋',
                          style: MyStyle.tx30Black,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Row(
                      children: [
                        Text(
                          'Welcome back, Sign in to your account',
                          style: MyStyle.tx16Gray,
                        )
                      ],
                    ),
                    const SizedBox(height: 28),
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
                      decoration: NewStyle.authInputDecoration
                          .copyWith(hintText: 'Email address'),
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
                      'Password',
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
                      decoration: NewStyle.authInputDecoration
                          .copyWith(hintText: 'Enter your password'),
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
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Column(children: [
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: MyColor.greenColor,
                      ))
                    : SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: _validateForm,
                          style: TextButton.styleFrom(
                            backgroundColor: MyColor.greenColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Login",
                            style: NewStyle.btnTx16SplashBlue
                                .copyWith(color: NewColor.mainWhiteColor),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 410,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Don’t have an account? ',
                      style: NewStyle.btnTx16SplashBlue.copyWith(
                          color: MyColor.signGray, fontWeight: FontWeight.w400),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      ),
                      child: Text(
                        'Sign Up',
                        style: NewStyle.btnTx16SplashBlue
                            .copyWith(color: MyColor.greenColor),
                      ),
                    ),
                  ],
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
