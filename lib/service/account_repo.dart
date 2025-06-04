import 'dart:developer';
import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:jost_pay_wallet/constants/api_constants.dart';
import 'package:jost_pay_wallet/constants/constants.dart';
import 'package:jost_pay_wallet/utils/network_clients.dart';

class AccountRepo {
  final client = NetworkClient();
  final box = Hive.box(kAppName);

  Future<Map<String, dynamic>> getProfile() async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(ApiRoute.userProfile, requestHeaders: {
        'Authorization': token,
      });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getProfileImage() async {
    String token = await box.get(kAccessToken);
    try {
      final response =
          await client.post(ApiRoute.getProfileImage, requestHeaders: {
        'Authorization': token,
      });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> updateProfileImage(File image) async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.sendFormData(FormDataType.post,
          imageKey: 'profile_photo',
          image: image,
          uri: ApiRoute.updateProfileImage,
          requestHeaders: {
            'Authorization': token,
          });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getNotification() async {
    String token = await box.get(kAccessToken);
    try {
      final response =
          await client.post(ApiRoute.getNotification, requestHeaders: {
        'Authorization': token,
      });
      log('Reponse: $response');
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<dynamic> enableDisable2fa(int useGoogleAuth) async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(
        ApiRoute.enable2fa,
        requestHeaders: {
          'Authorization': token,
        },
        body: {"use_google_auth": useGoogleAuth},
      );
      log('Reponse: $response');
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<dynamic> readNotification() async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(
        ApiRoute.readNotification,
        requestHeaders: {
          'Authorization': token,
        },
        body: {"id": 0},
      );
      log('Reponse: $response');
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }


  Future<Map<String, dynamic>> getPromotion() async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(ApiRoute.getPromo, requestHeaders: {
        'Authorization': token,
      });
      // log('Reponse: $response');
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getReferral() async {
    String token = await box.get(kAccessToken);
    try {
      final response =
          await client.post(ApiRoute.getReferrals, requestHeaders: {
        'Authorization': token,
      });
      log('Response: $response');
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getBalance() async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(ApiRoute.getBalance, requestHeaders: {
        'Authorization': token,
      });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getTransactions() async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(ApiRoute.getTransactions, body: {
        "type": "all"
      }, requestHeaders: {
        'Authorization': token,
      });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }
}
