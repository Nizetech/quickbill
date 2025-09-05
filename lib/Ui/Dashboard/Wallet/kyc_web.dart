import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/common/button.dart';
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
    url = 'https://project.jostpay.com/face-capture?token=$token';
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
                setState(() {
                  isLoading = false;
                });
              },
              initialUrlRequest: URLRequest(
                url: WebUri(url),
              ),
              initialSettings: InAppWebViewSettings(
                mediaPlaybackRequiresUserGesture: false,
                allowsInlineMediaPlayback: true,
              ),
              //get message from webview
              onConsoleMessage: (controller, message) {
                log('message:==> ${message.message}');
                if (message.message.contains('Uncaught ReferenceError')) {
                  Get.back();
                  SuccessToast(
                      'Your KYC Verification has been submitted successfully');
                }
              },
              onNavigationResponse: (controller, response) async {
                log('navigation response: ${response.response?.url}');
                // prevent navigation to other pages
                if (response.response?.url.toString().isNotEmpty ?? false) {
                  log('success');
                  await account.getUserProfile().then((value) {
                    Get.back();
                  });
                  return;
                } else {
                  log('error');
                }
                return null;
              },
              onPermissionRequest: (controller, request) async {
                log('permission request: ${request.resources}');
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
