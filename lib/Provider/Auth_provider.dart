import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/DashboardProvider.dart';
import 'package:jost_pay_wallet/Ui/Authentication/OtpScreen.dart';
import 'package:jost_pay_wallet/Ui/Authentication/SignInScreen.dart';
import 'package:jost_pay_wallet/bottom_nav.dart';
import 'package:jost_pay_wallet/service/auth_repo.dart';
import 'package:jost_pay_wallet/utils/loader.dart';
import 'package:jost_pay_wallet/utils/toast.dart';

class AuthProvider with ChangeNotifier {
  bool isLoading = false;
  String authToken = '';

  void updateAuthToken(String token) {
    authToken = token;
    log("State Token===> $token");
    notifyListeners();
  }

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
        if (value['status'] == false || value['result'] == false) {
          hideLoader();
          if (value['message'].runtimeType == String) {
            ErrorToast(value['message']);
          } else {
            String message = '';
            value['message'].forEach((key, value) {
              message += '$value';
            });
            ErrorToast(message);
          }
        } else {
          updateAuthToken(value['token']);
          hideLoader();
          Get.to(OtpScreen(
            email: data['email'],
          ));
          SuccessToast('An OTP has been sent to your email');
        }
        notifyListeners();
      });
      // setLoading(false);
      notifyListeners();
    } catch (e) {
      log('Error: $e');
      // setLoading(false);
      ErrorToast(e.toString());
    }
  }

  Future<void> login(Map<String, dynamic> data) async {
    try {
      // setLoading(true);
      showLoader();
      final res = await AuthRepo().login(data).then((value) {
        log('Value: $value');
        // setLoading(false);
        hideLoader();
        if (value.isNotEmpty) {
          if (value['status'] == false || value['result'] == false) {
            if (value['message'].runtimeType == String) {
              ErrorToast(value['message']);
            } else {
              String message = '';
              value['message'].forEach((key, value) {
                message += '$value';
              });
              ErrorToast(message);
            }
            return;
          } else {
            log('Login Value===>: $value');
            updateAuthToken(value['token']);
            Get.to(OtpScreen(
                is2Fa: value['login_method'] != null &&
                    value['login_method'] != 'email',
                email: data['email']));
            if (value['message'] != null && value['message'] != '') {
              SuccessToast(value['message']);
            } else {
              SuccessToast(value['login_method'] != null &&
                      value['login_method'] != 'email'
                  ? "Enter Google Authenticator code"
                  : 'An OTP has been sent to your email');
            }
          }
          notifyListeners();
        } else {
          ErrorToast('Something went wrong');
          return;
        }
      });
      log('Value: $res');
    } catch (e) {
      log('Error: $e');
      // setLoading(false);
      ErrorToast(e.toString());
    }
  }

  Future<void> deActivateAccount() async {
    try {
      showLoader();
      final res = await AuthRepo().deActivateAccount().then((value) {
        log('Value: $value');
        hideLoader();
        if (value.isNotEmpty) {
          if (value['status'] == false || value['result'] == false) {
            if (value['message'].runtimeType == String) {
              ErrorToast(value['message']);
            } else {
              String message = '';
              value['message'].forEach((key, value) {
                message += '$value';
              });
              ErrorToast(message);
            }
            return;
          } else {
            Get.offAll(SignInScreen());
            if (value['message'] != null && value['message'] != '') {
              SuccessToast(value['message']);
            }
          }
          notifyListeners();
        } else {
          ErrorToast('Something went wrong');
          return;
        }
      });
      log('Value: $res');
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> updatePinLogin(String pin, AccountProvider account) async {
    try {
      showLoader();
      final res = await AuthRepo().updatePinLogin(pin).then((value)async {
        log('Value: $value');
        hideLoader();
        if (value.isNotEmpty) {
          if (value['status'] == false || value['result'] == false) {
            if (value['message'].runtimeType == String) {
              ErrorToast(value['message']);
            } else {
              String message = '';
              value['message'].forEach((key, value) {
                message += '$value';
              });
              ErrorToast(message);
            }
            return;
          } else {
            await account.getUserProfile();
            Get.close(2);
            if (value['message'] != null && value['message'] != '') {
              SuccessToast(value['message']);
            }
          }
          notifyListeners();
        } else {
          ErrorToast('Something went wrong');
          return;
        }
      });
      log('Value: $res');
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> pinLogin(String pin,) async {
    try {
      showLoader();
      final res = await AuthRepo().pinLogin(pin).then((value)async {
        log('Value: $value');
        hideLoader();
        if (value.isNotEmpty) {
          if (value['status'] == false || value['result'] == false) {
            if (value['message'].runtimeType == String) {
              ErrorToast(value['message']);
            } else {
              String message = '';
              value['message'].forEach((key, value) {
                message += '$value';
              });
              ErrorToast(message);
            }
            return;
          } else {
             Get.offAll(BottomNav());
            if (value['message'] != null && value['message'] != '') {
              SuccessToast(value['message']);
            }
          }
          notifyListeners();
        } else {
          ErrorToast('Something went wrong');
          return;
        }
      });
      log('Value: $res');
    } catch (e) {
      log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> resendOtp(String email,
      {bool isForgetPass = false, String? authToken}) async {
    try {
      // setLoading(true);
      showLoader();
      AuthRepo().resendOTP(email, authToken: authToken).then((value) {
        log('Value: $value');
        hideLoader();
        // setLoading(false);
        if (value.isEmpty) return;
        if (value['status'] == false || value['result'] == false) {
          if (value['message'].runtimeType == String) {
            ErrorToast(value['message']);
          } else {
            String message = '';
            value['message'].forEach((key, value) {
              message += '$value';
            });
            ErrorToast(message);
          }
        } else {
          if (isForgetPass) {
            hideLoader();
            Get.to(OtpScreen(email: email));
          }
          updateAuthToken(value['token']);
          log("Token===> ${value['token']}");
          // else{
          //     Get.to(OtpScreen(
          //       authToken: value['token'],
          //       email: email,
          //       ),
          //       );
          // }
          SuccessToast('An OTP has been sent to your email');
        }
        notifyListeners();
      });
    } catch (e) {
      log('Error: $e');
      // setLoading(false);
    }
  }

  Future<bool> confirmOtp(Map<String, dynamic> data,
      {bool isForgetPass = false,
      bool is2fa = false,
      String? authToken,
      bool isEnable2fa = false,
      AccountProvider? account,
      DashboardProvider? dashProvider}) async {
    try {
      showLoader();
      AuthRepo()
          .verifyOTP(
              authToken: authToken,
              data,
              is2fa: is2fa,
              isEnable2fa: isEnable2fa)
          .then((value) async {
        log('Value: $value');
        // setLoading(false);
        hideLoader();
        if (value.isEmpty) return false;
        if (value['status'] == false || value['result'] == false) {
          if (value['message'].runtimeType == String) {
            ErrorToast(value['message']);
          } else {
            String message = '';
            value['message'].forEach((key, value) {
              message += '$value';
            });
            ErrorToast(message);
          }
        } else {
          if (isForgetPass || isEnable2fa) {
            if (isEnable2fa) {
              await account!.getUserProfile();
              Get.back();
              SuccessToast(value['message']);
            }
            return true;
          } else {
            if (dashProvider != null && account != null) {
              dashProvider.changeBottomIndex(0);
              await account.getUserProfile();
            }
            updateAuthToken('');
            notifyListeners();
            Get.offAll(BottomNav());
            if (value['message'] != null && value['message'] != '') {
              SuccessToast(value['message']);
            } else {
              SuccessToast('Login Successful');
            }
          }
        }
      });
    } catch (e) {
      log('Error: $e');
      // setLoading(false);
      ErrorToast(e.toString());
      return false;
    }
    return false;
  }

  Future<void> updateProfile(Map<String, dynamic> data,
      {required AccountProvider account}) async {
    try {
      // setLoading(true);
      showLoader();
      AuthRepo().updateProfile(data).then((value) async {
        log('Value: $value');
        // setLoading(false);
        hideLoader();
        if (value.isEmpty) return;
        if (value['status'] == false || value['result'] == false) {
          if (value['message'].runtimeType == String) {
            ErrorToast(value['message']);
          } else {
            String message = '';
            value['message'].forEach((key, value) {
              message += '$value';
            });
            ErrorToast(message);
          }
        } else {
          await account.getUserProfile();
          hideLoader();
          Get.back();
          if (value['message'] != null && value['message'] != '') {
            SuccessToast(value['message']);
          } else {
            SuccessToast('Profile Updated Successfully');
          }
        }
        notifyListeners();
      });
    } catch (e) {
      log('Error: $e');
      // setLoading(false);
      ErrorToast(e.toString());
    }
  }

  Future<void> forgetPassword(String email) async {
    try {
      // setLoading(true);
      showLoader();
      AuthRepo().forgetPassword(email).then((value) async {
        log('Value: $value');
        // setLoading(false);
        hideLoader();
        if (value.isEmpty) return;
        if (value['status'] == false || value['result'] == false) {
          if (value['message'].runtimeType == String) {
            ErrorToast(value['message']);
          } else {
            String message = '';
            value['message'].forEach((key, value) {
              message += '$value';
            });
            ErrorToast(message);
          }
        } else {
          Get.back();
          if (value['message'] != null && value['message'] != '') {
            SuccessToast(value['message']);
          } else {
            SuccessToast('Password reset link sent successfully');
          }
        }
      });
    } catch (e) {
      log('Error: $e');
      // setLoading(false);
      ErrorToast(e.toString());
    }
  }

  Future<void> changePassword(Map<String, dynamic> data) async {
    try {
      // setLoading(true);
      showLoader();
      AuthRepo().changePassword(data).then((value) {
        log('Value: $value');
        // setLoading(false);
        hideLoader();
        if (value.isEmpty) return;
        if (value['status'] == false || value['result'] == false) {
          if (value['message'].runtimeType == String) {
            ErrorToast(value['message']);
          } else {
            String message = '';
            value['message'].forEach((key, value) {
              message += '$value';
            });
            ErrorToast(message);
          }
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
      // setLoading(false);
      ErrorToast(e.toString());
    }
  }
}
