import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AccountProvider accountProvider;
  late SharedPreferences sharedPreferences;
  late String deviceId;
  String isLogin = "false";
  bool isLoading = false;

  getDeviceId() async {
    sharedPreferences = await SharedPreferences.getInstance();

    // final deviceInfoPlugin = DeviceInfoPlugin();
    var uuid = const Uuid();
    deviceId = uuid.v1();
  }


  @override
  void initState() {
    accountProvider = Provider.of<AccountProvider>(context, listen: false);
    super.initState();
    getDeviceId();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Image.asset(
          "assets/images/logo.png",
          height: 65,
          width: width * 0.4,
          fit: BoxFit.contain,
        ),
      )),
    );
  }
}
