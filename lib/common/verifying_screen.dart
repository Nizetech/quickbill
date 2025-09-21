import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class VerifyingScreen extends StatelessWidget {
  const VerifyingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    return WillPopScope(
      onWillPop: () async {
        // Get.back();
        await _onWillPop();
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                scale: .2,
                image: AssetImage(
                  themeProvider.isDarkMode()
                      ? 'assets/images/verifying_dk.png'
                      : 'assets/images/verifying_li.png',
                ),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * .35,
                ),
                Text(
                  'Verifying details...',
                  style: TextStyle(
                    fontSize: 22,
                    color: MyColor.pending,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Hang tight! Your transaction is currently being processed.You’ll receive a confirmation shortly.",
                  textAlign: TextAlign.center,
                  style: MyStyle.tx14Black.copyWith(
                    color: themeProvider.isDarkMode()
                        ? MyColor.whiteColor
                        : MyColor.blackColor,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onWillPop() {
    return showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.all(20),
        actionsPadding: const EdgeInsets.all(20),
        backgroundColor: MyColor.darkGrey01Color,
        content: Text(
          'Please wait for the transaction to be processed.',
          style: MyStyle.tx18RWhite.copyWith(fontSize: 14),
        ),
      ),
    );
  }
}
