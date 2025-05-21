// import 'dart:io';
// import 'package:jost_pay_wallet/LocalDb/Local_Ex_Transaction_address.dart';
// import 'package:jost_pay_wallet/LocalDb/Local_Sell_History_address.dart';
// import 'package:jost_pay_wallet/LocalDb/Local_Token_provider.dart';
// import 'package:jost_pay_wallet/LocalDb/Local_Walletv2_provider.dart';
// import 'package:jost_pay_wallet/Provider/DashboardProvider.dart';
// import 'package:jost_pay_wallet/Values/Helper/helper.dart';
// import 'package:jost_pay_wallet/Values/utils.dart';
// import 'package:local_auth_ios/types/auth_messages_ios.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:jost_pay_wallet/LocalDb/Local_Account_address.dart';
// import 'package:jost_pay_wallet/LocalDb/Local_Account_provider.dart';
// import 'package:jost_pay_wallet/Provider/Account_Provider.dart';
// import 'package:jost_pay_wallet/Provider/Token_Provider.dart';
// import 'package:jost_pay_wallet/Ui/Authentication/WelcomeScreen.dart';
// import 'package:jost_pay_wallet/bottom_nav.dart';
// import 'package:jost_pay_wallet/Values/MyColor.dart';
// import 'package:jost_pay_wallet/Values/MyStyle.dart';
// import 'package:custom_pin_screen/custom_pin_screen.dart';
// import 'package:local_auth/local_auth.dart';
// import 'package:pin_code_fields/pin_code_fields.dart' as pin;
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uuid/uuid.dart';

// class LoginWithPassCode extends StatefulWidget {
//   const LoginWithPassCode({super.key});

//   @override
//   State<LoginWithPassCode> createState() => _LoginWithPassCodeState();
// }

// class _LoginWithPassCodeState extends State<LoginWithPassCode> {
//   TextEditingController passwordController = TextEditingController();

//   bool showPassword = true;

//   late AccountProvider accountProvider;
//   late TokenProvider tokenProvider;
//   late DashboardProvider dashProvider;

//   final LocalAuthentication auth = LocalAuthentication();
//   late String deviceId;
//   bool fingerOn = false;
//   String isLogin = "";

//   bool isLoading = false;

//   getDeviceId() async {
//     setState(() {
//       isLoading = true;
//     });

//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     setState(() {
//       deviceId = sharedPreferences.getString('deviceId')!;
//       isLogin = sharedPreferences.getString('isLogin') ?? "";
//       fingerOn = sharedPreferences.getBool('fingerOn') ?? false;
//     });
//     //_authenticate();

//     if (isLogin == "true") {
//       if (fingerOn == true) {
//         _authenticate();
//       } else {
//         setState(() {
//           isLoading = false;
//         });
//       }
//     } else {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   bool _authorizedAvailable = false;
//   Future<void> _authenticate() async {
//     bool authenticated = false;

//     List<BiometricType> availableBiometrics =
//         await auth.getAvailableBiometrics();

//     if (Platform.isIOS) {
//       if (availableBiometrics.contains(BiometricType.face) ||
//           availableBiometrics.contains(BiometricType.strong)) {
//         _authorizedAvailable = true;
//         // Face ID.
//       } else if (availableBiometrics.contains(BiometricType.fingerprint) ||
//           availableBiometrics.contains(BiometricType.strong)) {
//         // Touch ID.
//         _authorizedAvailable = true;
//       }
//     } else if (Platform.isAndroid) {
//       if (availableBiometrics.contains(BiometricType.fingerprint) ||
//           availableBiometrics.contains(BiometricType.strong) ||
//           availableBiometrics.contains(BiometricType.weak)) {
//         _authorizedAvailable = true;
//       }
//     }

//     if (_authorizedAvailable == true) {
//       try {
//         IOSAuthMessages iosStrings = const IOSAuthMessages(
//             cancelButton: "cancel",
//             goToSettingsButton: "settings",
//             goToSettingsDescription: "Please set up your Touch ID",
//             lockOut: "Please Re-enable your Touch ID");

