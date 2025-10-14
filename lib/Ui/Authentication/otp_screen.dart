// import 'dart:developer';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:jost_pay_wallet/Provider/account_provider.dart';
// import 'package:jost_pay_wallet/Provider/auth_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:jost_pay_wallet/Provider/DashboardProvider.dart';
// import 'package:jost_pay_wallet/common/button.dart';
// import 'package:jost_pay_wallet/utils/toast.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// // ignore: unused_import
// import 'package:jost_pay_wallet/Values/NewStyle.dart';
// import 'package:jost_pay_wallet/Values/NewColor.dart';
// import '../../Values/MyColor.dart';
// import '../../Values/MyStyle.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

// class OtpScreen extends StatefulWidget {
//   final String email;
//   final String? authToken;
//   final bool isForgetPass;
//   final bool is2Fa;
//   const OtpScreen(
//       {super.key,
//       this.authToken,
//       required this.email,
//       this.isForgetPass = false,
//       this.is2Fa = false});

//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }

// class _OtpScreenState extends State<OtpScreen> {
//   late SharedPreferences sharedPreferences;
//   late String emailCode;

//   bool isLoading = false;
//   bool clearText = false;


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Consumer<AuthProvider>(builder: (context, model, _) {
//         log("isDark:====>>> ${widget.authToken}");
//         log("isDark Model:====>>> ${model.authToken}");
//         return SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.only(top: 70, right: 16.w, left: 16.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 const SizedBox(height: 20),
//                 Image.asset(
//                   'assets/images/logo.png',
//                   width: 170,
//                   height: 46,
//                 ),
//                 const SizedBox(height: 30),
//                 Text(
//                   'Code Verification.',
//                   style: MyStyle.tx16Black.copyWith(
//                     fontSize: 30,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 Text(
//                   'Enter OTP(One Time Password) sent to ${widget.email}',
//                   style: MyStyle.tx16Gray.copyWith(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 OtpTextField(
//                   numberOfFields: 6,
//                   borderColor: Colors.white,
//                   fillColor: NewColor.inputFillColor,
//                   focusedBorderColor: MyColor.primaryColor,
//                   textStyle: const TextStyle(
//                       fontSize: 16,
//                       height: 1.3,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.black),
//                   filled: true,
//                   borderWidth: 0.68,
//                   borderRadius: const BorderRadius.all(Radius.circular(12.5)),
//                   showFieldAsBox: true,
//                   clearText: clearText,
//                   autoFocus: true,
//                   onCodeChanged: (String code) {},
//                   onSubmit: (String verificationCode) {
//                     emailCode = verificationCode;
//                     if (emailCode.length == 6) {
//                       model.confirmOtp(
//                           authToken: model.authToken,
//                           account: context.read<AccountProvider>(),
//                           dashProvider: context.read<DashboardProvider>(),
//                           is2fa: widget.is2Fa,
//                           isForgetPass: widget.isForgetPass,
//                           {
//                             "email": widget.email,
//                             "code": emailCode,
//                           });
//                     }
//                   },
//                 ),
//                 const SizedBox(height: 40),
//                 CustomButton(
//                   text: "Confirm",
//                   onTap: () {
//                     if (emailCode.isEmpty) {
//                       ErrorToast("Please enter OTP");
//                     } else {
//                       model.confirmOtp(
//                           authToken: model.authToken,
//                           account: context.read<AccountProvider>(),
//                           dashProvider: context.read<DashboardProvider>(),
//                           is2fa: widget.is2Fa,
//                           isForgetPass: widget.isForgetPass,
//                           {
//                             "email": widget.email,
//                             "code": emailCode,
//                           });
//                     }
//                   },
//                 ),
//                 const SizedBox(height: 28),
//                 CustomButton(
//                   bgColor: MyColor.grey01Color,
//                   textColor: MyColor.primaryColor,
//                   fontWeight: FontWeight.w500,
//                   text: "Resend Code",
//                   onTap: () {
//                     model.resendOtp(
//                       widget.email,
//                       authToken: model.authToken,
//                     );
//                     setState(() {
//                       clearText = true;
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       }
//       ),
//     );
//   }
// }
