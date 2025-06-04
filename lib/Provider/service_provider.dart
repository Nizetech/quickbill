import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Models/car_type_model.dart';
import 'package:jost_pay_wallet/Models/color_paint_mode.dart';
import 'package:jost_pay_wallet/Models/spray_details.dart';
import 'package:jost_pay_wallet/Models/spray_history_model.dart';
import 'package:jost_pay_wallet/Ui/Paint/paint_invoice_screen.dart';
import 'package:jost_pay_wallet/service/seervice_repo.dart';
import 'package:jost_pay_wallet/utils/loader.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ServiceProvider with ChangeNotifier {
  //get car typee

  CarTypeModel? carTypeModel;
  ColorPaintModel? colorPaintModel;
  SprayHistoryModel? sprayHistoryModel;
  SprayDetailsModel? sprayDetailsModel;
  String base64Image = '';

  void updateImage(String image) {
    base64Image = image;
    notifyListeners();
  }

  Future<void> getCarTypes() async {
    try {
      showLoader();
      var res = await ServiceRepo().getCarTypes();
      if (res['status'] == false) {
        ErrorToast(res['message']);
        hideLoader();
        return;
      }
      carTypeModel = CarTypeModel.fromJson(res);
      hideLoader();
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> rentSpray(Map<String, dynamic> data) async {
    try {
      showLoader();
      var res = await ServiceRepo().rentSpray(data);
      if (res['status'] == false) {
        ErrorToast(res['message']);
        hideLoader();
        return;
      }
      await getSprayHistory(isLoading: false);
      hideLoader();
      Get.close(2);
      SuccessToast(res['message']);
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> sprayDetails(int id) async {
    try {
      showLoader();
      var res = await ServiceRepo().sprayDetails(id);
      if (res['status'] == false) {
        ErrorToast(res['message']);
        hideLoader();
        return;
      }
      sprayDetailsModel = SprayDetailsModel.fromJson(res);
      hideLoader();
      Get.to(PaintInvoiceScreen(
        historyId: id,
      ));
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> getSprayDetails(Map<String, dynamic> data) async {
    try {
      showLoader();
      var res = await ServiceRepo().rentSpray(data);
      
      hideLoader();
      if (res['status'] == false) {
        ErrorToast(res['message']);
        return;
      }
      Get.close(2);
      SuccessToast(res['message']);
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> payPending(int id) async {
    try {
      showLoader();
      var res = await ServiceRepo().payPending(id);
      if (res['status'] == false) {
        ErrorToast(res['message']);
        return;
      }
      await getSprayHistory(isLoading: false);
      hideLoader();
      SuccessToast(res['message']);
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  // get pdf
  Future<void> getPdfReceipt(int id) async {
    try {
      showLoader();
      var res = await ServiceRepo().getPdfReceipt(id);
      log('Response: $res');
      hideLoader();
      if (res['status'] == false) {
        ErrorToast(res['message']);
        return;
      }
      // convert res["content_base64"] to file
      final bytes = base64Decode(res["content_base64"]);
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/${res["file_name"]}');
      await file.writeAsBytes(bytes);

      // var xFile = XFile(res);
      Share.shareXFiles([XFile(file.path)], text: 'Transaction Receipt');
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> getSprayHistory({bool isLoading = true}) async {
    try {
      if (isLoading)
      showLoader();
      var res = await ServiceRepo().getSprayHistory();
      sprayHistoryModel = SprayHistoryModel.fromJson(res);
      if (isLoading)
      hideLoader();
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> getColorPaint() async {
    try {
      showLoader();
      var res = await ServiceRepo().getColorPaint();
      colorPaintModel = ColorPaintModel.fromJson(res);
      hideLoader();
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }
}
