import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jost_pay_wallet/Provider/auth_provider.dart';
import 'package:jost_pay_wallet/Ui/Authentication/OtpScreen.dart';
import 'package:jost_pay_wallet/Ui/Authentication/SignUpScreen.dart';
import 'package:jost_pay_wallet/Ui/Authentication/forget_password.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:jost_pay_wallet/constants/constants.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
// import 'package:local_auth/local_auth.dart';
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
  // final String _response = "";

  // static Future<void> saveToken(String token) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString("token", token);
  // }

  // Future<void> _launchURL(String url) async {
  //   final Uri uri = Uri.parse(url);
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  void _validateForm(AuthProvider model) async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });

      final Map<String, dynamic> body = {
        "email": _emailController.text.trim(),
        "password": _passwordController.text.trim(),
      };
      // loginAccount();
      model.login(body);
    } else {
      // Form is invalid, no action needed here since warnings are shown automatically
    }
  }

  loginAccount() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => OtpScreen(
                  email: _emailController.text,
                )));
    // Navigator.pushReplacement(context,
    //     MaterialPageRoute(builder: (context) => const DashboardScreen()));
  }

  final box = Hive.box(kAppName);
  @override
  void initState() {
    super.initState();
    box.put(kExistingUser, true);
  }
String pin = '';
  bool isPinLogin = true;

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      body: Consumer<AuthProvider>(builder: (context, model, _) {
        return SafeArea(
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
                        if (isPinLogin) ...[
                          Text(
                            'Email',
                            style: NewStyle.tx14SplashWhite.copyWith(
                                color: MyColor.lightBlackColor,
                                fontWeight: FontWeight.w700,
                                height: 2),
                          ),
                          SizedBox(height: 20),
                          OtpTextField(
                            numberOfFields: 4,
                            borderColor: Colors.white,
                            fillColor: NewColor.inputFillColor,
                            focusedBorderColor: MyColor.greenColor,
                            textStyle: const TextStyle(
                                fontSize: 16,
                                height: 1.3,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                            filled: true,
                            borderWidth: 0.68,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12.5)),
                            showFieldAsBox: true,
                            // clearText: clearText,
                            autoFocus: true,
                            onCodeChanged: (String code) {
                              pin = code;
                            },
                            onSubmit: (String code) {
                              pin = code;
                            },
                          ),
                        ] else ...[
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
                              return 'Please enter a valid email address';
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
                              return 'Please enter a password';
                            } else if (value.length < 8) {
                              return 'Please enter at least 8 letters';
                            }
                            return null;
                          },
                          ),
                        ],

                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            onPressed: () => Get.to(ForgotPassword(
                              isPin: isPinLogin,
                            )),
                            child: Text(
                              isPinLogin ? 'Forgot PIN?' :
                            'Forgot Password?',
                              style: NewStyle.tx14SplashWhite
                                  .copyWith(color: MyColor.greenColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomButton(
                      text: 'Login',
                      isLoading: model.isLoading,
                      onTap: () {
                        isPinLogin
                            ? pin.isNotEmpty && pin.length == 4
                                ? model.pinLogin(pin)
                                : ErrorToast('Please enter a valid PIN')
                            : _validateForm(model);
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have an account? ',
                        style: NewStyle.btnTx16SplashBlue.copyWith(
                            color: MyColor.signGray,
                            fontWeight: FontWeight.w400),
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
                  const SizedBox(height: 34)
                ],
              ),
            ),
          ),
        );
      }
      ),
    );
  }
}
