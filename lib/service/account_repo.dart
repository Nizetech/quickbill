import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:jost_pay_wallet/constants/api_constants.dart';
import 'package:jost_pay_wallet/constants/constants.dart';
import 'package:jost_pay_wallet/utils/network_clients.dart';
import 'package:jost_pay_wallet/utils/toast.dart';

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
      ErrorToast(e.toString());
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
      ErrorToast(e.toString());
      return {};
    }
  }


  Future<Map<String, dynamic>> getPromotion() async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(ApiRoute.getPromo, requestHeaders: {
        'Authorization': token,
      });
      log('Reponse: $response');
      return response;
    } catch (e) {
      ErrorToast(e.toString());
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
      ErrorToast(e.toString());
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
      ErrorToast(e.toString());
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
      ErrorToast(e.toString());
      return {};
    }
  }
}
