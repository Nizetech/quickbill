
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jost_pay_wallet/Models/airtime_history.dart';
import 'package:jost_pay_wallet/Models/banks_model.dart';
import 'package:jost_pay_wallet/Models/data_history_model.dart';
import 'package:jost_pay_wallet/Models/data_plans_model.dart';
import 'package:jost_pay_wallet/Models/deposit_history_model.dart';
import 'package:jost_pay_wallet/Models/giftcard_history.dart';
import 'package:jost_pay_wallet/Models/invoice_model.dart';
import 'package:jost_pay_wallet/Models/network_provider.dart';
import 'package:jost_pay_wallet/Models/notification_model.dart';
import 'package:jost_pay_wallet/Models/pay_for_me_history.dart';
import 'package:jost_pay_wallet/Models/promotion_model.dart';
import 'package:jost_pay_wallet/Models/referral_count.dart';
import 'package:jost_pay_wallet/Models/social_boost_history_model.dart';
import 'package:jost_pay_wallet/Models/transactions.dart';
import 'package:jost_pay_wallet/Models/user_model.dart';
import 'package:jost_pay_wallet/Ui/Authentication/SignInScreen.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/BuyDataSuccess.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/pending_purchase.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Wallet/payment_details.dart';
import 'package:jost_pay_wallet/constants/constants.dart';
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
  GiftCardHistoryModel? giftCardHistoryModel;
  DataPlansModel? dataPlansModel;
  DataHistoryModel? dataHistoryModel;
  SocialBoostHistoryModel? socialBoostHistoryModel;
  ReferralCountModel? referralCountModel;
  List<BanksModel> banksModel = [];
  InvoiceModel? invoiceModel;
  DepositHistoryModel? depositHistoryModel;

  dynamic qrcode;
  TransactionModel? _dashBoardHistory;
  List<PayForMeHistoryModel> pay4meHistory = [];
  Map<dynamic, List> _transGroupByData = {};
  String _profileImage = '';
  final box = Hive.box(kAppName);
  TransactionModel? get dashBoardHistory => _dashBoardHistory;
  String get profileImage => _profileImage;
  Map<dynamic, List> get transGroupByData => _transGroupByData;

  void setDataPlanModelToNull() {
    dataPlansModel = null;
    notifyListeners();
  }

  void updateDashBoardHistory() {
    _dashBoardHistory = TransactionModel.fromJson(transactionModel!.toJson());
    // ..sort((a, b) => b.transDate!.compareTo(a.transDate!));
    // Sort the transactions by latest time
    _dashBoardHistory?.data
        ?.sort((a, b) => b.transDate!.compareTo(a.transDate!));
    notifyListeners();
  }

  void updateTransactionGroupData() {
    TransactionModel transactionHistory =
        TransactionModel.fromJson(transactionModel!.toJson());
    _transGroupByData = groupBy(
      transactionHistory.data!,
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

  void setUserModel(Map<String, dynamic> data) {
    userModel = UserModel.fromJson(data);
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
      // log('Error: $e');
      ErrorToast(e.toString());
      return null;
    }
  }

  // get User Profile
  Future<Map<String, dynamic>> getUserProfile({bool isLoading = true}) async {
    try {
      if (isLoading) showLoader();
      Map<String, dynamic> res = {};
      await AccountRepo().getProfile().then((value) {
        res = value;
        if (isLoading) hideLoader();
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
          userModel = UserModel.fromJson(value);
          box.put(isPinEnabled, userModel?.user?.enabledPin);
          if (isLoading) hideLoader();
        }
        notifyListeners();
      });
      log('res UserProfile:==> ${res}');
      return res;
    } catch (e) {
      // log('Error: $e');
      ErrorToast(e.toString());
      return {};
    }
  }

  Future<void> getDepositInvoice(
      {required String bankID, required String amount}) async {
    try {
      showLoader();
      AccountRepo().getDepositInvoice(bankID).then((value) {
        //
        hideLoader();
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
          invoiceModel = InvoiceModel.fromJson(value);
          hideLoader();
          Get.to(
            PaymentPayment(
              amount: amount,
              bankId: bankID,
            ),
          );
        }
        notifyListeners();
      });
    } catch (e) {
      // log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  // get User Profile
  Future<void> getAirtimeHistory({
    bool isLoading = true,
    Map<String, dynamic>? filter,
  }) async {
    try {
      if (isLoading) showLoader();
      AccountRepo()
          .getServiceHistory('airtime', filter: filter)
          .then((value) async {
       
        if (isLoading) hideLoader();
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
          airtimeHistory = AirtimeHistory.fromJson(value);
          await getUserBalance();
        }
        notifyListeners();
      });
    } catch (e) {
      // log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  // get data History
  Future<void> getDataHistory({
    bool isLoading = true,
    Map<String, dynamic>? filter,
  }) async {
    try {
      if (isLoading) showLoader();
      AccountRepo()
          .getServiceHistory('data', filter: filter)
          .then((value) async {
       
        if (isLoading) hideLoader();
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
          dataHistoryModel = DataHistoryModel.fromJson(value);
          await getUserBalance();
        }
        notifyListeners();
      });
    } catch (e) {
      // log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  // get Airtime History
  Future<void> getPay4MeHistory({
    bool isLoading = true,
    Map<String, dynamic>? filter,
  }) async {
    try {
      if (isLoading) showLoader();
      AccountRepo()
          .getServiceHistory('pay4me', filter: filter)
          .then((value) async {
       
        if (isLoading) hideLoader();
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
          pay4meHistory = List<PayForMeHistoryModel>.from(
              value['data'].map((x) => PayForMeHistoryModel.fromJson(x)));
          await getUserBalance();
        }
        notifyListeners();
      });
    } catch (e) {
      // log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  // get User Profile
  Future<void> getGiftCradHistory({
    bool isLoading = true,
    Map<String, dynamic>? filter,
  }) async {
    try {
      if (isLoading) showLoader();
      AccountRepo()
          .getServiceHistory('giftcard', filter: filter)
          .then((value) async {
       
        if (isLoading) hideLoader();
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
          giftCardHistoryModel = GiftCardHistoryModel.fromJson(value);
          await getUserBalance();
        }
        notifyListeners();
      });
    } catch (e) {
      // log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  // get User Profile
  Future<void> getDepositHistory({bool isLoading = true}) async {
    try {
      if (isLoading) showLoader();
      AccountRepo().getDepositHistory().then((value) async {
       
        if (isLoading) hideLoader();
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
          depositHistoryModel = DepositHistoryModel.fromJson(value);
        }
        notifyListeners();
      });
    } catch (e) {
      // log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> createDeposit(Map<String, dynamic> data) async {
    try {
      showLoader();
      AccountRepo().createDeposit(data).then((value) async {
        hideLoader();
       
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
          Get.close(3);
          SuccessToast(value['message']);
        }
        notifyListeners();
      });
    } catch (e) {
      // log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> getSociaBoostHistory({
    bool isLoading = true,
    Map<String, dynamic>? filter,
  }) async {
    try {
      if (isLoading) showLoader();
      AccountRepo()
          .getServiceHistory('social', filter: filter)
          .then((value) async {
       
        if (isLoading) hideLoader();
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
          socialBoostHistoryModel = SocialBoostHistoryModel.fromJson(value);
          await getUserBalance();
        }
        notifyListeners();
      });
    } catch (e) {
      // log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  Future<void> getBanks({bool isLoading = true}) async {
    try {
      if (isLoading) showLoader();
      AccountRepo().getBanks().then((value) async {
       
        if (isLoading) hideLoader();
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
          banksModel = List<BanksModel>.from(value['data']['banks'].map(
            (x) => BanksModel.fromJson(x),
          ));
        }
        notifyListeners();
      });
    } catch (e) {
      // log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  // get Network Provider
  Future<void> getNetworkProviders(
      {bool isLoading = true, VoidCallback? callback}) async {
    try {
      if (isLoading) showLoader();
      AccountRepo().getNetworkProviders().then((value) {
       
        if (isLoading) hideLoader();
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
          networkProviderModel =
              NetworkProviderModel.fromJson(value['network_providers']);
          if (callback != null) {
            callback();
          }
        }
        notifyListeners();
      });
    } catch (e) {
      // log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  // get Profile Image
  Future<void> getProfileImage({bool isLoading = true}) async {
    try {
      if (isLoading) showLoader();
      AccountRepo().getProfileImage().then((value) {
       
        if (isLoading) hideLoader();
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
          _profileImage = value['message'];
          if (isLoading) hideLoader();
        }
        notifyListeners();
      });
    } catch (e) {
      // log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  // update Profile Image
  Future<void> updateProfileImage(String image) async {
    try {
      showLoader();
      AccountRepo().updateProfileImage(image).then((value) async {
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
          await getProfileImage(isLoading: false);
          hideLoader();
        }
        notifyListeners();
      });
    } catch (e) {
      // log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  // buy Airtime
  Future<void> buyAirtime(Map<String, dynamic> data) async {
    try {
      showLoader();
      AccountRepo().buyAirtime(data).then((value) async {
        hideLoader();
        if (value['result'] == null || value['result'] == false) {
          if (value['message'].toString().toLowerCase().contains('fail')) {
            Get.to(PendingFailedPurchase(
              isData: true,
              isFailed: true,
            ));
          } 
          // else {
          //   Get.to(InvalidPurchase(
          //     isData: false,
          //   ));
          // }
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
        
          if (value['message'].toString().toLowerCase().contains('pending')) {
            Get.to(PendingFailedPurchase(
              isData: true,
            ));
          } else if (value['message']
              .toString()
              .toLowerCase()
              .contains('failed')) {
            Get.to(PendingFailedPurchase(
              isData: true,
              isFailed: true,
            ));
          } else {
            Get.to(BuyDataSuccess(
              isData: false,
              amount: data['amount'],
              phone: data['phone'],
            ));
          }
        }

        notifyListeners();
      });
    } catch (e) {
      // log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  // buy Data
  Future<void> buyData(Map<String, dynamic> data,
      {required String amount, required String plan}) async {
    try {
      showLoader();
      AccountRepo().buyData(data).then((value) async {
        hideLoader();
        if (value['result'] == null || value['result'] == false) {
          if (value['message'].toString().toLowerCase().contains('failed')) {
            Get.to(PendingFailedPurchase(
              isData: true,
              isFailed: true,
            ));
          }
            if (value['message'].runtimeType == String) {
            ErrorToast(value['message']);
          } else {
            String message = '';
            value['message'].forEach((key, value) {
              message += '$value';
            });
            ErrorToast(message);
          }
          //  else {
          //   Get.to(InvalidPurchase(
          //     isData: true,
          //   ));
          // }
        } else {
          if (value['result'] == true &&
              value['message'].toString().toLowerCase().contains('pending')) {
            Get.to(PendingFailedPurchase(
              isData: true,
              plan: plan,
              phone: data['phone'],
              amount: amount,
              
            ));
          } else if (value['result'] == true &&
              value['message'].toString().toLowerCase().contains('fail')) {
            Get.to(PendingFailedPurchase(
              isData: true,
              isFailed: true,
            ));
          } else {
            Get.to(BuyDataSuccess(
              isData: true,
              amount: amount,
              phone: data['phone'],
            ));
          }
        }
        notifyListeners();
      });
    } catch (e) {
      // log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  // get Notification
  Future<void> getNotification() async {
    try {
      AccountRepo().getNotification().then((value) {
       
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
          notificationModel = NotificationModel.fromJson(value);
        }
        notifyListeners();
      });
      notifyListeners();
    } catch (e) {
      // log('Error: $e');
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
      // log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  // get User Balance
  Future<void> getUserBalance() async {
    try {
      setLoading(true);
      AccountRepo().getBalance().then((value) {
       
        setLoading(false);
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
          setLoading(false);
          balance = num.parse(value['balance'].toString());
        }
        notifyListeners();
      });
      setLoading(false);
      notifyListeners();
    } catch (e) {
      // log('Error: $e');
      setLoading(false);
      ErrorToast(e.toString());
    }
  }

  // get Transaction History
  Future<void> getTrasactions({bool isLoading = true}) async {
    try {
      if (isLoading) showLoader();
      AccountRepo().getTransactions().then((value) {
       
        if (value['status'] == false || value['result'] == false) {
          if (isLoading) hideLoader();
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
          if (isLoading) hideLoader();
          transactionModel = TransactionModel.fromJson(value);
          updateDashBoardHistory();
          updateTransactionGroupData();
        }
        notifyListeners();
      });
    } catch (e) {
      // log('Error: $e');
      // setLoading(false);
      ErrorToast(e.toString());
    }
  }

  // get Refferal History
  Future<void> getReferrals({bool isLoading = true}) async {
    try {
      if (isLoading) showLoader();
      AccountRepo().getReferral().then((value) {
       
        if (value['status'] == false || value['result'] == false) {
          if (isLoading) hideLoader();
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
          if (isLoading) hideLoader();
          referralCountModel = ReferralCountModel.fromJson(value);
        }
        notifyListeners();
      });
    } catch (e) {
      // log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  // get Data plans
  Future<void> getDataPlans(
      {bool isLoading = true, required String network}) async {
    try {
      if (isLoading) showLoader();
      AccountRepo().getDataPlans(network).then((value) {
       
        if (value['status'] == false || value['result'] == false) {
          if (isLoading) hideLoader();
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
          if (isLoading) hideLoader();
          dataPlansModel = DataPlansModel.fromJson(value);
        }
        notifyListeners();
      });
    } catch (e) {
      // log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  // get Promotion
  Future<void> getPromotion({bool isLoading = true}) async {
    try {
      if (isLoading) showLoader();
      AccountRepo().getPromotion().then((value) {
       
        if (value['status'] == false || value['result'] == false) {
          if (isLoading) hideLoader();
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
          if (isLoading) hideLoader();
          promoModel = PromoModel.fromJson(value);
        }
        notifyListeners();
      });
    } catch (e) {
      // log('Error: $e');
      ErrorToast(e.toString());
    }
  }

  // delete account
  Future<void> deleteAccount() async {
    try {
     showLoader(
        text: 'Account Deletion...',
      );
      AccountRepo().deleteAccount().then((value) {
       
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
          box.clear();
          box.deleteAll([
            kAccessToken,
            isPinEnabled,
            kExistingUser,
          ]);
          log("clearing HIVE.........");
          hideLoader();
          Get.offAll(SignInScreen());
        }
        notifyListeners();
      });
    } catch (e) {
      // log('Error: $e');
      ErrorToast(e.toString());
    }
  }
}