//         authenticated = await auth.authenticate(
//           localizedReason: "Please authenticate to Login your Account",
//           authMessages: [iosStrings],
//           options: const AuthenticationOptions(
//             stickyAuth: true,
//             biometricOnly: true,
//             useErrorDialogs: true,
//           ),
//         );
//       } on PlatformException catch (_) {
//         setState(() {
//           isLoading = false;
//         });
//       }

//       if (authenticated == true) {
//         setState(() {
//           isLoading = false;
//         });

//         autologin();
//       } else {
//         setState(() {
//           isLoading = false;
//         });
//       }
//     } else {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   void initState() {
//     accountProvider = Provider.of<AccountProvider>(context, listen: false);
//     tokenProvider = Provider.of<TokenProvider>(context, listen: false);
//     dashProvider = Provider.of<DashboardProvider>(context, listen: false);

//     super.initState();

//     Future.delayed(Duration.zero, () {
//       getDeviceId();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     accountProvider = Provider.of<AccountProvider>(context, listen: true);
//     tokenProvider = Provider.of<TokenProvider>(context, listen: true);
//     dashProvider = Provider.of<DashboardProvider>(context, listen: true);

//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15.0),
//         child: SizedBox(
//           height: height,
//           width: width,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               const SizedBox(height: 15),
//               Image.asset(
//                 "assets/images/logo.png",
//                 height: 60,
//                 width: width * 0.4,
//                 fit: BoxFit.contain,
//               ),
//               const SizedBox(height: 5),

//               // title
//               Text(
//                 "Please Enter your passcode \nto proceed!",
//                 textAlign: TextAlign.center,
//                 style: MyStyle.tx18RWhite
//                     .copyWith(fontSize: 14, color: MyColor.grey01Color),
//               ),

//               SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.7,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: pin.PinCodeTextField(
//                     appContext: context,
//                     pastedTextStyle: TextStyle(
//                       color: Colors.green.shade600,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     length: 6,
//                     obscureText: true,
//                     obscuringWidget: Container(
//                       decoration: const BoxDecoration(
//                           color: MyColor.greenColor, shape: BoxShape.circle),
//                     ),
//                     pinTheme: pin.PinTheme(
//                         shape: pin.PinCodeFieldShape.box,
//                         borderRadius: BorderRadius.circular(100),
//                         fieldHeight: 20,
//                         fieldWidth: 20,
//                         inactiveColor: MyColor.boarderColor,
//                         inactiveBorderWidth: 2,
//                         inactiveFillColor: MyColor.transparentColor),
//                     cursorColor: MyColor.greenColor,
//                     animationDuration: const Duration(milliseconds: 300),
//                     enableActiveFill: true,
//                     controller: passwordController,
//                     keyboardType: TextInputType.number,
//                     onCompleted: (v) {},
//                     onChanged: (value) {
//                       // debugPrint(value);
//                     },
//                   ),
//                 ),
//               ),

//               SizedBox(
//                 height: height * 0.4,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     CustomKeyBoard(
//                       maxLength: 6,
//                       pinTheme: PinTheme(keysColor: MyColor.mainWhiteColor),
//                       onChanged: (p0) {
//                         setState(() {
//                           passwordController.text = p0;
//                         });
//                       },
//                       onCompleted: (p0) {
//                         loginAccount();
//                       },
//                       specialKey: Visibility(
//                         visible: fingerOn,
//                         child: Image.asset(
//                           "assets/images/fingerprint.png",
//                           height: 45,
//                           width: 60,
//                           fit: BoxFit.contain,
//                           color: MyColor.whiteColor,
//                         ),
//                       ),
//                       specialKeyOnTap: () {
//                         if (fingerOn) {
//                           _authenticate();
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),

//               InkWell(
//                 onTap: () {
//                   deleteAlert();
//                 },
//                 child: const Text("Reset wallet", style: MyStyle.tx18RWhite),
//               ),
//               const SizedBox(height: 15),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
