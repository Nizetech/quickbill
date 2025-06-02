import 'dart:convert';
import 'dart:developer';

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
      log('Login Details: $data');
      final response = await client.post(
        ApiRoute.signup,
        body: data,
      );
      log('Register: $response');
      if (response['token'] != null) {
        box.put(kAccessToken, response['token']);
      }
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  // login
  Future<Map<String, dynamic>> login(Map<String, dynamic> data) async {
    try {
      log('Login Details: $data');
      Map<String, dynamic> response = await client.post(
        ApiRoute.login,
        body: data,
      );
      log('Register: $response, ${response.runtimeType}');
      if (response['token'] != null) {
        box.put(kAccessToken, response['token']);
      }
      return response;
    } catch (e) {
      log('Errrrr');
      hideLoader();
      print('Error: $e');
      return {};
    }
  }

  // login
  Future<Map<String, dynamic>> forgetPassword(String email) async {
    try {
      log('Details: $email');
      var response = await client.post(
        ApiRoute.resetPassword,
        body: {
          'email': email,
        },
      );
      log('Password reset: $response, ${response.runtimeType}');
      return jsonDecode(response);
    } catch (e) {
      log('Errrrr');
      hideLoader();
      print('Error: $e');
      return {};
    }
  }

  // resend otp
  Future<Map<String, dynamic>> resendOTP(String email) async {
    String token = await box.get(kAccessToken);
    try {
      // log('Login Details: $email');
      final response = await client.post(ApiRoute.resendOtp, body: {
        'email': email
      }, requestHeaders: {
        'Authorization': token,
      });
      log('Register: $response');

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
    bool is2fa = false,
    bool isEnable2fa = false,
  }) async {
    String token = await box.get(kAccessToken);
    try {
      // log('Login Details: $email');
      final response =
          await client.post(
          is2fa
              ? ApiRoute.verifyAuth
              : isEnable2fa
                  ? ApiRoute.verify2fa
                  : ApiRoute.verifyOtp,
          body: is2fa
              ? {
                  'code': data['code'],
                }
              : data,
          requestHeaders: {
        'Authorization': token,
      });
      log('Register: $response');
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
          .post(ApiRoute.updateProfile, body: data, requestHeaders: {
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

  // change password
  Future<Map<String, dynamic>> changePassword(Map<String, dynamic> data) async {
    String token = await box.get(kAccessToken);
    try {
      // log('Login Details: $email');
      final response = await client
          .post(ApiRoute.changePassword, body: data, requestHeaders: {
        'Authorization': token,
      });
      log('Register: $response');
      return response;
    } catch (e) {
      // hideLoader();
      print('Error: $e');
      return {};
    }
  }

}
