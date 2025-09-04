import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:jost_pay_wallet/constants/api_constants.dart';
import 'package:jost_pay_wallet/constants/constants.dart';
import 'package:jost_pay_wallet/utils/loader.dart';
// import 'package:jost_pay_wallet/utils/loader.dart';
import 'package:jost_pay_wallet/utils/network_clients.dart';

class AuthRepo {
  final client = NetworkClient();
  final box = Hive.box(kAppName);

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
          body: jsonEncode({
        'email': email
      }),
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
  Future<Map<String, dynamic>> verifyOTP(Map<String, dynamic> data,
      {
    String? authToken,
    bool is2fa = false,
    bool isEnable2fa = false,
  }) async {
    String token = await box.get(kAccessToken, defaultValue: '');
    try {

      final response =
          await client.post(
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
      final response = await client
          .post(ApiRoute.updateProfile,
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
    try {
      final response = await client.post(ApiRoute.pinLogin,
          body: jsonEncode({
              "pin": pin,
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
      final response = await client
          .post(ApiRoute.changePassword,
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
