
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quick_bills/Models/airtime_history.dart';
import 'package:quick_bills/Models/airtime_service_details.dart';
import 'package:quick_bills/Models/banks_model.dart';
import 'package:quick_bills/Models/cable_service_details.dart';
import 'package:quick_bills/Models/data_history_model.dart';
import 'package:quick_bills/Models/data_plans_model.dart';
import 'package:quick_bills/Models/data_service_details.dart';
import 'package:quick_bills/Models/deposit_history_model.dart';
import 'package:quick_bills/Models/elect_service_details.dart';
import 'package:quick_bills/Models/invoice_model.dart';
import 'package:quick_bills/Models/network_provider.dart';
import 'package:quick_bills/Models/notification_model.dart';
import 'package:quick_bills/Models/transactions.dart';
import 'package:quick_bills/Models/user_model.dart';
import 'package:quick_bills/Ui/Dashboard/Home/bank_werbview.dart';
import 'package:quick_bills/Ui/Dashboard/Home/payment_details.dart';
import 'package:quick_bills/common/success_screen.dart';
import 'package:quick_bills/constants/constants.dart';
import 'package:quick_bills/service/account_repo.dart';
import 'package:quick_bills/utils/loader.dart';
import 'package:quick_bills/utils/toast.dart';

class AccountProvider with ChangeNotifier {
  bool isSuccess = false;
  bool isLoading = false;
  UserModel? userModel;
  num? balance;
  TransactionModel? transactionModel;
  NotificationModel? notificationModel;
  NetworkProviderModel? networkProviderModel;
  AirtimeHistory? airtimeHistory;
  DataPlansModel? dataPlansModel;
  DataHistoryModel? dataHistoryModel;
  List<BanksModel> banksModel = [];
  InvoiceModel? invoiceModel;
  DepositHistoryModel? depositHistoryModel;
  AirtimeServiceModel? airtimeServiceModel;
  DataServiceModel? dataServiceModel;
  CableServiceModel? cableServiceModel;
  ElectServiceModel? electServiceModel;

  dynamic qrcode;
  TransactionModel? _dashBoardHistory;
  Map<dynamic, List> _transGroupByData = {};
  String _profileImage = '';
  final box = Hive.box(kAppName);
  TransactionModel? get dashBoardHistory => _dashBoardHistory;
  String get profileImage => _profileImage;
  Map<dynamic, List> get transGroupByData => _transGroupByData;
  Map<String, dynamic> kycData = {};

  void setDataPlanModelToNull() {
    dataPlansModel = null;
    notifyListeners();
  }

  void updateDashBoardHistory() {
    _dashBoardHistory = TransactionModel.fromJson(transactionModel!.toJson());
    // ..sort((a, b) => b.transDate!.compareTo(a.transDate!));
    // Sort the transactions by latest time
    _dashBoardHistory?.allTransactions
        ?.sort((a, b) => b.transDate!.compareTo(a.transDate!));
    notifyListeners();
  }

