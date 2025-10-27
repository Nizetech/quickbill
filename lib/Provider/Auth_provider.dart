import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quick_bills/Provider/account_provider.dart';
import 'package:quick_bills/Ui/Authentication/signIn_screen.dart';
import 'package:quick_bills/bottom_nav.dart';
import 'package:quick_bills/service/auth_repo.dart';
import 'package:quick_bills/utils/loader.dart';
import 'package:quick_bills/utils/toast.dart';

class AuthProvider with ChangeNotifier {
  bool isLoading = false;
  String authToken = '';
  Map<String, dynamic> userData = {};

  void updateAuthToken(String token) {
    authToken = token;
    notifyListeners();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void updateUserData(Map<String, dynamic> data) {
    // Only add keys that don't already exist to prevent duplicates
    data.forEach((key, value) {
      if (!userData.containsKey(key)) {
        userData[key] = value;
      }
    });
    log("userData:====>>> $userData");
    notifyListeners();
  }
  // void createAccount(Map<String, dynamic> data) {
  //   log("data:====>>> $data");
  //   // createAccount(data);
  // //  createAccount({
  // //     "email": _emailController.text.trim(),
  // //     "password": _passwordController.text.trim(),
  // //     "first_name": _firstName.text.trim(),
  // //     "last_name": _lastName.text.trim(),
  // //     'country': selectedCountry,
  // //     'token': box.get(kDeviceToken),
  // //     "referral_code": _referalCode.text.trim(),
  // //     "phone":
  // //         // remove the first zero from the phone number if it starts with 0
  // //         selectedCountry == 'NG' &&
  // //                 _phoneNumberController.text.trim().startsWith('0')
  // //             ? '+$selectedCountryCode${_phoneNumberController.text.trim().substring(1)}'
  // //             : '+$selectedCountryCode${_phoneNumberController.text.trim()}'
  // //   });
  //   notifyListeners();
  // }

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

  Future<void> createAccount() async {
    try {
      log("data:====>>> $userData");
      // return;
      // setLoading(true);
      showLoader();
      AuthRepo().register(userData).then((value) {
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
          if (userData['email'] == 'donnpus@yahoo.com' &&
              userData['password'] == 'ASdflkj123?') {
            Get.offAll(BottomNav());
          } else {
            // Get.to(OtpScreen(
            //   email: userData['email'],
            // ));
            Get.offAll(BottomNav());
            // SuccessToast('An OTP has been sent to your email');
            SuccessToast('Login Successful');
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
              Get.offAll(BottomNav());
            //   Get.to(OtpScreen(
            //       is2Fa: value['login_method'] != null &&
            //           value['login_method'] != 'email',
            //       email: data['email']));
            //   if (value['message'] != null && value['message'] != '') {
            //     SuccessToast(value['message']);
            //   } else {
            //     SuccessToast(value['login_method'] != null &&
            //             value['login_method'] != 'email'
            //         ? "Enter Google Authenticator code"
            //         : 'An OTP has been sent to your email');
            //   }
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
            Get.back();
            // Get.to(OtpScreen(email: email));
          }
          updateAuthToken(value['token']);

          SuccessToast('An OTP has been sent to your email');
      
        }
        notifyListeners();
      });
    } catch (e) {}
  }

  // Future<bool> confirmOtp(Map<String, dynamic> data,
  //     {bool isForgetPass = false,
  //     bool is2fa = false,
  //     String? authToken,
  //     bool isEnable2fa = false,
  //     AccountProvider? account,
  //     DashboardProvider? dashProvider}) async {
  //   try {
  //     showLoader();
  //     AuthRepo()
  //         .verifyOTP(
  //             authToken: authToken,
  //             data,
  //             is2fa: is2fa,
  //             isEnable2fa: isEnable2fa)
  //         .then((value) async {
  //       hideLoader();
  //       if (value.isEmpty) return false;
  //       if (value['status'] == false || value['result'] == false) {
  //         if (value['message'].runtimeType == String) {
  //           ErrorToast(value['message']);
  //         } else {
  //           String message = '';
  //           value['message'].forEach((key, value) {
  //             message += '$value';
  //           });
  //           ErrorToast(message);
  //         }
  //       } else {
  //         if (isForgetPass || isEnable2fa) {
  //           if (isEnable2fa) {
  //             await account!.getUserProfile(isLoading: false);
  //             Get.back();
  //             SuccessToast(value['message']);
  //           }
  //           return true;
  //         } else {
  //           if (dashProvider != null && account != null) {
  //             dashProvider.changeBottomIndex(0);
  //             var data = await AccountRepo().getProfile();
  //             updateAuthToken('');
  //             notifyListeners();
  //             if (data['user'] != null) {
  //               if (data['user']['enable_pin'] != '1' ||
  //                   data['user']['enable_pin'] == 'null' ||
  //                   data['user']['enable_pin'] == null) {
  //                 Get.to(
  //                   SetPinLogin(
  //                     isFromAuth: true,
  //                   ),
  //                 );
  //               } else {
  //                 Get.offAll(BottomNav());
  //               }
  //             }
  //             if (value['message'] != null && value['message'] != '') {
  //               SuccessToast(value['message']);
  //             } else {
  //               SuccessToast('Login Successful');
  //             }
  //           } else {}
  //         }
  //       }
  //     });
  //   } catch (e) {
  //     hideLoader();
  //     ErrorToast(e.toString());
  //     return false;
  //   }
  //   return false;
  // }

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
