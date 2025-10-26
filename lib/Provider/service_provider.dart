import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/common/success_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:jost_pay_wallet/Models/cable_merchant.dart';
import 'package:jost_pay_wallet/Models/cable_transactions.dart';
import 'package:jost_pay_wallet/Models/cable_varaitaions.dart';
import 'package:jost_pay_wallet/Models/electricity_history.dart';
import 'package:jost_pay_wallet/Models/paymentOption.dart';
import 'package:jost_pay_wallet/Models/receipt_model.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/service/seervice_repo.dart';
import 'package:jost_pay_wallet/utils/loader.dart';
import 'package:jost_pay_wallet/utils/toast.dart';

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
      {required AccountProvider account}) async {
    try {
      // showLoader();
      showLoader();
      bool isFailed = false;
      bool isPending = false;
      var res = await ServiceRepo().buyCable(data);
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
            Get.close(4);
          
          },
        );
       
      } else {
        showSuccessScreen(
          title: 'Cable Tv',
          amount: data['amount'],
          status: 'success',
          onTap: () async {
            Get.close(4);
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
      bool noToken = res['token'] == null &&
          res['data']?['Token'] == null &&
          res['data']?['mainToken'] == null &&
          res['data']?['token'] == null;
      isFailed = res['result'] == 'failed';
      isPending = res['result'] == 'pending' || res == {};
      if (noToken ||
          (res['status'] == false ||
              res['result'] == false ||
              isFailed ||
              isPending)) {
        if (res['result'] == 'slow') {
          Get.back();
          if (res['message'].runtimeType == String) {
            ErrorToast(res['message']);
          } else {
            String message = '';
            res['message'].forEach((key, value) {
              message += '$value';
            });
            ErrorToast(message);
          }
        } else {
          // Get.off(CableElectricitySuccessScreen(
          //   isCable: false,
          //   isPending: true,
          //   amount: data['amount'],
          // ));
          showSuccessScreen(
            title: 'Electricity',
            status: isPending == true ? 'pending' : 'failed',
            amount: data['amount'],
            onTap: () {
              Get.close(3);
            },
          );
        }
      }
    
      else {
        // Get.off(CableElectricitySuccessScreen(
        //   isCable: false,
        //   data: res,
        //   amount: data['amount'],
        // ));
        showSuccessScreen(
          title: 'Electricity',
          status: 'success',
          amount: data['amount'],
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
