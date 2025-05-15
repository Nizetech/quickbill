import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Ui/Authentication/OtpScreen.dart';
import 'package:jost_pay_wallet/bottom_nav.dart';
import 'package:jost_pay_wallet/service/auth_repo.dart';
import 'package:jost_pay_wallet/utils/loader.dart';
import 'package:jost_pay_wallet/utils/toast.dart';

class AuthProvider with ChangeNotifier {
  bool isLoading = false;
  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> createAccount(Map<String, dynamic> data) async {
    try {
      setLoading(true);
      showLoader();
      AuthRepo().register(data).then((value) {
        log('Value: $value');
        setLoading(false);
        if (value['result'] == false) {
          hideLoader();
          ErrorToast(value['message']);
        } else {
          hideLoader();
          Get.to(OtpScreen(
            email: data['email'],
          ));
          SuccessToast('An OTP has been sent to your email');
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

  Future<void> login(Map<String, dynamic> data) async {
    try {
      setLoading(true);
      showLoader();
      AuthRepo().login(data).then((value) {
        log('Value: $value');
        setLoading(false);
        if (value['result'] == false) {
          hideLoader();
          ErrorToast(value['message']);
        } else {
          hideLoader();
          Get.offAll(BottomNav());
          if (value['message'] != null) {
            SuccessToast(value['message']);
          } else {
            SuccessToast('Login Successful');
          }
        }
        notifyListeners();
      });
      hideLoader();
      setLoading(false);
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      setLoading(false);
      ErrorToast(e.toString());
    }
  }
}
