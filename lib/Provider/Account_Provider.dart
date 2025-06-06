import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Models/airtime_history.dart';
import 'package:jost_pay_wallet/Models/network_provider.dart';
import 'package:jost_pay_wallet/Models/notification_model.dart';
import 'package:jost_pay_wallet/Models/promotion_model.dart';
import 'package:jost_pay_wallet/Models/transactions.dart';
import 'package:jost_pay_wallet/Models/user_model.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/BuyDataSuccess.dart';
import 'package:jost_pay_wallet/service/account_repo.dart';
import 'package:jost_pay_wallet/utils/loader.dart';
import 'package:jost_pay_wallet/utils/toast.dart';

class AccountProvider with ChangeNotifier {
  bool isSuccess = false;
  bool isLoading = false;
  UserModel? userModel;
  num? balance;
  TransactionModel? transactionModel;
  NotificationModel? notificationModel;
  PromoModel? promoModel;
  NetworkProviderModel? networkProviderModel;
  AirtimeHistory? airtimeHistory;

  dynamic qrcode;
  List<Transaction>? _dashBoardHistory = [];
  Map<dynamic, List> _transGroupByData = {};
  String _profileImage = '';

  String get profileImage => _profileImage;
  Map<dynamic, List> get transGroupByData => _transGroupByData;
  List<Transaction>? get dashBoardHistory => _dashBoardHistory;

  void updateDashBoardHistory() {
    _dashBoardHistory = List<Transaction>.from(transactionModel!.data!)
      ..sort((a, b) => b.transDate!.compareTo(a.transDate!));
    notifyListeners();
  }

