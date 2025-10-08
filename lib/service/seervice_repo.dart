import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jost_pay_wallet/constants/api_constants.dart';
import 'package:jost_pay_wallet/constants/constants.dart';
import 'package:jost_pay_wallet/utils/network_clients.dart';

class ServiceRepo {
  final client = NetworkClient();
  final box = Hive.box(kAppName);

  Future<Map<String, dynamic>> getElectricityTransactions() async {
    String token = await box.get(kAccessToken);
    try {
      final response =
          await client.get(ApiRoute.electricityTransactions, requestHeaders: {
        'Authorization': token,
      });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getCableTransactions() async {
    String token = await box.get(kAccessToken);
    try {
      final response =
          await client.get(ApiRoute.cableTransactions, requestHeaders: {
        'Authorization': token,
      });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getCableMerchant(
      Map<String, dynamic> data) async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(ApiRoute.cableMerchant,
          body: jsonEncode(data),
          requestHeaders: {
            'Authorization': token,
          });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getElectricityMerchant(
      Map<String, dynamic> data) async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(ApiRoute.electricityMerchant,
          body: jsonEncode(data),
          requestHeaders: {
            'Authorization': token,
          });
      print('Merchant Response:==> $response');
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getCableVariations(String serviceId) async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(ApiRoute.cableVariations,
          body: jsonEncode({
            "service_id": serviceId,
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

  Future<Map<String, dynamic>> getReceipt(Map<String, dynamic> data) async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client
          .post(ApiRoute.receipt, body: jsonEncode(data), requestHeaders: {
        'Authorization': token,
      });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> buyElectricity(Map<String, dynamic> data) async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(ApiRoute.buyElectricity,
          body: jsonEncode(data),
          requestHeaders: {
            'Authorization': token,
          });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> buyCable(Map<String, dynamic> data) async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client
          .post(ApiRoute.buyCable, body: jsonEncode(data), requestHeaders: {
        'Authorization': token,
      });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }
  
  Future<Map<String, dynamic>> getPdfReceipt(int id) async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(ApiRoute.sharePdf,
          body: jsonEncode({"history_id": id}),
          requestHeaders: {
            'Authorization': token,
          });

      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

}
