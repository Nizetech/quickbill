import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:jost_pay_wallet/constants/api_constants.dart';
import 'package:jost_pay_wallet/constants/constants.dart';
// import 'package:jost_pay_wallet/utils/loader.dart';
import 'package:jost_pay_wallet/utils/network_clients.dart';
import 'package:jost_pay_wallet/utils/toast.dart';

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
      ErrorToast(e.toString());
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
      // hideLoader();
      ErrorToast(e.toString());
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
      ErrorToast(e.toString());
      return {};
    }
  }

  // verify otp
  Future<Map<String, dynamic>> verifyOTP(Map<String, dynamic> data,
      {bool is2fa = false}) async {
    String token = await box.get(kAccessToken);
    try {
      // log('Login Details: $email');
      final response =
          await client.post(
          is2fa ? ApiRoute.verify2fa : ApiRoute.verifyOtp,
          body: is2fa ? {'code': data['code']} : data,
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
      ErrorToast(e.toString());
      return {};
    }
  }

  // verify otp
  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data,
      {bool is2fa = false}) async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client
          .post(ApiRoute.updateProfile, body: data, requestHeaders: {
        'Authorization': token,
      });
      // log('Register: $response');
      if (response['token'] != null) {
        box.put(kAccessToken, response['token']);
      }
      return response;
    } catch (e) {
      // hideLoader();
      ErrorToast(e.toString());
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
      ErrorToast(e.toString());
      return {};
    }
  }

}
