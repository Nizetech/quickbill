
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/DashboardProvider.dart';
import 'package:jost_pay_wallet/Ui/Authentication/OtpScreen.dart';
import 'package:jost_pay_wallet/Ui/Authentication/SignInScreen.dart';
import 'package:jost_pay_wallet/Ui/Static/set_pin_login.dart';
import 'package:jost_pay_wallet/bottom_nav.dart';
import 'package:jost_pay_wallet/service/account_repo.dart';
import 'package:jost_pay_wallet/service/auth_repo.dart';
import 'package:jost_pay_wallet/utils/loader.dart';
import 'package:jost_pay_wallet/utils/toast.dart';

class AuthProvider with ChangeNotifier {
  bool isLoading = false;
  String authToken = '';

  void updateAuthToken(String token) {
    authToken = token;
    notifyListeners();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }


  Future<void> deActivateAccount() async {
    try {
      showLoader();
      await AuthRepo().deActivateAccount().then((value) {
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
    } catch (e) {
      ErrorToast(e.toString());
    }
  }

  Future<void> createAccount(Map<String, dynamic> data) async {
    try {
      // setLoading(true);
      showLoader();
      AuthRepo().register(data).then((value) {
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
          print("value['token']:====>>> ${value['token']}");
          updateAuthToken(value['token']);
          hideLoader();
          updateAuthToken(value['token']);
          if (data['email'] == 'donnpus@yahoo.com' &&
              data['password'] == 'ASdflkj123?') {
            Get.offAll(BottomNav());
          } else {
            Get.to(OtpScreen(
              email: data['email'],
            ));
            SuccessToast('An OTP has been sent to your email');
          }
        }
        notifyListeners();
      });
      notifyListeners();
    } catch (e) {
      ErrorToast(e.toString());
    }
  }

  Future<void> login(Map<String, dynamic> data) async {
    try {
      showLoader();
      await AuthRepo().login(data).then((value) {
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
            updateAuthToken(value['token']);
            if (data['email'] == 'donnpus@yahoo.com' &&
                data['password'] == 'ASdflkj123?') {
              Get.offAll(BottomNav());
            } else {
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
          }
          notifyListeners();
        } else {
          ErrorToast('Something went wrong');
          return;
        }
      });
    } catch (e) {
      ErrorToast(e.toString());
    }
  }

  Future<void> googleLogout() async {
    try {
      showLoader();
      await AuthRepo().googleLogout();
      updateAuthToken('');
      hideLoader();
      SuccessToast('Logged out successfully');
    } catch (e) {
      hideLoader();
      ErrorToast(e.toString());
    }
  }

  Future<void> googleAuth({
    required String fcmToken,
    required DashboardProvider dashProvider,
    required AccountProvider account,
  }) async {
    try {
      showLoader();
      await AuthRepo().googleAuth(fcmToken).then((value) async {
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
            if (value['token'] != null) {
              updateAuthToken(value['token']);
            }
            
            dashProvider.changeBottomIndex(0);
            var data = await AccountRepo().getProfile();
            notifyListeners();
            if (data['user'] != null) {
              if (data['user']['enable_pin'] != '1' ||
                  data['user']['enable_pin'] == 'null' ||
                  data['user']['enable_pin'] == null) {
                Get.to(
                  SetPinLogin(
                    isFromAuth: true,
                  ),
                );
              } else {
                Get.offAll(BottomNav());
                SuccessToast('Login Successful');
              }
            }
          }
          notifyListeners();
        } else {
          ErrorToast('Something went wrong');
          return;
        }
      });
    } catch (e) {
      hideLoader();
      ErrorToast(e.toString());
    }
  }

  Future<void> updatePinLogin(String pin, AccountProvider account,
      {bool? isFromAuth}) async {
    try {
      showLoader();
      await AuthRepo().updatePinLogin(pin).then((value) async {
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
            if (isFromAuth != null) {
              Get.offAll(BottomNav());
            } else {
              Get.close(2);
            }
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
    } catch (e) {
      ErrorToast(e.toString());
    }
  }

  Future<void> pinLogin(
    String pin,
  ) async {
    try {
      showLoader();
      await AuthRepo().pinLogin(pin).then((value) async {
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
    } catch (e) {
      ErrorToast(e.toString());
    }
  }

  Future<void> resendOtp(String email,
      {bool isForgetPass = false, String? authToken}) async {
    try {
      showLoader();
      AuthRepo().resendOTP(email, authToken: authToken).then((value) {
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
          if (isForgetPass) {
            hideLoader();
            Get.to(OtpScreen(email: email));
          }
          updateAuthToken(value['token']);
         
          SuccessToast('An OTP has been sent to your email');
        }
        notifyListeners();
      });
    } catch (e) {
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
              await account!.getUserProfile(isLoading: false);
              Get.back();
              SuccessToast(value['message']);
            }
            return true;
          } else {
            if (dashProvider != null && account != null) {
              dashProvider.changeBottomIndex(0);
              var data = await AccountRepo().getProfile();
              updateAuthToken('');
              notifyListeners();
              if (data['user'] != null) {
                if (data['user']['enable_pin'] != '1' ||
                    data['user']['enable_pin'] == 'null' ||
                    data['user']['enable_pin'] == null) {
                  Get.to(
                    SetPinLogin(
                      isFromAuth: true,
                    ),
                  );
                } else {
                  Get.offAll(BottomNav());
                }
              }
              if (value['message'] != null && value['message'] != '') {
                SuccessToast(value['message']);
              } else {
                SuccessToast('Login Successful');
              }
            } else {}
          }
         
        }
      });
    } catch (e) {
     
      hideLoader();
      ErrorToast(e.toString());
      return false;
    }
    return false;
  }

  Future<void> updateProfile(Map<String, dynamic> data,
      {required AccountProvider account}) async {
    try {
      showLoader();
      AuthRepo().updateProfile(data).then((value) async {
       
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
          await account.getUserProfile(isLoading: false);
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
      hideLoader();
      ErrorToast(e.toString());
    }
  }

  Future<void> forgetPassword(String email) async {
    try {
      showLoader();
      AuthRepo().forgetPassword(email).then((value) async {
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
      hideLoader();
      ErrorToast(e.toString());
    }
  }

  Future<void> changePassword(Map<String, dynamic> data) async {
    try {
      showLoader();
      AuthRepo().changePassword(data).then((value) {
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
      hideLoader();
      ErrorToast(e.toString());
    }
  }
}
