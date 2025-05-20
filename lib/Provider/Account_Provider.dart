import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/ApiHandlers/ApiHandle.dart';
import 'package:jost_pay_wallet/Models/transactions.dart';
import 'package:jost_pay_wallet/Models/user_model.dart';
import 'package:jost_pay_wallet/service/account_repo.dart';
import 'package:jost_pay_wallet/utils/loader.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
import '../LocalDb/Local_Account_provider.dart';

class AccountProvider with ChangeNotifier {
  bool isSuccess = false;
  bool isLoading = false;
  UserModel? userModel;
  num? balance;
  TransactionModel? transactionModel;

  
  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  // get User Profile
  Future<void> getUserProfile() async {
    try {
      // setLoading(true);
      showLoader();
      AccountRepo().getProfile().then((value) {
        log('Value: $value');
        setLoading(false);
        if (value['result'] == false) {
          hideLoader();
          ErrorToast(value['message']);
        } else {
          hideLoader();
          userModel = UserModel.fromJson(value);
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

  // get User Balance
  Future<void> getUserBalance() async {
    try {
      setLoading(true);
      // showLoader();
      AccountRepo().getBalance().then((value) {
        log('Value: $value');
        setLoading(false);
        if (value['result'] == false) {
          // hideLoader();
          ErrorToast(value['message']);
        } else {
          // hideLoader();
          // userModel = UserModel.fromJson(value);
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
      // setLoading(true);
      if (isLoading) showLoader();

      AccountRepo().getTransactions().then((value) {
        log('Value: $value');
        // setLoading(false);
        if (value['result'] == false) {
          if (isLoading) hideLoader();
          ErrorToast(value['message']);
        } else {
          if (isLoading) hideLoader();
          // userModel = UserModel.fromJson(value);
          transactionModel = TransactionModel.fromJson(value);
        }
        notifyListeners();
      });
    } catch (e) {
      log('Error: $e');
      // setLoading(false);
      ErrorToast(e.toString());
    }
  }

  var accountData;
  bool isAccountLoad = false;
  addAccount(data, url) async {
    isLoading = true;
    isSuccess = false;
    isAccountLoad = false;
    notifyListeners();

    await ApiHandler.post(data, url).then((responseData) {
      var value = json.decode(responseData.body);
      // print("account add =====>  $value");

      if (responseData.statusCode == 200 && value["status"] == true) {
        accountData = value["accounts"];
/*

          (accountData["accounts"] as List).map((accounts) {
            // DBAccountProvider.dbAccountProvider.createAccount(NewAccountList.fromJson(accounts));
          }).toList();
*/

        isLoading = false;
        isSuccess = true;
        isAccountLoad = true;
        notifyListeners();
      } else {
        isLoading = false;
        isSuccess = false;
        isAccountLoad = false;
        notifyListeners();
        print("=========== Add Account Api Error ==========");
      }
    });
  }

  var allAccounts;
  getAccount(data, url) async {
    isLoading = true;
    isSuccess = false;

    await ApiHandler.post(data, url).then((responseData) {
      var value = json.decode(responseData.body);
      //print(value);
      if (responseData.statusCode == 200 && value["status"] == true) {
        isSuccess = true;
        allAccounts = value;
        DBAccountProvider.dbAccountProvider.deleteAllAccount();

        /* (allAccounts["accounts"] as List).map((accounts){
            DBAccountProvider.dbAccountProvider.createAccount(AccountList.fromJson(accounts));
          }).toList();*/

        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        isSuccess = false;
        notifyListeners();
        print("=========== Get Account Api Error ==========");
      }
    });
  }


  bool isAccount = false;
  var checkAccountList;
  checkAccount(data, url) async {
    isLoading = true;

    await ApiHandler.post(data, url).then((responseData) {
      var value = json.decode(responseData.body);
      if (responseData.statusCode == 200 && value["status"] == true) {
        isAccount = true;
        isLoading = false;
        checkAccountList = value;
        notifyListeners();
      } else {
        isAccount = false;
        isLoading = false;
        print("=========== Account Check Api Error ==========");
        notifyListeners();
      }
    });
  }

  var loginAccountDetails;
  loginAccount(data, url) async {
    isLoading = true;
    isSuccess = false;
    notifyListeners();

    await ApiHandler.post(data, url).then((responseData) {
      var value = json.decode(responseData.body);
      // print("login response ---> $value");

      if (responseData.statusCode == 200 && value["status"] == true) {
        isSuccess = true;
        isLoading = false;
        loginAccountDetails = value;

        notifyListeners();
      } else {
        isSuccess = false;
        isLoading = false;
        notifyListeners();

        print("=========== Login Api Error ==========");
      }
    });
  }

  bool isdeleted = true;
  var deleteData;
  deleteAccount(data, url) async {
    isLoading = true;
    notifyListeners();

    await ApiHandler.post(data, url).then((responseData) {
      var value = json.decode(responseData.body);
      //print(value);

      if (responseData.statusCode == 200 && value["status"] == true) {
        isdeleted = true;
        deleteData = value;
        notifyListeners();
      } else {
        isdeleted = false;
        isLoading = false;
        notifyListeners();
        print("=========== Delete Account Api Error ==========");
      }
    });
  }

  bool isPassword = false;
  bool passwordLoading = false;
  forgotPassword(data, url) async {
    passwordLoading = true;
    notifyListeners();

    await ApiHandler.post(data, url).then((responseData) {
      var value = json.decode(responseData.body);
      //print(value);

      if (responseData.statusCode == 200 && value["status"] == true) {
        isPassword = true;
        passwordLoading = false;
        notifyListeners();
      } else {
        isPassword = false;
        passwordLoading = false;
        notifyListeners();

        print("=========== Forgot Password Api Error ==========");
      }
    });
  }

  bool isChange = false;
  changeAccountName(data, url) async {
    isLoading = true;
    notifyListeners();

    await ApiHandler.post(data, url).then((responseData) {
      var value = json.decode(responseData.body);
      //print(value);

      if (responseData.statusCode == 200 && value["status"] == true) {
        isChange = true;
        isLoading = false;
        notifyListeners();
      } else {
        isChange = false;
        isLoading = false;
        notifyListeners();
        print("=========== Account Name Change Api Error ==========");
      }
    });
  }
}
