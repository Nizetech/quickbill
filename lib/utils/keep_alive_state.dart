import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:jost_pay_wallet/Ui/Authentication/SignInScreen.dart';

// const _inactivityTimeout = Duration(minutes: 3);
// Timer? _keepAliveTimer;
// final box = Hive.box(Constants.USER_BOX);
// bool registered = box.get('register', defaultValue: false);

void _keepAlive(bool visible) {
  print('User is ${visible ? 'active' : 'inactive'}');
  // _keepAliveTimer?.cancel();
  // if (visible) {
  //   _keepAliveTimer = null;
  // } else {
  //   _keepAliveTimer = Timer(_inactivityTimeout, () {
  //     print('User is inactive for 3 minutes');
  // if (!registered) {
  //   Get.to(SigninScreen());
  // } else {
  Get.to(SignInScreen());
  // }
  // });
  // }
}

class _KeepAliveObserver extends WidgetsBindingObserver {
  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _keepAlive(true);
      // break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _keepAlive(false); // Conservatively set a timer on all three
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }
}

/// Must be called only when app is visible, and exactly once
void startKeepAlive() {
  log("Starting KeepAlive");
  // assert(_keepAliveTimer == null);
  _keepAlive(true);
  WidgetsBinding.instance.addObserver(_KeepAliveObserver());
}
