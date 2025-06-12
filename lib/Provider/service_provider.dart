import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Models/car_type_model.dart';
import 'package:jost_pay_wallet/Models/card_model.dart';
import 'package:jost_pay_wallet/Models/color_paint_mode.dart';
import 'package:jost_pay_wallet/Models/country_model.dart';
import 'package:jost_pay_wallet/Models/gift_card_model.dart';
import 'package:jost_pay_wallet/Models/paymentOption.dart';
import 'package:jost_pay_wallet/Models/social_section_model.dart';
import 'package:jost_pay_wallet/Models/social_services.dart';
import 'package:jost_pay_wallet/Models/spray_details.dart';
import 'package:jost_pay_wallet/Models/spray_history_model.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Ui/Paint/paint_invoice_screen.dart';
import 'package:jost_pay_wallet/Ui/giftCard/cards_option_screen.dart';
import 'package:jost_pay_wallet/Ui/pay4me/pay4me_success_screen.dart';
import 'package:jost_pay_wallet/Ui/promotions/social_boost.dart';
import 'package:jost_pay_wallet/Ui/promotions/social_success_screen.dart';
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
  SocialSectionsModel? socialSectionsModel;
  SocialServicceModel? socialServiceModel;
  CountryModel? countryModel;
  GiftCardsModel? giftCardsModel;
  CardModel? cardModel;
  PaymentFeeModel? paymentFeeModel;

  String base64Image = '';

  void updateImage(String image) {
    base64Image = image;
    notifyListeners();
  }

  void clearCardModel() {
    giftCardsModel = null;
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

  Future<void> getSocialSections({bool isLoading = true}) async {
    try {
      if (isLoading) showLoader();
      var res = await ServiceRepo().getSocialSectionss();
      if (res['status'] == false) {
        ErrorToast(res['message']);
        if (isLoading) hideLoader();
        return;
      }
      socialSectionsModel = SocialSectionsModel.fromJson(res);
      if (isLoading) hideLoader();
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> getGiftCard(String code) async {
    try {
      showLoader();
      var res = await ServiceRepo().getGiftCard(code);
      if (res['status'] == false) {
        ErrorToast(res['message']);
        hideLoader();
        return;
      }
      giftCardsModel = GiftCardsModel.fromJson(res);
      hideLoader();
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> buyGiftCard(Map<String, dynamic> data) async {
    try {
      showLoader();
      var res = await ServiceRepo().buyGiftCard(data);
      if (res['status'] == false) {
        ErrorToast(res['message']);
        hideLoader();
        return;
      }
      hideLoader();
      Get.to(SocialSuccessScreen(
        isGiftCard: true,
      ));
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }
  

  Future<void> buyPay4Me(Map<String, dynamic> data) async {
    try {
      showLoader();
      var res = await ServiceRepo().buyPay4Me(data);
      if (res['status'] == false) {
        ErrorToast(res['message']);
        hideLoader();
        return;
      }
      hideLoader();
      Get.to(Pay4meSuccessScreen());
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> getCard(String cardId) async {
    try {
      showLoader();
      var res = await ServiceRepo().getCard(cardId);
      if (res['status'] == false) {
        ErrorToast(res['message']);
        hideLoader();
        return;
      }
      cardModel = CardModel.fromJson(res);
      hideLoader();
      Get.to(CardsOptionScreen());
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> getPayRate() async {
    try {
      showLoader();
      var res = await ServiceRepo().getPayRate();
      if (res['status'] == false) {
        ErrorToast(res['message']);
        hideLoader();
        return;
      }
      paymentFeeModel = PaymentFeeModel.fromJson(res);
      hideLoader();
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> getCardCountries({bool isLoading = true}) async {
    try {
      if (isLoading) showLoader();
      var res = await ServiceRepo().getCardCountries();
      if (res['status'] == false) {
        ErrorToast(res['message']);
        if (isLoading) hideLoader();
        return;
      }
      countryModel = CountryModel.fromJson(res);
      if (isLoading) hideLoader();
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> getSocialServices(int id) async {
    try {
      showLoader();
      var res = await ServiceRepo().getSocialServices(id);
      if (res['status'] == false) {
        ErrorToast(res['message']);
        hideLoader();
        return;
      }
      socialServiceModel = SocialServicceModel.fromJson(res);
      hideLoader();
      Get.to(SocialBoost());
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> buySocialBoost(Map<String, dynamic> data,
      {required AccountProvider ctrl}) async {
    try {
      showLoader();
      var res = await ServiceRepo().buySocialBoost(data);
      if (res['status'] == false) {
        ErrorToast(res['message']);
        hideLoader();
        return;
      }
      await ctrl.getTrasactions(isLoading: false);
      hideLoader();
      Get.to(SocialSuccessScreen());
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
      if (isLoading) showLoader();
      var res = await ServiceRepo().getSprayHistory();
      sprayHistoryModel = SprayHistoryModel.fromJson(res);
      if (isLoading) hideLoader();
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
