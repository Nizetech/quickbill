import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Models/notification_model.dart';
import 'package:jost_pay_wallet/Models/promotion_model.dart';
import 'package:jost_pay_wallet/Models/transactions.dart';
import 'package:jost_pay_wallet/Models/user_model.dart';
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
  dynamic qrcode;
  List<Transaction>? _dashBoardHistory = [];

  List<Transaction>? get dashBoardHistory => _dashBoardHistory;

  void updateDashBoardHistory() {
    _dashBoardHistory = List<Transaction>.from(transactionModel!.data!)
      ..sort((a, b) => b.transDate!.compareTo(a.transDate!));
    notifyListeners();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  // toggle 2Fa
  Future<dynamic> toogle2Fa(int useGoogleAuth) async {
    try {
      showLoader();
      qrcode = await AccountRepo().enableDisable2fa(useGoogleAuth);
      hideLoader();
      notifyListeners();
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
      if (isLoading) 
      showLoader();
      AccountRepo().getProfile().then((value) {
        log('Value: $value');
        if (isLoading) hideLoader();
        if (value['result'] == false) {
          ErrorToast(value['message']);
        } else {
          userModel = UserModel.fromJson(value);
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
