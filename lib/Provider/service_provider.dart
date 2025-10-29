import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_bills/common/success_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:quick_bills/Models/cable_merchant.dart';
import 'package:quick_bills/Models/cable_transactions.dart';
import 'package:quick_bills/Models/cable_varaitaions.dart';
import 'package:quick_bills/Models/electricity_history.dart';
import 'package:quick_bills/Models/paymentOption.dart';
import 'package:quick_bills/Models/receipt_model.dart';
import 'package:quick_bills/Provider/account_provider.dart';
import 'package:quick_bills/service/seervice_repo.dart';
import 'package:quick_bills/utils/loader.dart';
import 'package:quick_bills/utils/toast.dart';

class ServiceProvider with ChangeNotifier {


  PaymentFeeModel? paymentFeeModel;
  CableTransactionModel? cableTransactionModel;
  MerchantModel? merchantModel;
  ElectricityHistoryModel? electricityHistoryModel;
  CableVariations? cableVariationsModel;
  ReceiptModel? receiptModel;

  String base64Image = '';

  void updateImage(String image) {
    base64Image = image;
    notifyListeners();
  }

  void clearImage() {
    base64Image = '';
    print("base64Image $base64Image");
    notifyListeners();
  }

  Future<void> getCableTransactions(
      {bool isLoading = true, required AccountProvider account}) async {
    try {
      if (isLoading) showLoader();
      var res = await ServiceRepo().getCableTransactions();
      if (res['status'] == false || res['result'] == false) {
        if (isLoading) hideLoader();
        if (res['message'].runtimeType == String) {
          ErrorToast(res['message']);
        } else {
          String message = '';
          res['message'].forEach((key, value) {
            message += '$value';
          });
          ErrorToast(message);
        }
        return;
      } else {
        cableTransactionModel = CableTransactionModel.fromJson(res);
        await account.getUserProfile();
        hideLoader();
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      hideLoader();
      ErrorToast(e.toString());
    }
  }

  Future<void> getElectricityTransactions(
      {bool isLoading = true, required AccountProvider account}) async {
    try {
      if (isLoading) showLoader();
      var res = await ServiceRepo().getElectricityTransactions();
      if (res['status'] == false || res['result'] == false) {
        if (isLoading) hideLoader();
        if (res['message'].runtimeType == String) {
          ErrorToast(res['message']);
        } else {
          String message = '';
          res['message'].forEach((key, value) {
            message += '$value';
          });
          ErrorToast(message);
        }
        return;
      } else {
        electricityHistoryModel = ElectricityHistoryModel.fromJson(res);
        await account.getUserProfile();
        hideLoader();
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      hideLoader();
      ErrorToast(e.toString());
    }
  }

  Future<void> getCableMerchant(Map<String, dynamic> data,
      {required VoidCallback callback}) async {
    try {
      showLoader();
      var res = await ServiceRepo().getCableMerchant(data);
      if (res['res'] != null &&
          res['res']['content'].toString().contains('error')) {
        hideLoader();
        ErrorToast(res['res']['content']['error']);
        return;
      }
      merchantModel = MerchantModel.fromJson(res);
      hideLoader();
      callback();
      notifyListeners();
    } catch (e) {
      print('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> getElectricityMerchant(Map<String, dynamic> data,
      {required VoidCallback callback}) async {
    try {
      showLoader();
      var res = await ServiceRepo().getElectricityMerchant(data);
      if (res['res'] != null &&
          res['res']['content'].toString().contains('error')) {
        hideLoader();
        ErrorToast(res['res']['content']['error']);
        return;
      }
      merchantModel = MerchantModel.fromJson(res);
      hideLoader();
      callback();
      notifyListeners();
    } catch (e) {
      print('Error: $e');
      hideLoader();
      ErrorToast(e.toString());
    }
  }

  Future<void> getCableVariations(String serviceId) async {
    try {
      showLoader();
      var res = await ServiceRepo().getCableVariations(serviceId);
      if (res['status'] == false || res['result'] == false) {
        hideLoader();
        if (res['message'].runtimeType == String) {
          ErrorToast(res['message']);
        } else {
          String message = '';
          res['message'].forEach((key, value) {
            message += '$value';
          });
          ErrorToast(message);
        }
        return;
      } else {
        cableVariationsModel = CableVariations.fromJson(res);
        hideLoader();
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      ErrorToast(e.toString());
    }
  }


  Future<void> getReceipt(Map<String, dynamic> data,
      {required VoidCallback callback}) async {
    try {
      showLoader();
      var res = await ServiceRepo().getReceipt(data);
      if (res['status'] == false || res['result'] == false) {
        hideLoader();
        if (res['message'].runtimeType == String) {
          ErrorToast(res['message']);
        } else {
          String message = '';
          res['message'].forEach((key, value) {
            message += '$value';
          });
          ErrorToast(message);
        }
        return;
      } else {
        receiptModel = ReceiptModel.fromJson(res);
        hideLoader();
        callback();
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      hideLoader();
      ErrorToast(e.toString());
    }
  }

  Future<void> buyCable(
    Map<String, dynamic> data,
      {required AccountProvider account,
      required bool isShowmax,
      required}) async {
    try {
      // showLoader();
      showLoader();
      bool isFailed = false;
      bool isPending = false;
      var res = await ServiceRepo().buyCable(data);
      log('cable response: $res');
      if (res['result'] == 'slow') {
        ErrorToast(res['message']);
        return;
      }
      if (res['status'] == false ||
          res['result'] == false ||
          isFailed ||
          isPending) {
        hideLoader();
       
        showSuccessScreen(
          title: 'Cable Tv',
          status: isPending == true ? 'pending' : 'failed',
          amount: data['amount'],
          onTap: () async {
            Get.close(3);
          
          },
        );
       
      } else {
        hideLoader();
        showSuccessScreen(
          title: 'Cable Tv',
          amount: data['amount'],
          isCable: true,
          token: isShowmax ? res['data']['purchased_code'].toString() : null,
          status: 'success',
          onTap: () async {
            Get.close(3);
            await account.getUserBalance();
            await account.getTrasactions();
          },
        );
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      hideLoader();
      ErrorToast(e.toString());
    }
  }

  Future<void> buyElectricity(Map<String, dynamic> data,
      {required AccountProvider account}) async {
    try {
      showLoader();
      bool isFailed = false;
      bool isPending = false;
      var res = await ServiceRepo().buyElectricity(data);
      log('electricity response: $res');
      // bool noToken = res['token'] == null &&
      //     res['data']?['Token'] == null &&
      //     res['data']?['mainToken'] == null &&
      //     res['data']?['token'] == null;
      isFailed = res['result'] == 'failed';
      isPending = res['result'] == 'pending' || res == {};
      if (res['result'] == 'slow') {
        ErrorToast(res['message']);
        return;
      }
      if (
          (res['status'] == false ||
              res['result'] == false ||
              isFailed ||
              isPending)) {
    
        hideLoader();
          showSuccessScreen(
            title: 'Electricity',
            status: isPending == true ? 'pending' : 'failed',
            amount: data['amount'],
            onTap: () {
              Get.close(3);
            },
          );
        // }
      }
    
      else {
        hideLoader();
        showSuccessScreen(
          title: 'Electricity',
          status: 'success',
          amount: data['amount'],
          token: res['token']?.toString() ??
              res['data']?['Token']?.toString() ??
              res['data']?['mainToken']?.toString() ??
              res['data']?['token']?.toString() ??
              "",
          onTap: () async {
            Get.close(3);
            await account.getUserBalance();
            await account.getTrasactions();
          },
        );
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      ErrorToast(e.toString());
    }
  }

  // get pdf
  Future<void> getPdfReceipt(int id) async {
    try {
      showLoader();
      var res = await ServiceRepo().getPdfReceipt(id);

      hideLoader();
      if (res['status'] == false || res['result'] == false) {
        if (res['message'].runtimeType == String) {
          ErrorToast(res['message']);
        } else {
          String message = '';
          res['message'].forEach((key, value) {
            message += '$value';
          });
          ErrorToast(message);
        }
        return;
      } else {
        // convert res["content_base64"] to file
        final bytes = base64Decode(res["content_base64"]);
        final dir = await getTemporaryDirectory();
        final file = File('${dir.path}/${res["file_name"]}');
        await file.writeAsBytes(bytes);

        // var xFile = XFile(res);
        Share.shareXFiles([XFile(file.path)], text: 'Transaction Receipt');
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      ErrorToast(e.toString());
    }
  }

}