  void updateTransactionGroupData() {
    TransactionModel transactionHistory =
        TransactionModel.fromJson(transactionModel!.toJson());
    _transGroupByData = groupBy(
      transactionHistory.allTransactions!,
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

  // get User Profile
  Future<Map<String, dynamic>> getUserProfile(
      {bool isLoading = true, VoidCallback? onSuccess}) async {
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
          if (isLoading) hideLoader();
          if (onSuccess != null) {
            onSuccess();
          }
        }
        // Only notify listeners if the provider is still active
        try {
          notifyListeners();
        } catch (e) {
          // Provider might be disposed, ignore the error
          log('Provider disposed, skipping notifyListeners: $e');
        }
      });
      return res;
    } catch (e) {
      hideLoader();
      ErrorToast(e.toString());
    } finally {
      hideLoader();
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
        if (value['status'] == false || value['result'] == false ) {
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
      hideLoader();
      ErrorToast(e.toString());
    } 
  }

  Future<void> createDeposit(Map<String, dynamic> data) async {
    try {
      showLoader();
      AccountRepo().createDeposit(data).then((value) async {
        hideLoader();

        if (value['status'] == false || value['result'] == false ) {
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
          Get.close(4);
          SuccessToast(value['message']);
        }
        notifyListeners();
      });
    } catch (e) { 
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
          banksModel = List<BanksModel>.from(value['banks'].map(
            (x) => BanksModel.fromJson(x),
          ));
        }
        notifyListeners();
      });
    } catch (e) {
      hideLoader();
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
      hideLoader();
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
      hideLoader();
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
      hideLoader();
      ErrorToast(e.toString());
    } 
  }

  // buy Airtime
  Future<void> buyAirtime(Map<String, dynamic> data) async {
    try {
      showLoader();
      // showLoader();
      bool isFailed = false;
      bool isPending = false;
      AccountRepo().buyAirtime(data).then((value) async {
          hideLoader();
        log('airtime response: $value');
        isFailed = value['message'].toString().toLowerCase().contains('failed');
        isPending = value['message'].toString().toLowerCase().contains('pending') || value == {};
        if (value['result'] == null || value['result'] == false || isFailed || isPending) {
          // if (value['message'].toString().toLowerCase().contains('fail')) {
          hideLoader();
          showSuccessScreen(
            title: 'Airtime',
            status: isPending == true ? 'pending' : 'failed',
            amount: data['amount'],
            onTap: () {
              Get.close(2);
            },
          );
        }
           else {
          hideLoader();
           showSuccessScreen(
            title: 'Airtime',
            status:'success',
            amount: data['amount'],
            onTap: () async {
              Get.close(2);
              await getUserBalance();
              await getTrasactions();
            },
          );
          }
       

        notifyListeners();
      });
    } catch (e) {
      ErrorToast(e.toString());
    } 
  }

  // buy Data
  Future<void> buyData(Map<String, dynamic> data,
      {required String amount, required String plan}) async {
    try {
        bool isFailed = false;
        bool isPending = false;
      showLoader();
      AccountRepo().buyData(data).then((value) async {
        hideLoader();
        isFailed=value['message'].toString().toLowerCase().contains('failed');
        isPending = value['message'].toString().toLowerCase().contains('pending') || value == {};
          if (value['result'] == null || value['result'] == false || isFailed || isPending
          ) {
                 hideLoader();
           showSuccessScreen(
            title: 'Data',
            status: isPending == true ? 'pending' : 'failed',
            amount: data['amount'],
            onTap: () {
              Get.close(2);
            },
          );
        
        } 
        
           else {
          hideLoader();
          showSuccessScreen(
            title: 'Data',
            status:'success',
            amount: data['amount'],
            onTap: () async {
              Get.close(2);
              await getUserBalance();
               await getTrasactions();
            },
          );
          }

        
        notifyListeners();
      });
    } catch (e) {
      hideLoader();
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
      hideLoader();
      ErrorToast(e.toString());
    } 
  }

  // get User Balance
  Future<void> getUserBalance() async {
    try {
       showLoader();
      AccountRepo().getBalance().then((value) {
        hideLoader();
        if (value['status'] == false || value['result'] == false ) {
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
          balance = num.parse(value['balance'].toString());
        }
        // Only notify listeners if the provider is still active
        try {
          notifyListeners();
        } catch (e) {
          // Provider might be disposed, ignore the error
          log('Provider disposed, skipping notifyListeners: $e');
        }
      });

    } catch (e) {
      hideLoader();
      ErrorToast(e.toString());
    } 
  }
  
  Future<void> cardDeposit({
   required int amount,
  }) async {
    try {
       showLoader();
      AccountRepo().cardDeposit(amount).then((value) {
        hideLoader();
        if (value['status'] == false || value['result'] == false ) {
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
          log('${value['checkout_url']}');
          if(value['checkout_url']!=null){

          Get.to(BankWebview(url: value['checkout_url'],),);
          }
        }
        notifyListeners();
      });
    } catch (e) {
      hideLoader();
      ErrorToast(e.toString());
    } 
  }

  Future<void> verifyKyc({
    required VoidCallback callback,
  }) async {
    try {
      showLoader();
      AccountRepo().verifyKyc(kycData).then((value) {
        hideLoader();
        if (value['status'] == false || value['result'] == false ) {
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
          callback();
        }
        notifyListeners();
      });
      hideLoader();
      notifyListeners();
    } catch (e) {
      hideLoader();
      ErrorToast(e.toString());
    } 
  }

  Future<void> verifyImageUpload({
    required VoidCallback callback,
  }) async {
    try {
      showLoader();
      AccountRepo().verifyKyc(kycData).then((value) {
        hideLoader();
        if (value['status'] == false || value['result'] == false ) {
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
          callback();
        }
        notifyListeners();
      });
      hideLoader();
      notifyListeners();
    } catch (e) {
      // log('Error: $e');
      hideLoader();
      ErrorToast(e.toString());
    }
  }

  // get Transaction History
  Future<void> getTrasactions({bool isLoading = true}) async {
    try {
      if (isLoading) showLoader();
      AccountRepo().getTransactions().then((value) {
          if (value['status'] == false || value['result'] == false ) {
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
      hideLoader();
      ErrorToast(e.toString());
    } 
  }


  Future<void> getAirtimeServiceDetail() async {
       showLoader();
    try {
      AccountRepo().getHistory({
        "id":"airtime"
      }).then((value) {
          if (value['status'] == false || value['result'] == false ) {
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
         hideLoader();
          airtimeServiceModel = AirtimeServiceModel.fromJson(value);
        }
        notifyListeners();
      });
    } catch (e) {
      hideLoader();
      ErrorToast(e.toString());
    } 
  }

  Future<void> getDataServiceDetail() async {
    try {
      showLoader();
      AccountRepo().getHistory({
        "id":"data"
      }).then((value) {
          if (value['status'] == false || value['result'] == false ) {
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
          hideLoader();
          dataServiceModel = DataServiceModel.fromJson(value);
        }
        notifyListeners();
      });
    } catch (e) {
      hideLoader();
      ErrorToast(e.toString());
    } 
  }

  Future<void> getCableServiceDetail() async { 
    try {
      showLoader();
      AccountRepo().getHistory({
        "id":"cable"
      }).then((value) {
          if (value['status'] == false || value['result'] == false ) {
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
          hideLoader();
          cableServiceModel = CableServiceModel.fromJson(value);
        }
        notifyListeners();
      });
    } catch (e) {
      hideLoader();
      ErrorToast(e.toString());
    } 
  }


  Future<void> getElectServiceDetail() async { 
    try {
      showLoader();
      AccountRepo().getHistory({
        "id":"electricity"
      }).then((value) {
          if (value['status'] == false || value['result'] == false ) {
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
          hideLoader();
          electServiceModel = ElectServiceModel.fromJson(value);
        }
        notifyListeners();
      });
    } catch (e) {
      hideLoader();
      ErrorToast(e.toString());
    } 
  }

  // get Data plans
  Future<void> getDataPlans(
      {bool isLoading = true, required String networkId}) async {
    try {
      if (isLoading) showLoader();
      AccountRepo().getDataPlans(networkId).then((value) {
          if (value['status'] == false || value['result'] == false ) {
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
      hideLoader();
      ErrorToast(e.toString());
    } 
  }
}
