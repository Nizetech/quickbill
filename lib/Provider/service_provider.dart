import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Models/cable_merchant.dart';
import 'package:jost_pay_wallet/Models/cable_transactions.dart';
import 'package:jost_pay_wallet/Models/cable_varaitaions.dart';
import 'package:jost_pay_wallet/Models/car_details.dart';
import 'package:jost_pay_wallet/Models/car_listing.dart';
import 'package:jost_pay_wallet/Models/car_transactions.dart';
import 'package:jost_pay_wallet/Models/car_type_model.dart';
import 'package:jost_pay_wallet/Models/card_model.dart';
import 'package:jost_pay_wallet/Models/color_paint_mode.dart';
import 'package:jost_pay_wallet/Models/country_model.dart';
import 'package:jost_pay_wallet/Models/domain_list.dart';
import 'package:jost_pay_wallet/Models/electricity_history.dart';
import 'package:jost_pay_wallet/Models/gift_card_model.dart';
import 'package:jost_pay_wallet/Models/paymentOption.dart';
import 'package:jost_pay_wallet/Models/receipt_model.dart';
import 'package:jost_pay_wallet/Models/repair_details.dart';
import 'package:jost_pay_wallet/Models/repair_transaction.dart';
import 'package:jost_pay_wallet/Models/script_details.dart';
import 'package:jost_pay_wallet/Models/script_model.dart';
import 'package:jost_pay_wallet/Models/script_transactions.dart';
import 'package:jost_pay_wallet/Models/social_section_model.dart';
import 'package:jost_pay_wallet/Models/social_services.dart';
import 'package:jost_pay_wallet/Models/spray_details.dart';
import 'package:jost_pay_wallet/Models/spray_history_model.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Ui/Paint/paint_invoice_screen.dart';
import 'package:jost_pay_wallet/Ui/cable/cable_electricity_success.dart';
import 'package:jost_pay_wallet/Ui/car/buy_car_script_success.dart';
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
  RepairTransactions? repairTransactions;
  RepairDetailsModel? repairDetails;
  DomainListModel? domainListModel;
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
      } else {
        carTypeModel = CarTypeModel.fromJson(res);
        hideLoader();
        notifyListeners();
      } 
    } catch (e) {
      print('Error: $e');
      hideLoader();
      ErrorToast(e.toString());
    }
  }

  Future<void> getDomainList({bool isLoading = true}) async {
    try {
      if (isLoading) showLoader();
      var res = await ServiceRepo().getDomainList();
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
        domainListModel = DomainListModel.fromJson(res);
        hideLoader();
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
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
      } else {
        socialSectionsModel = SocialSectionsModel.fromJson(res);
        hideLoader();
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      ErrorToast(e.toString());
    } 
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
        await account.getUserBalance();
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
        await account.getUserBalance();
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
      } else {
        carListingModel = CarListingModel.fromJson(res);
        hideLoader();
        notifyListeners();
      }
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
      } else {
        scriptModel = ScriptModel.fromJson(res);
        hideLoader();
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      hideLoader();
      ErrorToast(e.toString());
    }
  }

  Future<void> getCarDetails(String id) async {
    try {
      showLoader();
      var res = await ServiceRepo().getCarDetails(id);

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
        carDetailsModel = CarDetailsModel.fromJson(res);
        hideLoader();
        Get.to(CardetailScreen());
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      ErrorToast(e.toString());
    } 
  }

  Future<void> payRepairVehicle(String id,
      {required AccountProvider account}) async {
    try {
      showLoader();
      var res = await ServiceRepo().payRepairVehicle(id);
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
        await getRepairTransactions(isLoading: false, account: account);
        hideLoader();
        SuccessToast(res['message']);
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      hideLoader();
      ErrorToast(e.toString());
    }
  }

  Future<void> getRepairDetails(String id,
      {required VoidCallback callback, bool isLoading = true}) async {
    try {
      if (isLoading) showLoader();
      var res = await ServiceRepo().getRepairDetails(id);

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
        repairDetails = RepairDetailsModel.fromJson(res);
        hideLoader();
        callback();
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      ErrorToast(e.toString());
    } 
  }

  // shareRepairInvoice
  Future<void> shareRepairInvoice(String id) async {
    try {
      showLoader();
      var res = await ServiceRepo().shareRepairInvoice(id);

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
        Share.shareXFiles([XFile(file.path)], text: 'Transaction Receipt');
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      hideLoader();
      ErrorToast(e.toString());
    } 
  }

  Future<void> skipRepair({
    required String repairID,
    required String workId,
    required VoidCallback callback,
    required AccountProvider account,
  }) async {
    try {
      showLoader();
      var res = await ServiceRepo().skipRepair(workId);

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
        await getRepairTransactions(account: account);
        await getRepairDetails(isLoading: false, repairID, callback: callback);
        callback();
        hideLoader();
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');     
      hideLoader();
      ErrorToast(e.toString());
    }
  }

  Future<void> getScriptDetails(String id, VoidCallback callback) async {
    try {
      showLoader();
      var res = await ServiceRepo().getScriptDetails(id);

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
        scriptDetailModel = ScriptDetailModel.fromJson(res);
        hideLoader();
        callback();
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> buyCar(Map<String, dynamic> data) async {
    try {
      showLoader();
      var res = await ServiceRepo().buyCar(data);

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
        hideLoader();
        Get.to(
          BuyCarScriptSuccess(
            isCar: true,
          ),
        );
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> bookInspection(Map<String, dynamic> data) async {
    try {
      showLoader();
      var res = await ServiceRepo().bookInspection(data);

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
        hideLoader();
        Get.back();
        SuccessToast(res['message']);
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      hideLoader();
      ErrorToast(e.toString());
    } 
  }

  Future<void> buyScript(Map<String, dynamic> data) async {
    try {
      showLoader();
      var res = await ServiceRepo().buyScript(data);

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
        hideLoader();
        Get.to(BuyCarScriptSuccess(
          isCar: false,
        ));
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      hideLoader();
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
      } else {
        giftCardsModel = GiftCardsModel.fromJson(res);
        hideLoader();
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      hideLoader();
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
      } else {
        hideLoader();
        Get.to(SocialSuccessScreen(
          isGiftCard: true,
        ));
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      hideLoader();
      ErrorToast(e.toString());
    } 
  }

  Future<void> buyCable(
    Map<String, dynamic> data, {
    bool isShowmax = false,
  }) async {
    try {
      showLoader();
      var res = await ServiceRepo().buyCable(data);
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
      } else if (res['result'] == 'failed') {
        hideLoader();
        ErrorToast(res['message']);
        return;
      } else if (res['result'] == 'pending' || res == {}) {
        hideLoader();
        Get.to(CableElectricitySuccessScreen(
          isCable: true,
          isPending: true,
          isShowmax: isShowmax,
          amount: data['amount'],
        ));
        notifyListeners();
      } else {
        hideLoader();
        Get.to(CableElectricitySuccessScreen(
          isCable: true,
          isShowmax: isShowmax,
          amount: data['amount'], 
          data: res['data'],
        ));
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      hideLoader();
      ErrorToast(e.toString());
    } 
  }

  Future<void> buyElectricity(Map<String, dynamic> data) async {
    try {
      showLoader();
      var res = await ServiceRepo().buyElectricity(data);
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
      } else if (res['result'] == 'failed') {
        hideLoader();
        ErrorToast(res['message']);
        return;
      } else if (res['result'] == 'pending' || res == {}) {
        hideLoader();
        Get.to(CableElectricitySuccessScreen(
          isCable: false,
          isPending: true,
          amount: data['amount'],
        ));
        notifyListeners();
      } else {
        hideLoader();
        Get.to(CableElectricitySuccessScreen(
          isCable: false,
          data: res,
          amount: data['amount'],
        ));
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      hideLoader();
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
      } else {
        hideLoader();
        Get.to(Pay4meSuccessScreen());
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
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
      } else {
        cardModel = CardModel.fromJson(res);
        hideLoader();
        Get.to(CardsOptionScreen());
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      hideLoader();
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
      } else {
        paymentFeeModel = PaymentFeeModel.fromJson(res);
        hideLoader();
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      hideLoader();
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
      } else {
        countryModel = CountryModel.fromJson(res);
        hideLoader();
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      hideLoader();
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
      } else {
        socialServiceModel = SocialServicceModel.fromJson(res);
        hideLoader();
        Get.to(SocialBoost());
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      hideLoader();
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
      } else {
        await ctrl.getTrasactions(isLoading: false);
        hideLoader();
        Get.to(SocialSuccessScreen());
        notifyListeners();
      }
    } catch (e) { 
      print('Error: $e');
      hideLoader();
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
      } else {
        await getSprayHistory(isLoading: false);
        hideLoader();
        Get.close(2);
        SuccessToast(res['message']);
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      hideLoader();
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
      } else {
        sprayDetailsModel = SprayDetailsModel.fromJson(res);
        hideLoader();
        Get.to(PaintInvoiceScreen(
          historyId: id,
        ));
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
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
      } else {
        Get.close(2);
        SuccessToast(res['message']);
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      ErrorToast(e.toString());
    } 
  }

  Future<void> getRepairTransactions(
      {bool isLoading = true, required AccountProvider account}) async {
    try {
      if (isLoading) showLoader();
      var res = await ServiceRepo().getRepairTransactions();

      if (isLoading) hideLoader();
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
        repairTransactions = RepairTransactions.fromJson(res);
        await account.getUserBalance();
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      ErrorToast(e.toString());
    } 
  }

  Future<void> buyRepaires(Map<String, dynamic> data,
      {required VoidCallback callback,
      required AccountProvider account}) async {
    try {
      showLoader();
      var res = await ServiceRepo().buyRepaires(data);

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
        await getRepairTransactions(account: account);
        callback();
        Get.back();
        SuccessToast(res['message']);
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
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
      } else {
        await getSprayHistory(isLoading: false);
        hideLoader();
        SuccessToast(res['message']);
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      hideLoader();
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
      } else {
        sprayHistoryModel = SprayHistoryModel.fromJson(res);
        hideLoader();
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      ErrorToast(e.toString());
    } 
  }

  Future<void> getScriptTransactions(
      {bool isLoading = true, required AccountProvider account}) async {
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
      } else {
        scriptTransactionsModel = ScripTransactions.fromJson(res);
        await account.getUserBalance();
        hideLoader();
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      ErrorToast(e.toString());
    } 
  }

  Future<void> getCarsTransactions(
      {bool isLoading = true, required AccountProvider account}) async {
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
      } else {
        carTransactions = CarTransactions.fromJson(res);
        await account.getUserBalance();
        hideLoader();
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
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
      } else {
        colorPaintModel = ColorPaintModel.fromJson(res);
        hideLoader();
        notifyListeners();
      }
    } catch (e) {
      print('Error: $e');
      ErrorToast(e.toString());
    } 
  }
}
