import 'dart:io';

import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

class AppUpgrader extends StatelessWidget {
  final Widget child;
  const AppUpgrader({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      dialogStyle: Platform.isIOS
          ? UpgradeDialogStyle.cupertino
          : UpgradeDialogStyle.material,
      showIgnore: false,
      showLater: true,
      onLater: () {
        return true;
      },
      upgrader: Upgrader(
        durationUntilAlertAgain: const Duration(hours: 1),
        storeController: UpgraderStoreController(
          onAndroid: () => UpgraderPlayStore(),
          oniOS: () => UpgraderAppStore(),
        ),
      ),
      child: child,
    );
  }
}
