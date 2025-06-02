import 'dart:developer';

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
      log('Response: $res');

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
      log('Response: $res');
      sprayDetailsModel = SprayDetailsModel.fromJson(res);
      hideLoader();
      Get.to(const PaintInvoiceScreen());
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
      log('Response: $res');

      hideLoader();
      Get.close(2);
      SuccessToast(res['message']);
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  // get pdf
  Future<void> getPdfReceipt(String id) async {
    try {
      showLoader();
      var res = await ServiceRepo().getPdfReceipt(id);
      log('Response: $res');
      hideLoader();
      var xFile = XFile(res);
      Share.shareXFiles([xFile], text: 'Transaction Receipt');
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> getSprayHistory() async {
    try {
      showLoader();
      var res = await ServiceRepo().getSprayHistory();
      sprayHistoryModel = SprayHistoryModel.fromJson(res);
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
