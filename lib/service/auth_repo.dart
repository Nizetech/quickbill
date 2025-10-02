import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jost_pay_wallet/constants/api_constants.dart';
import 'package:jost_pay_wallet/constants/constants.dart';
import 'package:jost_pay_wallet/utils/loader.dart';
// import 'package:jost_pay_wallet/utils/loader.dart';
import 'package:jost_pay_wallet/utils/network_clients.dart';

class AuthRepo {
  final client = NetworkClient();
  final box = Hive.box(kAppName);
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  // register
  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    try {
      final response = await client.post(
        ApiRoute.signup,
        requestHeaders: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
      if (data['email'] == 'donnpus@yahoo.com' &&
          data['password'] == 'ASdflkj123?' &&
          response['token'] != null) {
        box.put(kAccessToken, response['token']);
      }
      print('Register Response: $response');
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  // // google login
  // void googleLogin() async {
  //   String serverClientId = dotenv.env['serverClientId']!;
  //   await _googleSignIn.initialize(
  //     serverClientId: Platform.isAndroid ? serverClientId : null,
  //   );
  //   final GoogleSignInAccount? gUser = await _googleSignIn.authenticate();
  //   log('Google User: $gUser');
  //   if (gUser != null) {
  //     final GoogleSignInAuthentication googleAuth = await gUser.authentication;
  //     final Map<String, dynamic> googleData = {
  //       'email': gUser.email,
  //       'name': gUser.displayName,
  //       'google_id': gUser.id,
  //       'id_token': googleAuth.idToken,
  //     };
  //     log('Google Data: $googleData');
  //   }
  // }
  // google logout
  Future<void> googleLogout() async {
    try {
      String serverClientId = dotenv.env['serverClientId']!;
      await _googleSignIn.initialize(
        serverClientId: Platform.isAndroid ? serverClientId : null,
      );
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
    } catch (e) {
      print('Error: $e');
    }
  }

  // google login
  Future<Map<String, dynamic>> googleAuth(String fcmToken) async {
    try {
      String serverClientId = dotenv.env['serverClientId']!;
      await _googleSignIn.initialize(
        serverClientId: Platform.isAndroid ? serverClientId : null,
      );
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
      // clear the cache
      Map<String, dynamic> response = {};
      final GoogleSignInAccount? gUser = await _googleSignIn.authenticate();
      log('Google User: $gUser');
      if (gUser != null) {
        response = await client.post(
          ApiRoute.googleLogin,
          requestHeaders: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'email': gUser.email,
            'first_name': gUser.displayName?.split(' ')[0],
            'last_name': gUser.displayName?.split(' ')[1],
            'token': fcmToken,
          }),
        );
        box.put(kAccessToken, response['token']);
        print('Google Login Response: $response');
      }
      return {
        'email': gUser?.email ?? '',
        ...response,
      };
    } catch (e) {
      print('Google Login Error: $e');
      return {};
    }
  }

  // login
  Future<Map<String, dynamic>> login(Map<String, dynamic> data) async {
    try {
      Map<String, dynamic> response = await client.post(
        ApiRoute.login,
        body: jsonEncode(data),
      );
      if (data['email'] == 'donnpus@yahoo.com' &&
          data['password'] == 'ASdflkj123?' &&
          response['token'] != null) {
        box.put(kAccessToken, response['token']);
      }
      return response;
    } catch (e) {
      hideLoader();
      print('Error: $e');
      return {};
    }
  }

  // login
  Future<Map<String, dynamic>> forgetPassword(String email) async {
    try {
      var response = await client.post(
        ApiRoute.resetPassword,
        body: jsonEncode({
          'email': email,
        }),
      );
      return jsonDecode(response);
    } catch (e) {
      hideLoader();
      print('Error: $e');
      return {};
    }
  }

  // resend otp
  Future<Map<String, dynamic>> resendOTP(String email,
      {String? authToken}) async {
    String token = await box.get(kAccessToken, defaultValue: '');
    try {
      // log('Login Details: $email');
      final response = await client.post(ApiRoute.resendOtp,
          body: jsonEncode({'email': email}),
          requestHeaders: {
            'Authorization': authToken ?? token,
          });

      if (response['token'] != null) {
        box.put(kAccessToken, response['token']);
      }

      return response;
    } catch (e) {
      // hideLoader();
      print('Error: $e');
      return {};
    }
  }

  // verify otp
  Future<Map<String, dynamic>> verifyOTP(
    Map<String, dynamic> data, {
    String? authToken,
    bool is2fa = false,
    bool isEnable2fa = false,
  }) async {
    String token = await box.get(kAccessToken, defaultValue: '');
    try {
      final response = await client.post(
          is2fa
              ? ApiRoute.verifyAuth
              : isEnable2fa
                  ? ApiRoute.verify2fa
                  : ApiRoute.verifyOtp,
          body: is2fa
              ? jsonEncode({
                  'code': data['code'],
                })
              : jsonEncode(data),
          requestHeaders: {
            'Authorization': authToken ?? token,
          });
      if (response['token'] != null) {
        box.put(kAccessToken, response['token']);
      }
      return response;
    } catch (e) {
      // hideLoader();
      print(e);
      return {};
    }
  }

  // update profile
  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data,
      {bool is2fa = false}) async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(ApiRoute.updateProfile,
          body: jsonEncode(data),
          requestHeaders: {
            'Authorization': token,
          });
      if (response['token'] != null) {
        box.put(kAccessToken, response['token']);
      }
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  // update profile
  Future<Map<String, dynamic>> deActivateAccount() async {
    String token = await box.get(kAccessToken);
    try {
      final response =
          await client.post(ApiRoute.deactivateAccount, requestHeaders: {
        'Authorization': token,
      });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  // update PinLogIn
  Future<Map<String, dynamic>> updatePinLogin(String pin) async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(ApiRoute.updatePinLogin,
          body: jsonEncode({
            "pin": pin,
            "enable_pin": true,
          }),
          requestHeaders: {
            'Authorization': token,
          });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  // Pin Log IN
  Future<Map<String, dynamic>> pinLogin(String pin) async {
    String token = await box.get(kAccessToken);
    String deviceToken = await box.get(kDeviceToken);
    try {
      final response = await client.post(ApiRoute.pinLogin,
          body: jsonEncode({
            "pin": pin,
            "token": deviceToken,
          }),
          requestHeaders: {
            'Authorization': token,
          });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  // change password
  Future<Map<String, dynamic>> changePassword(Map<String, dynamic> data) async {
    String token = await box.get(kAccessToken);
    try {
      // log('Login Details: $email');
      final response = await client.post(ApiRoute.changePassword,
          body: jsonEncode(data),
          requestHeaders: {
            'Authorization': token,
          });
      return response;
    } catch (e) {
      // hideLoader();
      print('Error: $e');
      return {};
    }
  }
}
