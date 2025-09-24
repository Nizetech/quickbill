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
  bool isLoading = true;
  bool isDepositDone = false;
  bool finalDepositDone = false;
  String redirect = 'squard_redirect';
  InAppWebViewController? controller;
  
  // Method to handle deposit completion
  Future<void> _handleDepositCompletion(String? path, String? fullPath) async {
    if (isDepositDone || finalDepositDone) {
      log('Deposit already processed, skipping...');
      return;
    }

    if (path == '/squard_redirect' || (fullPath?.contains(redirect) ?? false)) {
      log('Processing deposit completion...');
      setState(() {
        isDepositDone = true;
      });

      String ref = '';

      // Try to extract reference from different possible locations
      if (fullPath != null) {
        if (fullPath.contains('reference=')) {
          ref = fullPath.split('reference=')[1].split('&')[0];
        } else if (fullPath.contains('ref=')) {
          ref = fullPath.split('ref=')[1].split('&')[0];
        }
      }

      log('Reference extracted: $ref');

      if (ref.isNotEmpty) {
        Get.close(2);
        final account = context.read<AccountProvider>();
        await account.getSquardCallback(
            ref: ref,
            callback: () async {
              await account.getUserBalance();
            });
      } else {
        log('No reference found in URL: $fullPath');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final account = context.read<AccountProvider>();
    // log('path:=> ${path.contains(redirect)}');
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
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
                    log('Load start: ${request?.uriValue.path}');
                    bool isDashboard = request?.uriValue.path == '/dashboard';
                    
                    // Handle deposit completion
                    await _handleDepositCompletion(
                        request?.uriValue.path, request?.uriValue.toString());

                    // Handle dashboard redirect
                    if (isDashboard) {
                      Get.close(2);
                      await account.getUserBalance();
                    }
                  },
                  onUpdateVisitedHistory:
                      (controller, request, isReload) async {
                    log('Update visited history: ${request?.uriValue.path}');

                    // Handle deposit completion
                    await _handleDepositCompletion(
                        request?.uriValue.path, request?.uriValue.toString());
                  },
                  onLoadStop: (controller, request) async {
                    setState(() {
                      isLoading = false;
                    });
                    
                    log('Load stop: ${request?.uriValue.path}');

                    // Handle deposit completion
                    await _handleDepositCompletion(
                        request?.uriValue.path, request?.uriValue.toString());
                  },
                  onPageCommitVisible: (controller, request) async {
                    log('Page commit visible: ${request?.uriValue.path}');

                    // Handle deposit completion
                    await _handleDepositCompletion(
                        request?.uriValue.path, request?.uriValue.toString());
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
                    // Allow all navigation
                    return NavigationResponseAction.ALLOW;
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
