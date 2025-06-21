import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Models/car_details.dart';
import 'package:jost_pay_wallet/Models/car_listing.dart';
import 'package:jost_pay_wallet/Models/car_transactions.dart';
import 'package:jost_pay_wallet/Models/car_type_model.dart';
import 'package:jost_pay_wallet/Models/card_model.dart';
import 'package:jost_pay_wallet/Models/color_paint_mode.dart';
import 'package:jost_pay_wallet/Models/country_model.dart';
import 'package:jost_pay_wallet/Models/gift_card_model.dart';
import 'package:jost_pay_wallet/Models/paymentOption.dart';
import 'package:jost_pay_wallet/Models/script_details.dart';
import 'package:jost_pay_wallet/Models/script_model.dart';
import 'package:jost_pay_wallet/Models/script_transactions.dart';
import 'package:jost_pay_wallet/Models/social_section_model.dart';
import 'package:jost_pay_wallet/Models/social_services.dart';
import 'package:jost_pay_wallet/Models/spray_details.dart';
import 'package:jost_pay_wallet/Models/spray_history_model.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Ui/Paint/paint_invoice_screen.dart';
import 'package:jost_pay_wallet/Ui/car/buy_car_success.dart';
import 'package:jost_pay_wallet/Ui/car/cardetail_screen.dart';
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
  CarListingModel? carListingModel;
  CarDetailsModel? carDetailsModel;
  ScriptModel? scriptModel;
  ScriptDetailModel? scriptDetailModel;
  ScripTransactions? scriptTransactionsModel;
  CarTransactions? carTransactions;

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
      }
      socialSectionsModel = SocialSectionsModel.fromJson(res);
      if (isLoading) hideLoader();
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> getCarListing({bool isLoading = true}) async {
    try {
      if (isLoading) showLoader();
      var res = await ServiceRepo().getCarListing();
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
      }
      carListingModel = CarListingModel.fromJson(res);
      if (isLoading) hideLoader();
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> getScripts({bool isLoading = true}) async {
    try {
      if (isLoading) showLoader();
      var res = await ServiceRepo().getScript();
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
      }
      scriptModel = ScriptModel.fromJson(res);
      if (isLoading) hideLoader();
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> getCarDetails(String id) async {
    try {
      showLoader();
      var res = await ServiceRepo().getCarDetails(id);
      log("res: $res");
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
      }
      carDetailsModel = CarDetailsModel.fromJson(res);
      hideLoader();
      Get.to(CardetailScreen());
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> getScriptDetails(String id, VoidCallback callback) async {
    try {
      showLoader();
      var res = await ServiceRepo().getScriptDetails(id);
      log("res: $res");
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
      }
      scriptDetailModel = ScriptDetailModel.fromJson(res);
      hideLoader();
      callback();
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> buyCar(Map<String, dynamic> data) async {
    try {
      showLoader();
      var res = await ServiceRepo().buyCar(data);
      log("res: $res");
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
      }
      hideLoader();
      Get.to(BuyCarSuccess());
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> bookInspection(Map<String, dynamic> data) async {
    try {
      showLoader();
      var res = await ServiceRepo().bookInspection(data);
      log("res: $res");
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
      }
      hideLoader();
      Get.back();
      SuccessToast(res['message']);
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> buyScript(String id) async {
    try {
      showLoader();
      var res = await ServiceRepo().buyScript(id);
      log("res: $res");
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
      }
      hideLoader();
      Get.to(BuyCarSuccess());
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
      }
      sprayHistoryModel = SprayHistoryModel.fromJson(res);
      if (isLoading) hideLoader();
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> getScriptTransactions({bool isLoading = true}) async {
    try {
      if (isLoading) showLoader();

      var res = await ServiceRepo().getScriptTransactions();
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

      }
      log('Response: $res');
      scriptTransactionsModel = ScripTransactions.fromJson(res);
      if (isLoading) hideLoader();
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }
  Future<void> getCarsTransactions({bool isLoading = true}) async {
    try {
      if (isLoading) showLoader();

      var res = await ServiceRepo().getCarsTransactions();
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
      }
      carTransactions = CarTransactions.fromJson(res);
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
      }
      colorPaintModel = ColorPaintModel.fromJson(res);
      hideLoader();
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }
}
