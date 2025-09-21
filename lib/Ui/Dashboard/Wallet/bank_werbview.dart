import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:provider/provider.dart';

class BankWebview extends StatefulWidget {
  final String url;
  final bool isCard;
  final bool isCardTransfer;
  const BankWebview({
    super.key,
    required this.url,
    this.isCard = false,
    this.isCardTransfer = false,
  });

  @override
  State<BankWebview> createState() => _BankWebviewState();
}

class _BankWebviewState extends State<BankWebview> {
  String path =
      'https://jostpay.com/squard_redirect?reference=CD-356178-000243';
  bool isLoading = true;
  InAppWebViewController? controller;
  @override
  Widget build(BuildContext context) {
    final account = context.read<AccountProvider>();
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    log('contains: ${path.contains('?reference')}');
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 50),
              Expanded(
                child: InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: WebUri(widget.url),
                  ),
                  shouldOverrideUrlLoading:
                      (controller, navigationAction) async {
                    return NavigationActionPolicy.ALLOW;
                  },
                  onReceivedError: (controller, request, error) {
                    log('error: ${error.description}');
                  },

                  onLoadStart: (controller, request) async {
                    log('load start :=> ${request?.uriValue.path}');
                    log('load start:=> ${request?.uriValue}');
                    bool isDashboard = request?.uriValue.path == '/dashboard';
                    bool isDepositDone =
                        request?.uriValue.path == '/squard_redirect';
                    log('isDepositDone:=> $isDepositDone');
                    if (isDepositDone == true) {
                      String ref = request?.path.split('reference=')[1] ?? '';
                      log('ref:=> $ref');
                      await account.getSquardCallback(
                          ref: ref,
                          callback: () async {
                            Get.close(2);
                            await account.getUserBalance();
                          });
                    }
                    log('isDashboard:=> $isDashboard');
                    if (isDashboard) {
                      Get.close(2);
                      await account.getUserBalance();
                    }
                  },
                  onLoadStop: (controller, request) {
                    setState(() {
                      isLoading = false;
                    });
                  },
                  onReceivedLoginRequest: (controller, request) {
                    log('login request: $request');
                  },
                  // initialSettings: InAppWebViewSettings(
                  //   mediaPlaybackRequiresUserGesture: false,
                  //   allowsInlineMediaPlayback: true,
                  // ),
                  initialSettings: InAppWebViewSettings(
                    mediaPlaybackRequiresUserGesture: false,
                    allowsInlineMediaPlayback: true,
                    allowsAirPlayForMediaPlayback: true,
                    javaScriptEnabled: true,
                    useOnNavigationResponse: false,
                    useOnDownloadStart: true,
                    supportMultipleWindows: true,
                    useOnLoadResource: true,
                    javaScriptCanOpenWindowsAutomatically: true,
                  ),
                  //get message from webview
                  onConsoleMessage: (controller, message) {
                    log('message:==> ${message.message}');
                  },
                  onNavigationResponse: (controller, response) async {
                    log('navigation response: ${response.response?.url}');
                    // prevent navigation to other pages
                  },
                ),
              ),
            ],
          ),
          Visibility(
            visible: isLoading,
            child: const Center(
                child: CircularProgressIndicator(
              color: MyColor.greenColor,
            )),
          ),
          Positioned(
              child: Container(
            height: 68,
            width: double.infinity,
            color: themeProvider.isDarkMode()
                ? MyColor.dark01Color
                : MyColor.mainWhiteColor,
            child: Row(
              children: [
                Transform.translate(
                  offset: const Offset(10, -8),
                  child: BackBtn(),
                ),
                const Spacer(flex: 2),
                Text(
                  widget.isCard ? "Card Transfer" : "Bank Transfer",
                  style: TextStyle(
                    color: themeProvider.isDarkMode()
                        ? MyColor.mainWhiteColor
                        : MyColor.dark01Color,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(
                  flex: 3,
                ),
              ],
            ),
          ))
        ],
      ),
    ));
  }
}
