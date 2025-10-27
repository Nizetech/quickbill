import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quick_bills/Ui/Authentication/signIn_screen.dart';
import 'package:quick_bills/main.dart';

const _inactivityTimeout = Duration(minutes: 5);
Timer? _keepAliveTimer;

void _keepAlive(bool visible) {
  print('User is ${visible ? 'active' : 'inactive'}');
  _keepAliveTimer?.cancel();
  if (visible) {
    _keepAliveTimer = null;
  } else {
    _keepAliveTimer = Timer(
      _inactivityTimeout,
      () {
        print('User is inactive for 3 minutes');
        navigatorKey.currentState?.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => SignInScreen(),
            ),
            (route) => false);
      },
    );
  }
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
  assert(_keepAliveTimer == null);
  _keepAlive(true);
  WidgetsBinding.instance.addObserver(_KeepAliveObserver());
}
