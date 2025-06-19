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
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getSocialSectionss() async {
    String token = await box.get(kAccessToken);
    try {
      final response =
          await client.post(ApiRoute.getSocialSections, requestHeaders: {
        'Authorization': token,
      });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getGiftCard(String code) async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(ApiRoute.getGiftCard, body: {
        "country_code": code,
      }, requestHeaders: {
        'Authorization': token,
      });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getCard(String cardId) async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(ApiRoute.getCard, body: {
        "gift_id": cardId,
      }, requestHeaders: {
        'Authorization': token,
      });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getSocialServices(int id) async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(ApiRoute.getSocialServices, body: {
        "section_id": id
      }, requestHeaders: {
        'Authorization': token,
      });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }


  Future<Map<String, dynamic>> buyCar(Map<String, dynamic> data) async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client
          .post(ApiRoute.buyCar, body: jsonEncode(data), requestHeaders: {
        'Authorization': token,
      });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> bookInspection(Map<String, dynamic> data) async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(ApiRoute.bookInspection,
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

  Future<Map<String, dynamic>> getCarDetails(String id) async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(ApiRoute.getCarDetails,
          body: jsonEncode({"id": int.parse(id)}),
          requestHeaders: {
            'Authorization': token,
          });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getScriptDetails(String id) async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(ApiRoute.getScriptDetails,
          body: jsonEncode({"id": int.parse(id)}),
          requestHeaders: {
            'Authorization': token,
          });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> buyScript(String id) async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(ApiRoute.buyScript,
          body: jsonEncode({"script_id": int.parse(id)}),
          requestHeaders: {
            'Authorization': token,
          });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getCarListing() async {
    String token = await box.get(kAccessToken);
    try {
      final response =
          await client.get(ApiRoute.getCarListing, requestHeaders: {
        'Authorization': token,
      });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getScript() async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.get(ApiRoute.getScript, requestHeaders: {
        'Authorization': token,
      });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }


  Future<Map<String, dynamic>> buySocialBoost(Map<String, dynamic> data) async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client
          .post(ApiRoute.buySocialBoost, body: data, requestHeaders: {
        'Authorization': token,
      });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> buyGiftCard(Map<String, dynamic> data) async {
    String token = await box.get(kAccessToken);
    try {
      final response =
          await client.post(ApiRoute.buyGiftCard, body: data, requestHeaders: {
        'Authorization': token,
      });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> buyPay4Me(Map<String, dynamic> data) async {
    String token = await box.get(kAccessToken);
    try {
      final response =
          await client.post(ApiRoute.buyPay4Me, body: data, requestHeaders: {
        'Authorization': token,
      });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getPayRate() async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(ApiRoute.getPayRate, requestHeaders: {
        'Authorization': token,
      });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getCardCountries() async {
    String token = await box.get(kAccessToken);
    try {
      final response =
          await client.post(ApiRoute.getCountries, requestHeaders: {
        'Authorization': token,
      });
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
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getScriptTransactions() async {
    String token = await box.get(kAccessToken);
    try {
      final response =
          await client.get(ApiRoute.scriptTransactions, requestHeaders: {
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
