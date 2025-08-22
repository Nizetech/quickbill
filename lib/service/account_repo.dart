import 'dart:convert';


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

  Future<Map<String, dynamic>> getNetworkProviders() async {
    String token = await box.get(kAccessToken);
    try {
      final response =
          await client.get(ApiRoute.getNetworkProviders, requestHeaders: {
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

  Future<Map<String, dynamic>> updateProfileImage(String image) async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(ApiRoute.updateProfileImage,
          body: jsonEncode({"image": image}),
          requestHeaders: {
            'Authorization': token,
          });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getDepositInvoice(String bankID) async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(ApiRoute.getInvoice, body: {
        "bank_id": int.parse(bankID),
      }, requestHeaders: {
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
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getBanks() async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(ApiRoute.getBanks, requestHeaders: {
        'Authorization': token,
      });
    
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
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }


  Future<dynamic> getDataPlans(String network) async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(
        ApiRoute.getDataPlans,
        requestHeaders: {
          'Authorization': token,
        },
        body: {"network_name": network},
      );
    
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<dynamic> getServiceHistory(
    String type, {
    Map<String, dynamic>? filter,
  }) async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(
        ApiRoute.serviceHistory,
        requestHeaders: {
          'Authorization': token,
        },
        body: {
          "type": type,
          if (filter != null) ...filter,
        },
      );
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<dynamic> getDepositHistory() async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client.post(
        ApiRoute.recentDepositHistory,
        requestHeaders: {
          'Authorization': token,
        },
        body: {
          "type": 'deposit',
        },
      );
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
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> deleteAccount() async {
    String token = await box.get(kAccessToken);
    try {
      final response =
          await client.post(ApiRoute.deleteAccount, requestHeaders: {
        'Authorization': token,
      });
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
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> getBalance() async {
    String token = await box.get(kAccessToken) ?? '';
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

  Future<Map<String, dynamic>> buyAirtime(Map<String, dynamic> data) async {
    String token = await box.get(kAccessToken);
    try {
      final response =
          await client.post(ApiRoute.buyAirtime, body: data, requestHeaders: {
        'Authorization': token,
      });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> buyData(Map<String, dynamic> data) async {
    String token = await box.get(kAccessToken);
    try {
      final response =
          await client.post(ApiRoute.buyData, body: data, requestHeaders: {
        'Authorization': token,
      });
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> createDeposit(Map<String, dynamic> data) async {
    String token = await box.get(kAccessToken);
    try {
      final response = await client
          .post(ApiRoute.creditDeposit, body: data, requestHeaders: {
        'Authorization': token,
      });
      //  log('Response: $response');
      return response;
    } catch (e) {
      print('Error: $e');
      return {};
    }
  }
}