  void updateTransactionGroupData() {
    List<Transaction>? _dashBoardHistory =
        List<Transaction>.from(transactionModel!.data!);
    _transGroupByData = groupBy(
      _dashBoardHistory,
      (obj) => obj.transDate.toString().substring(0, 10),
    );
    // Sort by date in descending order
    _transGroupByData = Map.fromEntries(
      _transGroupByData.entries.toList()
        ..sort((a, b) => b.key.compareTo(a.key)),
    );
    // Sort each group's transactions by time (descending)
    _transGroupByData.forEach((key, value) {
      value.sort((a, b) => b.transDate.compareTo(a.transDate));
    });
    notifyListeners();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  // toggle 2Fa
  Future<dynamic> toogle2Fa(int useGoogleAuth,
      {bool showMessage = false, AccountProvider? account}) async {
    try {
      showLoader();
      qrcode = await AccountRepo().enableDisable2fa(useGoogleAuth);
      if (useGoogleAuth == 0) {
        await account!.getUserProfile();
      }
      // hideLoader();
      Navigator.pop(Get.context!);
      notifyListeners();
      if (showMessage) {
        SuccessToast('Google Authenticator Disabled Successfully');
      }
      return qrcode;
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
      return null;
    }
  }

  // get User Profile
  Future<void> getUserProfile({bool isLoading = true}) async {
    try {
      if (isLoading) showLoader();
      AccountRepo().getProfile().then((value) {
        log('Value: $value');
        if (isLoading) hideLoader();
        if (value['result'] == false) {
          ErrorToast(value['message']);
        } else {
          userModel = UserModel.fromJson(value);
          if (isLoading) hideLoader();
        }
        notifyListeners();
      });
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  // get User Profile
  Future<void> getAirtimeHistory({bool isLoading = true}) async {
    try {
      if (isLoading) showLoader();
      AccountRepo().getServiceHistory('airtime').then((value) {
        log('Value: $value');
        if (isLoading) hideLoader();
        if (value['result'] == false) {
          ErrorToast(value['message']);
        } else {
          airtimeHistory = AirtimeHistory.fromJson(value);
        }
        notifyListeners();
      });
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  // get Network Provider
  Future<void> getNetworkProviders({bool isLoading = true}) async {
    try {
      if (isLoading) showLoader();
      AccountRepo().getNetworkProviders().then((value) {
        log('Value: $value');
        if (isLoading) hideLoader();
        if (value['result'] == false) {
          ErrorToast(value['message']);
        } else {
          networkProviderModel =
              NetworkProviderModel.fromJson(value['network_providers']);
          if (isLoading) hideLoader();
        }
        notifyListeners();
      });
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  // get Profile Image
  Future<void> getProfileImage({bool isLoading = true}) async {
    try {
      if (isLoading) showLoader();
      AccountRepo().getProfileImage().then((value) {
        log('Value: $value');
        if (isLoading) hideLoader();
        if (value['result'] == false) {
          ErrorToast(value['message']);
        } else {
          _profileImage = value['message'];
          if (isLoading) hideLoader();
        }
        notifyListeners();
      });
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  // update Profile Image
  Future<void> updateProfileImage(File image) async {
    try {
      showLoader();
      AccountRepo().updateProfileImage(image).then((value) async {
        if (value['result'] == false) {
          hideLoader();
          ErrorToast(value['message']);
        } else {
          await getProfileImage(isLoading: false);
          hideLoader();
        }
        notifyListeners();
      });
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  // buy Airtime
  Future<void> buyAirtime(Map<String, dynamic> data) async {
    try {
      showLoader();
      AccountRepo().buyAirtime(data).then((value) async {
        if (value['result'] == false) {
          hideLoader();
          ErrorToast(value['message']);
        } else {
          hideLoader();
          Get.to(BuyDataSuccess(
            isData: false,
            amount: data['amount'],
            phone: data['phone'],
          ));
        }
        notifyListeners();
      });
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  // get Notification
  Future<void> getNotification() async {
    try {
      AccountRepo().getNotification().then((value) {
        log('Value: $value');
        if (value['result'] == false) {
          ErrorToast(value['message']);
        } else {
          notificationModel = NotificationModel.fromJson(value);
        }
        notifyListeners();
      });
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  // get Notification
  Future<void> readNotification() async {
    try {
      AccountRepo().readNotification().then((value) async {
        if (value['result'] != false) {
          await getNotification();
        }
        notifyListeners();
      });
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  // get User Balance
  Future<void> getUserBalance() async {
    try {
      setLoading(true);
      AccountRepo().getBalance().then((value) {
        log('Value: $value');
        setLoading(false);
        if (value['result'] == false) {
          ErrorToast(value['message']);
        } else {
          setLoading(false);
          balance = num.parse(value['balance'].toString());
        }
        notifyListeners();
      });
      setLoading(false);
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      setLoading(false);
      ErrorToast(e.toString());
    }
  }

  // get Transaction History
  Future<void> getTrasactions({bool isLoading = true}) async {
    try {
      if (isLoading) showLoader();
      AccountRepo().getTransactions().then((value) {
        // log('Value: $value');
        if (value['result'] == false) {
          if (isLoading) hideLoader();
          ErrorToast(value['message']);
        } else {
          if (isLoading) hideLoader();
          transactionModel = TransactionModel.fromJson(value);
          updateDashBoardHistory();
          updateTransactionGroupData();
        }
        notifyListeners();
      });
    } catch (e) {
      log('Error: $e');
      // setLoading(false);
      ErrorToast(e.toString());
    }
  }

  // get Refferal History
  Future<void> getReferrals({bool isLoading = true}) async {
    try {
      if (isLoading) showLoader();
      AccountRepo().getReferral().then((value) {
        log('Value: $value');
        if (value['result'] == false) {
          if (isLoading) hideLoader();
          ErrorToast(value['message']);
        } else {
          if (isLoading) hideLoader();
          //! Change this
          transactionModel = TransactionModel.fromJson(value);
        }
        notifyListeners();
      });
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  // get Promotion
  Future<void> getPromotion({bool isLoading = true}) async {
    try {
      if (isLoading) showLoader();
      AccountRepo().getPromotion().then((value) {
        log('Value: $value');
        if (value['result'] == false) {
          if (isLoading) hideLoader();
          ErrorToast(value['message']);
        } else {
          if (isLoading) hideLoader();
          promoModel = PromoModel.fromJson(value);
        }
        notifyListeners();
      });
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }
}
