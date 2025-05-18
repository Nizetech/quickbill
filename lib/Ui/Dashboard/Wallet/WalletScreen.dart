import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jost_pay_wallet/LocalDb/Local_Account_address.dart';
import 'package:jost_pay_wallet/LocalDb/Local_Account_provider.dart';
import 'package:jost_pay_wallet/LocalDb/Local_Network_Provider.dart';
import 'package:jost_pay_wallet/LocalDb/Local_Token_provider.dart';
import 'package:jost_pay_wallet/Models/NetworkModel.dart';
import 'package:jost_pay_wallet/Provider/Account_Provider.dart';
import 'package:jost_pay_wallet/Provider/DashboardProvider.dart';
import 'package:jost_pay_wallet/Provider/Token_Provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/AddFunds.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/AlarmScreen.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/BuyAirtime.dart';
import 'package:jost_pay_wallet/Ui/Dashboard/Buy/BuyData.dart';
import 'package:jost_pay_wallet/Ui/Support/SupportScreen.dart';
import 'package:jost_pay_wallet/Ui/pay4me/pay4me_screen.dart';
import 'package:jost_pay_wallet/Ui/promotions/socials_screen.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewColor.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:jost_pay_wallet/Values/utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'dart:core';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  late AccountProvider accountProvider;
  late TokenProvider tokenProvider;
  List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> recentData = [];
  double totalBalance = 0.0;
  Map<String, dynamic> profile = {};

  Future<void> getWalletData() async {
    setState(() {
      _showRefresh = true;
    });
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");

      final response = await http.post(
          Uri.parse(
              'https://instantexchangers.com/mobile_server/get-coins'), // Get Wallet Information,
          headers: {'Authorization': 'Bearer $token'},
          body: {'type': 'buy'});

      if (response.statusCode == 200) {
        Map<String, dynamic> res = await jsonDecode(response.body);
        List<dynamic> result = res['coins'];
        List<Map<String, dynamic>> info =
            result.map((item) => Map<String, dynamic>.from(item)).toList();
        info.sort((a, b) => b['naira_price'].compareTo(a['naira_price']));
        if (mounted) {
          setState(() {
            data = info;
            _showRefresh = false;
          });
        }
      } else {
        if (response.statusCode == 301) {
          final redirectedResponse = await http.post(
              Uri.parse(response.headers['location']!),
              headers: {'Authorization': 'Bearer $token'},
              body: {'type': 'buy'});

          Map<String, dynamic> res = await jsonDecode(redirectedResponse.body);
          List<dynamic> result = res['coins'];
          List<Map<String, dynamic>> info =
              result.map((item) => Map<String, dynamic>.from(item)).toList();
          info.sort((a, b) => b['naira_price'].compareTo(a['naira_price']));
          if (mounted) {
            setState(() {
              data = info;
              _showRefresh = false;
            });
          }
        } else {
          setState(() {
            _showRefresh = false;
          });
          // If the server did not return a 200 OK response, throw an exception.
          throw Exception('Failed to load data: ${response.statusCode}');
        }
      }

      setState(() {
        _showRefresh = false;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  late String deviceId;
  String selectedAccountId = "",
      selectedAccountName = "",
      selectedAccountAddress = "",
      selectedAccountPrivateAddress = "";

  bool isCalculating = false;
  bool isLoaded = false;

  @override
  void initState() {
    tokenProvider = Provider.of<TokenProvider>(context, listen: false);
    accountProvider = Provider.of<AccountProvider>(context, listen: false);
    super.initState();
    selectedAccount();
    getWalletData();
    getProfileInfo();
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _showVerifyDialog(BuildContext context) async {
    if (profile['verified'] == '0') {
      return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
                decoration: BoxDecoration(
                    color: MyColor.backgroundColor,
                    border: Border.all(
                      color: MyColor.darkGreyColor,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(6.0)),
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text('Verification Notice',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: NewColor.mainWhiteColor)),
                    const SizedBox(height: 12.0),
                    const Text(
                        'To access the buying feature, you need to complete the verification process.',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: NewColor.txGrayColor)),
                    const SizedBox(height: 16.0),
                    Image.asset(
                      "assets/images/verify.png",
                      height: 120,
                      width: 120,
                    ),
                    const SizedBox(height: 16.0),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Verify Account',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: MyColor.blueColor)),
                    ),
                    const SizedBox(height: 12.0),
                    const Text(
                        'Tap "Verify Account" to go to the website. Log in, complete verification, and chat with support to speed up approval. Once approved, return to the app and tap "Update Verification" to refresh your status.',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: NewColor.mainWhiteColor)),
                    const SizedBox(height: 16.0),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Update Status',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: MyColor.greenColor)),
                    ),
                    const SizedBox(height: 12.0),
                    const Text(
                        "Once you've finished verification, tap the button below to update your status and gain access to buy feature.",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: NewColor.mainWhiteColor)),
                    const SizedBox(height: 24.0),
                    Container(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 130,
                            child: TextButton(
                              onPressed: () => {_launchURL(Utils.verifyUrl)},
                              style: TextButton.styleFrom(
                                backgroundColor: MyColor.blueColor,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              child: Text(
                                "Verify Account",
                                style: NewStyle.btnTx16SplashBlue.copyWith(
                                    fontSize: 14,
                                    color: NewColor.mainWhiteColor),
                              ),
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 130,
                            child: TextButton(
                              onPressed: () async {
                                await updateProfileInfo();
                                Navigator.of(context).pop();
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: MyColor.greenColor,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              child: Text(
                                "Update Status",
                                style: NewStyle.btnTx16SplashBlue.copyWith(
                                    fontSize: 14,
                                    color: NewColor.mainWhiteColor),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
          );
        },
      );
    }
  }

  getProfileInfo() async {
    const String url =
        'https://instantexchangers.com/mobile_server/get-user-profile';
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    try {
      http.Response response = await http.post(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> res = await jsonDecode(response.body);
        if (mounted) {
          setState(() {
            profile = res['user'];
          });
        }
      } else {}
    } catch (e) {
      print(e);
    }
  }

  updateProfileInfo() async {
    const String url =
        'https://instantexchangers.com/mobile_server/get-user-profile';
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    try {
      http.Response response = await http.post(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> res = await jsonDecode(response.body);
        if (mounted) {
          setState(() {
            profile = res['user'];
          });
          if (res['user']['verified'] == "1") {
            Fluttertoast.showToast(
                msg: "Your account is verified",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black54,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            Fluttertoast.showToast(
                msg: "Your account is not verified",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black54,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      } else {}
    } catch (e) {
      print(e);
    }
  }

  getHistoryInfo() async {
    const String url =
        'https://instantexchangers.com/mobile_server/get-transaction-histories';
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {'type': 'all', 'status': 'completed'},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> res = await jsonDecode(response.body);
        List<dynamic> result = res['transactions'];
        List<Map<String, dynamic>> info =
            result.map((item) => Map<String, dynamic>.from(item)).toList();
        setState(() {
          recentData = info;
        });
      } else {}
    } catch (e) {
      print(e);
    }
  }

  double showTotalValue = 0.0;
  var trxPrivateKey = "";

  // get selected account
  selectedAccount() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      isLoaded = false;
      selectedAccountId = sharedPreferences.getString('accountId') ?? "";
      selectedAccountName = sharedPreferences.getString('accountName') ?? "";
      selectedAccountAddress =
          sharedPreferences.getString('accountAddress') ?? "";
      selectedAccountPrivateAddress =
          sharedPreferences.getString('accountPrivateAddress') ?? "";
      showTotalValue = sharedPreferences.getDouble('myBalance') ?? 0.00;
    });

    // print("object selectedAccountId ${selectedAccountId}");

    if (selectedAccountId == "") {
      setState(() {
        selectedAccountId =
            DBAccountProvider.dbAccountProvider.newAccountList[0].id;
        selectedAccountName =
            DBAccountProvider.dbAccountProvider.newAccountList[0].name;

        sharedPreferences.setString('accountId', selectedAccountId);
        sharedPreferences.setString('accountName', selectedAccountName);
      });
    }

    await DbAccountAddress.dbAccountAddress
        .getAccountAddress(selectedAccountId);
    await DbNetwork.dbNetwork.getNetwork();

    for (int i = 0;
        i < DbAccountAddress.dbAccountAddress.allAccountAddress.length;
        i++) {
      if (DbAccountAddress
              .dbAccountAddress.allAccountAddress[i].publicKeyName ==
          "address") {
        if (mounted) {
          setState(() {
            selectedAccountAddress = DbAccountAddress
                .dbAccountAddress.allAccountAddress[i].publicAddress;
            selectedAccountPrivateAddress = DbAccountAddress
                .dbAccountAddress.allAccountAddress[i].privateAddress;
            sharedPreferences.setString(
                'accountAddress', selectedAccountAddress);
            sharedPreferences.setString(
                'accountPrivateAddress', selectedAccountPrivateAddress);
          });
        }
      }
    }

    await DbAccountAddress.dbAccountAddress.getPublicKey(selectedAccountId, 9);

    if (mounted) {
      setState(() {
        trxPrivateKey =
            DbAccountAddress.dbAccountAddress.selectAccountPrivateAddress;
      });

      getToken();
    }
  }

  bool _showRefresh = false, isNeeded = false;

  //cry lawn discover subway captain rib claw spice sure frequent struggle yellow
  // getToken for coin market cap
  getToken() async {
    if (isNeeded == true) {
      await DbAccountAddress.dbAccountAddress
          .getAccountAddress(selectedAccountId);

      var data = {};

      for (int j = 0;
          j < DbAccountAddress.dbAccountAddress.allAccountAddress.length;
          j++) {
        data[DbAccountAddress
                .dbAccountAddress.allAccountAddress[j].publicKeyName] =
            DbAccountAddress
                .dbAccountAddress.allAccountAddress[j].publicAddress;
      }

      // print(jsonEncode(data));

      await tokenProvider.getAccountToken(
          data, '/getAccountTokens', selectedAccountId);

      if (mounted) {
        setState(() {
          isNeeded = false;
        });
      }
    } else {
      await DBTokenProvider.dbTokenProvider.getAccountToken(selectedAccountId);
      setState(() {});
    }

    getSocketData();

    if (mounted) {
      setState(() {
        _showRefresh = false;
        isLoaded = true;
      });
    }
  }

  IO.Socket? socket;

  // socket for get updated balance
  getSocketData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    deviceId = sharedPreferences.getString('deviceId')!;
    // print("deviceId ----> $deviceId");
    socket = IO.io(
        'https://https://instantexchangers.com/mobile_server/',
        <String, dynamic>{
          "secure": true,
          "path": "/api/socket.io",
          "rejectUnauthorized": false,
          "transports": ["websocket", "polling"],
          "upgrade": false,
          "query": {"deviceId": deviceId}
        });

    socket!.connect();

    socket!.onConnect((_) {
      socket!.on("getTokenBalance", (response) async {
        // print("response ----> $response");
        if (mounted) {
          if (response["status"] == true) {
            if (response["data"]["balance"] != "null") {
              await DBTokenProvider.dbTokenProvider.updateTokenBalance(
                '${response["data"]["balance"]}',
                '${response["data"]["id"]}',
              );
            }
          }

          // print("Socket ac id $selectedAccountId");

          await DBTokenProvider.dbTokenProvider
              .getAccountToken(selectedAccountId);
          if (mounted) {
            setState(() {});
          }
          getAccountTotal();
        }
      });
    });

    for (int i = 0; i < DBTokenProvider.dbTokenProvider.tokenList.length; i++) {
      List<NetworkList> networkList = DbNetwork.dbNetwork.networkList
          .where((element) =>
              element.id ==
              DBTokenProvider.dbTokenProvider.tokenList[i].networkId)
          .toList();
      var data = {
        "id": "${DBTokenProvider.dbTokenProvider.tokenList[i].id}",
        "network_id":
            "${DBTokenProvider.dbTokenProvider.tokenList[i].networkId}",
        "tokenAddress": DBTokenProvider.dbTokenProvider.tokenList[i].address,
        "address": DBTokenProvider.dbTokenProvider.tokenList[i].accAddress,
        "trxPrivateKey": trxPrivateKey,
        "isCustomeRPC": false,
        "network_url": networkList.isEmpty ? "" : networkList.first.url,
      };

      // print("socket emit ==>  ${jsonEncode(data)}");
      socket!.emit("getTokenBalance", jsonEncode(data));
    }
  }

  bool updatingValue = false;
  double updatingTotalValue = 0.00;

  // Calculate all amount
  getAccountTotal() async {
    if (mounted) {
      setState(() {
        showTotalValue = 0.0;
      });
    }

    double valueUsd = 0.0;

    for (int i = 0; i < DBTokenProvider.dbTokenProvider.tokenList.length; i++) {
      // print("${DBTokenProvider.dbTokenProvider.tokenList[i].name} balance:- ${DBTokenProvider.dbTokenProvider.tokenList[i].balance} price:- ${DBTokenProvider.dbTokenProvider.tokenList[i].price}");

      if (DBTokenProvider.dbTokenProvider.tokenList[i].balance == "" ||
          DBTokenProvider.dbTokenProvider.tokenList[i].balance == "0" ||
          DBTokenProvider.dbTokenProvider.tokenList[i].price == 0.0) {
        valueUsd += 0;
      } else {
        valueUsd +=
            double.parse(DBTokenProvider.dbTokenProvider.tokenList[i].balance) *
                DBTokenProvider.dbTokenProvider.tokenList[i].price;
      }
    }
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        showTotalValue = valueUsd;
        sharedPreferences.setDouble("myBalance", showTotalValue);
        updatingValue = false;
      });
    }
    // print("show Total Value === > $showTotalValue");
  }

  Future<void> _getData() async {
    setState(() {
      updatingValue = false;
    });

    socket!.close();
    socket!.destroy();
    socket!.dispose();

    if (DBTokenProvider.dbTokenProvider.tokenList.isNotEmpty) {
      setState(() {
        updatingValue = true;
        updatingTotalValue = showTotalValue;
      });
    }

    setState(() {
      _showRefresh = true;
      isNeeded = true;
      getToken();
    });
  }

  doNothing() {}

  @override
  void dispose() {
    // socket!.disconnect();
    // socket!.destroy();
    // socket!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    accountProvider = Provider.of<AccountProvider>(context, listen: true);
    tokenProvider = Provider.of<TokenProvider>(context, listen: true);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final dashProvider = Provider.of<DashboardProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 68),
            decoration: BoxDecoration(
              // color: Colors.white,
              border: Border.all(
                  color: themeProvider.isDarkMode()
                      ? MyColor.borderDarkColor
                      : MyColor.borderColor,
                  width: 0.9),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        dashProvider.changeBottomIndex(4);
                      },
                      child: Container(
                        width: 153,
                        padding: const EdgeInsets.only(
                          right: 12.0,
                        ),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                                color: themeProvider.isDarkMode()
                                    ? MyColor.borderDarkColor
                                    : MyColor.borderColor,
                                width: 0.5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/avatar.png',
                              width: 40,
                              height: 40,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Yemi Oshor',
                              style: MyStyle.tx12Black.copyWith(
                                color: themeProvider.isDarkMode()
                                    ? MyColor.mainWhiteColor
                                    : MyColor.dark01Color,
                              ),
                            ),
                            Image.asset(
                              'assets/images/arrow-right.png',
                              color: themeProvider.isDarkMode()
                                  ? MyColor.mainWhiteColor
                                  : MyColor.dark01Color,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 105.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SupportScreen()));
                            },
                            child: SvgPicture.asset(
                              'assets/images/svg/customerservice.svg',
                              colorFilter: ColorFilter.mode(
                                  themeProvider.isDarkMode()
                                      ? MyColor.mainWhiteColor
                                      : MyColor.dark01Color,
                                  BlendMode.srcIn),
                            ),
                          ),
                          //!Theme switcbing
                          GestureDetector(
                              onTap: () {
                                themeProvider.toggleTheme(
                                    themeProvider.isDarkMode() ? false : true);
                              },
                              child: SvgPicture.asset(
                                'assets/images/svg/theme.svg',
                                colorFilter: ColorFilter.mode(
                                    themeProvider.isDarkMode()
                                        ? MyColor.mainWhiteColor
                                        : MyColor.dark01Color,
                                    BlendMode.srcIn),
                              )),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AlarmScreen()));
                            },
                            child: Image.asset("assets/images/alarm.png",
                                height: 23,
                                width: 22,
                                color: themeProvider.isDarkMode()
                                    ? MyColor.mainWhiteColor
                                    : null //MyColor.dark01Color,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(left: 24.0, right: 12.0),
                  decoration: BoxDecoration(
                      // color: MyColor.lightGreenColor,
                      color: Theme.of(context).colorScheme.secondary,
                      border: Border.all(
                          color: themeProvider.isDarkMode()
                              ? MyColor.borderDarkColor
                              : MyColor.borderColor,
                          width: 0.9),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 120,
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/ng-flag.png',
                                  width: 24.8,
                                  height: 24.8,
                                ),
                                const SizedBox(width: 8),
                                Text('Balance',
                                    style: MyStyle.tx16Gray.copyWith(
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary))
                              ],
                            ),
                          ),
                          Container(
                            height: 41,
                            width: 41,
                            // padding: const EdgeInsets.all(13),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                shape: BoxShape.circle),
                            child: Image.asset(
                              "assets/images/refresh.png",
                              height: 24,
                              width: 24,
                              color: MyColor.splashBtn,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '₦ 10,000.00',
                            style: MyStyle.tx28Black.copyWith(
                                fontSize: 26.sp,
                                color: Theme.of(context).colorScheme.tertiary),
                          ),
                          SvgPicture.asset('assets/images/svg/moneybag.svg'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AddFunds()));
                                },
                                borderRadius: BorderRadius.circular(
                                    12.3), // Optional: to match the container's border radius
                                child: Container(
                                  width: 54,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: MyColor.greenColor,
                                      width: 0.9,
                                    ),
                                    borderRadius: BorderRadius.circular(12.3),
                                  ),
                                  child: Image.asset(
                                    'assets/images/dashboard/money-send-circle.png',
                                    width: 23,
                                    height: 23,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text('Add funds',
                                  style: MyStyle.tx12Black.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary))
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const BuyAirtime()));
                                },
                                borderRadius: BorderRadius.circular(12.3),
                                child: Container(
                                  width: 54,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: MyColor.greenColor,
                                      width: 0.9,
                                    ),
                                    borderRadius: BorderRadius.circular(12.3),
                                  ),
                                  child: Image.asset(
                                    'assets/images/dashboard/smart-phone-01.png',
                                    width: 23,
                                    height: 23,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text('Buy Airtime',
                                  style: MyStyle.tx12Black.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary))
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Pay4meScreen())),
                                  child: Container(
                                    width: 54,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: MyColor.greenColor,
                                        width: 0.9,
                                      ),
                                      borderRadius: BorderRadius.circular(12.3),
                                    ),
                                    child: Image.asset(
                                      'assets/images/dashboard/bitcoin-03.png',
                                      width: 23,
                                      height: 23,
                                    ),
                                  ))
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text('Pay4me',
                                  style: MyStyle.tx12Black.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary))
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => dashProvider.changeBottomIndex(1),
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const Services())),
                                child: Container(
                                  width: 54,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: MyColor.greenColor,
                                      width: 0.9,
                                    ),
                                    borderRadius: BorderRadius.circular(12.3),
                                  ),
                                  child: Image.asset(
                                    'assets/images/dashboard/more-vertical-circle-01.png',
                                    width: 23,
                                    height: 23,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text('More',
                                  style: MyStyle.tx12Black.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary))
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Visibility(
            visible: dashProvider.promotionBanner,
            child: Container(
              padding: const EdgeInsets.only(left: 26, top: 11, right: 26),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Are you the next winner? 🎉',
                              style: MyStyle.tx28Black.copyWith(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      Theme.of(context).colorScheme.tertiary),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Text("Don't miss out on this incredible",
                                style: MyStyle.tx12Black.copyWith(
                                    color: themeProvider.isDarkMode()
                                        ? const Color(0XFFCBD2EB)
                                        : const Color(0xff30333A)))
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text("opportunity to win big!",
                                style: MyStyle.tx12Black.copyWith(
                                    color: themeProvider.isDarkMode()
                                        ? const Color(0XFFCBD2EB)
                                        : const Color(0xff30333A)))
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                dashProvider.changeBottomIndex(3);
                              },
                              child: Container(
                                // width: 66,
                                height: 25,
                                margin: EdgeInsets.only(bottom: 12.h),
                                decoration: BoxDecoration(
                                    color: MyColor.greenColor,
                                    borderRadius: BorderRadius.circular(5)),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 12),
                                child: const Text(
                                  'Learn more',
                                  style: MyStyle.tx8White,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                dashProvider.hidePromotionbanner(false);
                              },
                              child: Container(
                                // width: 66,
                                height: 25,
                                margin: EdgeInsets.only(bottom: 12.h),
                                decoration: BoxDecoration(
                                    color: MyColor.greenColor,
                                    borderRadius: BorderRadius.circular(5)),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 12),
                                child: const Text(
                                  'Close  X',
                                  style: MyStyle.tx8White,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                      child: Transform.translate(
                    offset: const Offset(0.0,
                        12.0), // Translate 10 pixels to the right and 20 pixels down
                    child: Image.asset(
                      'assets/images/dashboard/gift.png',
                      width: 71,
                      height: 120,
                    ),
                  ))
                ],
              ),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 24),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Services',
                                style: MyStyle.tx28Black.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                            onTap: () =>
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const BuyAirtime())),
                                            child: Container(
                                              width: 61,
                                              height: 56.5,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                boxShadow: const [
                                                  MyStyle.widgetShadow,
                                                ],
                                              ),
                                              child: Image.asset(
                                                'assets/images/dashboard/smartphone-wifi.png',
                                                height: 33.r,
                                                width: 33.r,
                                              ),
                                            ))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Row(
                                      children: [
                                        Text('Buy Airtime',
                                            style: MyStyle.tx12Black.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const BuyData())),
                                          child: Container(
                                            width: 61,
                                            height: 56.5,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              boxShadow: const [
                                                MyStyle.widgetShadow,
                                              ],
                                            ),
                                            child: Image.asset(
                                              'assets/images/dashboard/smart-phone-01.png',
                                              height: 33.r,
                                              width: 33.r,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Row(
                                      children: [
                                        Text('Buy Data',
                                            style: MyStyle.tx12Black.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SocialsScreen())),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 61,
                                            height: 56.5,
                                            padding: EdgeInsets.all(16.r),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              boxShadow: const [
                                                MyStyle.widgetShadow,
                                              ],
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/images/svg/socialBoost.svg',
                                              height: 33.r,
                                              width: 33.r,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      Row(
                                        children: [
                                          Text('Social Boost',
                                              style: MyStyle.tx12Black.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiary))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () =>
                                              dashProvider.changeBottomIndex(1),
                                          child: Container(
                                            width: 61,
                                            height: 56.5,
                                            padding: EdgeInsets.all(16.r),
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              boxShadow: const [
                                                MyStyle.widgetShadow,
                                              ],
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/images/svg/viewAll.svg',
                                              height: 33.r,
                                              width: 33.r,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Row(
                                      children: [
                                        Text('View all',
                                            style: MyStyle.tx12Black.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'History',
                              style: MyStyle.tx14Grey.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Theme.of(context).colorScheme.tertiary),
                            ),
                          ),
                          // const SizedBox(height: 10),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                const HistoryCard(),
                            shrinkWrap: true,
                            itemCount: 5,
                          ),
                          const SizedBox(height: 80),
                        ],
                      ))))
        ],
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    return ListTile(
      minVerticalPadding: 0,
      contentPadding: EdgeInsets.zero,
      leading: Container(
        height: 41.r,
        width: 41.r,
        padding: EdgeInsets.all(6.r),
        decoration: BoxDecoration(
            color: themeProvider.isDarkMode()
                ? const Color(0XFF171717)
                : const Color(0XFFF4F5F6),
            shape: BoxShape.circle),
        child: SvgPicture.asset('assets/images/svg/money.svg'),
      ),
      title: Text(
        'Fiverr',
        style: MyStyle.tx14Grey.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            color: themeProvider.isDarkMode()
                ? const Color(0XFFCBD2EB)
                : const Color(0xff30333A)),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'N 26, 000.00',
            style: MyStyle.tx14Grey.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                color: themeProvider.isDarkMode()
                    ? const Color(0XFFCBD2EB)
                    : const Color(0xff30333A)),
          ),
          Text(
            'Successful',
            style: MyStyle.tx14Grey.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 11.sp,
                color: const Color(0XFF027A48)),
          ),
        ],
      ),
      subtitle: Text(
        'June 30th, 11: 37',
        style: MyStyle.tx14Grey.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            color: themeProvider.isDarkMode()
                ? const Color(0XFFCBD2EB)
                : const Color(0xff30333A)),
      ),
    );
  }
}
