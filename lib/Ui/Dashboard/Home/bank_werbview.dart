import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:quick_bills/Provider/account_provider.dart';
import 'package:quick_bills/Provider/theme_provider.dart';
import 'package:quick_bills/Values/MyColor.dart';
import 'package:quick_bills/common/button.dart';
import 'package:provider/provider.dart';

class BankWebview extends StatefulWidget {
  final String url;
  const BankWebview({
    super.key,
    required this.url,
  });

  @override
  State<BankWebview> createState() => _BankWebviewState();
}

class _BankWebviewState extends State<BankWebview> {
  bool isLoading = true;
  bool finalDepositDone = false;
  String redirect = ' /login';
  String redirectFullUrl = 'https://jostpay.masterscript.org/login';
  
  InAppWebViewController? controller;
  
  // Method to handle deposit completion
  Future<void> _handleDepositCompletion(String? path, String? fullPath) async {
    if (!mounted) return;
    
    final account = context.read<AccountProvider>();

    if ((path?.contains(redirect) ?? false) || (fullPath == redirectFullUrl)) {
      log('Processing deposit completion...');
      Get.close(3);
      
      // Check if widget is still mounted before calling async operation
      if (mounted) {
        await account.getUserBalance();
      }
    }
  }

  @override
  void dispose() {
    // Cancel any ongoing operations
    controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('url:==> ${widget.url}');
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
                    // Handle deposit completion
                    await _handleDepositCompletion(
                        request?.uriValue.path, request?.uriValue.toString());
                  
                  },
                  onUpdateVisitedHistory:
                      (controller, request, isReload) async {
                    log('Update visited history: ${request?.uriValue.path}');
                    // Handle deposit completion 
                    await _handleDepositCompletion(
                      request?.uriValue.path,
                      request?.uriValue.toString(),
                    );
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
                  "Card Deposit",
                  style: TextStyle(
                    color: MyColor.dark01Color,
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
