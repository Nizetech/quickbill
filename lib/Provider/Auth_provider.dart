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
      // setLoading(true);
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
      // setLoading(true);
      showLoader();
      final res = await AuthRepo().login(data).then((value) {
        log('Value: $value');
        setLoading(false);
        hideLoader();
        if (value.isNotEmpty) {
          if (value['result'] == false) {
            ErrorToast(value['message']);
            return;
          } else {
            Get.to(OtpScreen(
                is2Fa: value['login_method'] != null &&
                    value['login_method'] != 'email',
                email: data['email']));
            if (value['message'] != null && value['message'] != '') {
              SuccessToast(value['message']);
            } else {
              SuccessToast('An OTP has been sent to your email');
            }
          }
          notifyListeners();
        } else {
          // hideLoader();
        }
      });
      log('Value: $res');
    } catch (e) {
      log('Error: $e');
      setLoading(false);
      ErrorToast(e.toString());
    }
  }

  Future<void> resendOtp(String email, {bool isForgetPass = false}) async {
    try {
      // setLoading(true);
      showLoader();
      AuthRepo().resendOTP(email).then((value) {
        log('Value: $value');
        hideLoader();
        setLoading(false);
        if (value.isEmpty) return;
        if (value['result'] == false) {
          ErrorToast(value['message']);
        } else {
          hideLoader();
          if (isForgetPass) {
            Get.to(OtpScreen(email: email));
          }
          SuccessToast('An OTP has been sent to your email');
        }
        notifyListeners();
      });
    } catch (e) {
      log('Error: $e');
      setLoading(false);
    }
  }

  Future<void> verifyOtp(String email) async {
    try {
      // setLoading(true);
      showLoader();
      AuthRepo().resendOTP(email).then((value) {
        log('Value: $value');
        hideLoader();
        setLoading(false);
        if (value.isEmpty) return;
        if (value['result'] == false) {
          ErrorToast(value['message']);
        } else {
          SuccessToast('An OTP has been sent to your email');
        }
        notifyListeners();
      });
    } catch (e) {
      log('Error: $e');
      setLoading(false);
    }
  }

  Future<void> confirmOtp(Map<String, dynamic> data,
      {bool isForgetPass = false, bool is2fa = false}) async {
    try {
      // setLoading(true);
      showLoader();
      AuthRepo().verifyOTP(data, is2fa: is2fa).then((value) {
        log('Value: $value');
        setLoading(false);
        hideLoader();
        if (value.isEmpty) return;
        if (value['result'] == false) {
          ErrorToast(value['message']);
        } else {
          if (isForgetPass) {
            return;
          } else {
            Get.offAll(BottomNav());
            if (value['message'] != null && value['message'] != '') {
              SuccessToast(value['message']);
            } else {
              SuccessToast('Login Successful');
            }
          }
        }
        notifyListeners();
      });
    } catch (e) {
      log('Error: $e');
      setLoading(false);
      ErrorToast(e.toString());
    }
  }

  Future<void> changePassword(Map<String, dynamic> data) async {
    try {
      // setLoading(true);
      showLoader();
      AuthRepo().changePassword(data).then((value) {
        log('Value: $value');
        setLoading(false);
        hideLoader();
        if (value.isEmpty) return;
        if (value['result'] == false) {
          ErrorToast(value['message']);
        } else {
          hideLoader();
          if (value['message'] != null && value['message'] != '') {
            SuccessToast(value['message']);
          } else {
            SuccessToast('Password Changed Successfully');
          }
        }
        notifyListeners();
      });
    } catch (e) {
      log('Error: $e');
      setLoading(false);
      ErrorToast(e.toString());
    }
  }
}
