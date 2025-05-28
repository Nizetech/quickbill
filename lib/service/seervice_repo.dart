import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:jost_pay_wallet/constants/api_constants.dart';
import 'package:jost_pay_wallet/constants/constants.dart';
import 'package:jost_pay_wallet/utils/network_clients.dart';
import 'package:jost_pay_wallet/utils/toast.dart';

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
      log('Reponse: $response');
      return response;
    } catch (e) {
      // ErrorToast(e.toString());
      print('Error: $e');
      return {};
    }
  }
}
