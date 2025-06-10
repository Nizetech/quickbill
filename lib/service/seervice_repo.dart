import 'dart:convert';
import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:jost_pay_wallet/constants/api_constants.dart';
import 'package:jost_pay_wallet/constants/constants.dart';
import 'package:jost_pay_wallet/utils/network_clients.dart';

class ServiceRepo {
  final client = NetworkClient();
  final box = Hive.box(kAppName);

  //? PAINT AND SPRAY
  // GET CAR TYPE

  Future<Map<String, dynamic>> getCarTypes() async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.get(ApiRoute.getCarTypes, requestHeaders: {
        'Authorization': token,
      });
      // log('Reponse: $response');
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getColorPaint() async {
    String token = await box.get(kAccessToken);
    try {
      final response =
          await client.get(ApiRoute.getColorPaint, requestHeaders: {
        'Authorization': token,
      });
      // log('Reponse: $response');
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> rentSpray(Map<String, dynamic> data) async {
    String token = await box.get(kAccessToken);
    var body = jsonEncode(data);
    log("body: ====> ${body.runtimeType}");
    try {
      final response =
          await client
          .post(ApiRoute.rentSpray, body: body, requestHeaders: {
        'Authorization': token,
      });
      log('Reponse: $response');
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> sprayDetails(int id) async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(ApiRoute.getSpraydetails,
          body: jsonEncode({"package": id}),
          requestHeaders: {
        'Authorization': token,
      });
      log('Reponse: $response');
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> payPending(int id) async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(ApiRoute.payPending,
          body: jsonEncode({"history_id": id}),
          requestHeaders: {
            'Authorization': token,
          });
      log('Reponse: $response');
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
      log('Reponse: $response');
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }


  Future<Map<String, dynamic>> getSprayHistory() async {
    String token = await box.get(kAccessToken);
    try {
      final response =
          await client.get(ApiRoute.getSprayHistory, requestHeaders: {
        'Authorization': token,
      });
      log('Reponse: $response');
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }
}
