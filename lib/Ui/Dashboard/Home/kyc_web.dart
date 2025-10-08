import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:jost_pay_wallet/constants/api_constants.dart';
import 'package:jost_pay_wallet/constants/constants.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

class KycWebview extends StatefulWidget {
  const KycWebview({super.key});

  @override
  State<KycWebview> createState() => _KycWebviewState();
}

class _KycWebviewState extends State<KycWebview> {
  final box = Hive.box(kAppName);
  String url = '';
  bool isLoading = true;
  InAppWebViewController? controller;

  @override
  void initState() {
    super.initState();
    String token = box.get(kAccessToken);
    _requestPermissions();
    url = '${ApiRoute.baseUrlWeb}face-capture?token=$token';
    log('url: $url');
    // controller = WebViewController()
  }

  // Method to request camera permission
  Future<void> _requestPermissions() async {
    // check if camera permission is granted
    PermissionStatus status = await Permission.camera.status;
    if (status.isDenied) {
      await Permission.camera.request();
    }
    // check if microphone permission is granted
    PermissionStatus microphoneStatus = await Permission.microphone.status;
    if (microphoneStatus.isDenied) {
      await Permission.microphone.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final account = Provider.of<AccountProvider>(context, listen: true);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            InAppWebView(
              onReceivedError: (controller, request, error) {
                log('error: ${error.description}');
              },
              onLoadStop: (controller, request) {
                log('load stop:====>>>>> ${request?.toString()}');
                setState(() {
                  isLoading = false;
                });
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                return NavigationActionPolicy.ALLOW;
              },

              onReceivedServerTrustAuthRequest: (controller, challenge) async {
                log('ServerTrustAuthRequest for host: ${challenge.protectionSpace.host}');
                return ServerTrustAuthResponse(
                    action: ServerTrustAuthResponseAction.PROCEED);
              },
              initialUrlRequest: URLRequest(
                url: WebUri(url),
              ),
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
              onLoadResource: (controller, request) async {
                log('my load resource:===>>> ${request.url}');
                if (request.url.toString() ==
                    'https://jostpay.com/verification/verify') {
                  await account.getUserProfile().then((value) {
                    Get.back();
                  });
                  SuccessToast(
                      'Your KYC Verification has been submitted successfully');
                }
              },

              onWebViewCreated: (controller) {
                controller.addJavaScriptHandler(
                  handlerName: 'onSuccess',
                  callback: (args) async {},
                );
                this.controller = controller;
              },
              //get message from webview
              onConsoleMessage: (controller, message) async {
                log('my console message:==> ${message.message}');
                if (message.message.contains('Uncaught ReferenceError')) {
                  await account.getUserProfile().then((value) {
                    Get.back();
                  });
                  SuccessToast(
                      'Your KY`C Verification has been submitted successfully');
                }
              },
              onNavigationResponse: (controller, response) async {
                log('my navigation response: ${response.response?.url}');
                if (response.response?.url.toString().isNotEmpty ?? false) {
                  log('my success');
                  await account.getUserProfile().then((value) {
                    Get.back();
                  });
                  SuccessToast(
                      'Your KYC Verification has been submitted successfully');
                  return;
                } else {
                  log('my error');
                }
                return null;
              },

              // Or use onLoadStart
              onLoadStart: (controller, url) async {
                final urlString = url?.toString();
                log('my load start:====>>>>> ${urlString}');
                if (urlString != null && urlString.contains('success')) {
                  // Handle success
                }
              },
              onPermissionRequest: (controller, request) async {
                log('my permission request: ${request.resources}');
                return Future.value(
                  PermissionResponse(
                    action: PermissionResponseAction.GRANT,
                    resources: request.resources,
                  ),
                );
              },
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
                    "KYC Verification",
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
      ),
    );
  }
}
