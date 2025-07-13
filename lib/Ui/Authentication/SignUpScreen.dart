
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:jost_pay_wallet/Provider/auth_provider.dart';
import 'package:jost_pay_wallet/Ui/Authentication/SignInScreen.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
// import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
// import 'package:csc_picker/csc_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

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
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _referalCode = TextEditingController();
  final _lastName = TextEditingController();
  final _firstName = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String selectedCountryCode = '234';
  String selectedCountry = 'NG';

  // static Future<void> saveToken(String token) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString("token", token);
  // }

  void _validateForm(AuthProvider model) async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_confirmPasswordController.text != _passwordController.text) {
        ErrorToast("Password does not match");
        return;
      } else {
        model.createAccount({
          "email": _emailController.text.trim(),
          "password": _passwordController.text.trim(),
          "first_name": _firstName.text.trim(),
          "last_name": _lastName.text.trim(),
          'country': selectedCountry,
          "referral_code": _referalCode.text.trim(),
          "phone":
              // remove the first zero from the phone number if it starts with 0
              selectedCountry == 'NG' &&
                      _phoneNumberController.text.trim().startsWith('0')
                  ? '+$selectedCountryCode${_phoneNumberController.text.trim().substring(1)}'
                  : '+$selectedCountryCode${_phoneNumberController.text.trim()}'
        });
      }
    } else {}
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context).colorScheme;
    final model = context.watch<AuthProvider>();
    return Scaffold(
  
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 1, 0),
          child: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen()));
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
      body: Consumer<AuthProvider>(builder: (context, ctr, _) {
        return SingleChildScrollView(
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

                      const Text.rich(
                        TextSpan(
                          text: 'Create a ',
                          style: MyStyle.tx28Black,
                          children: [
                            TextSpan(
                              text: 'Jostpay\n',
                              style: MyStyle.tx28Green,
                            ),
                            TextSpan(
                              text: ' account',
                              style: MyStyle.tx28Black,
                            ),
                          ],
                        ),
                      ),
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
                        controller: _firstName,
                        decoration: NewStyle.authInputDecoration.copyWith(
                          hintText: 'Enter your first name',
                        ),
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
                        controller: _lastName,
                        decoration: NewStyle.authInputDecoration.copyWith(
                          hintText: 'Enter your last name',
                        ),
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
                        decoration: NewStyle.authInputDecoration.copyWith(
                          hintText: 'Enter your email address',
                        ),
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
                        'Phone Number',
                        style: NewStyle.tx14SplashWhite.copyWith(
                            color: MyColor.lightBlackColor,
                            fontWeight: FontWeight.w700,
                            height: 2),
                      ),
                      // TextFormField(
                      //   style: TextStyle(
                      //     fontSize: 14.sp,
                      //     color: themedata.tertiary,
                      //     fontFamily: 'SF Pro Rounded',
                      //   ),
                      //   controller: _phoneNumberController,
                      //   decoration: NewStyle.authInputDecoration
                      //       .copyWith(hintText: "+234"),
                      //   keyboardType: TextInputType.phone,
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please enter some text';
                      //     }
                      //     // else if (!RegExp(r'^\+(?:[0-9] ?){6,14}[0-9]$')
                      //     //     .hasMatch(value)) {
                      //     //   return 'Please enter a valid phone number';
                      //     // }
                      //     return null;
                      //   },
                      // ),
                      IntlPhoneField(
                        flagsButtonMargin: EdgeInsets.zero,
                        flagsButtonPadding: EdgeInsets.zero,
                        dropdownDecoration: BoxDecoration(
                          color: MyColor.mainWhiteColor,
                        ),
                        dropdownIcon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: MyColor.lightBlackColor,
                        ),
                        decoration: NewStyle.authInputDecoration.copyWith(
                          hintText: '8061560000',
                        ),
                        style: NewStyle.tx14SplashWhite.copyWith(
                          color: MyColor.lightBlackColor,
                          fontSize: 14,
                        ),
                        initialCountryCode: selectedCountry,
                        controller: _phoneNumberController,
                        onCountryChanged: (country) {
                          setState(() {
                            selectedCountry = country.code;
                            selectedCountryCode = country.dialCode;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.number.isEmpty) {
                            return 'Please enter a valid phone number';
                          } else if (!RegExp(r'^\+(?:[0-9] ?){6,14}[0-9]$')
                              .hasMatch(value.number)) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      
                      // const SizedBox(height: 14),
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
                        controller: _referalCode,
                        decoration: NewStyle.authInputDecoration.copyWith(
                          hintText: 'Enter your refer ID',
                        ),
                        keyboardType: TextInputType.text,
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
                        decoration: NewStyle.authInputDecoration.copyWith(
                          hintText: 'Enter your password',
                        ),
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
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: NewStyle.authInputDecoration.copyWith(
                          hintText: 'Re-enter your password',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter confirm password';
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
                CustomButton(
                    text: 'Sign Up',
                    isLoading: model.isLoading,
                    onTap: () {
                      _validateForm(model);
                    }),
                Column(children: [
                  const SizedBox(height: 17),
                  if (!model.isLoading)
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        'Already have an account? ',
                        style: NewStyle.btnTx16SplashBlue.copyWith(
                            color: MyColor.signGray,
                            fontWeight: FontWeight.w500),
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
                  const SizedBox(height: 34),
                ])
              ],
            ),
          ),
        );
      }),
    );
  }
}
