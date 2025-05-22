import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/utils.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  late InAppWebViewController _webViewController;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(Utils.faqUrl)),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                useShouldOverrideUrlLoading: false,
                javaScriptEnabled: true,
                javaScriptCanOpenWindowsAutomatically: true,
              ),
            ),
            onWebViewCreated: (controller) {
              _webViewController = controller;
            },
            onLoadStop: (controller, url) async {
              bool check = await controller.isLoading();
              if (!check) {
                setState(() {
                  isLoading = false;
                });
              }
            },
          ),
          Visibility(
            visible: isLoading,
            child: const Center(
                child: CircularProgressIndicator(
              color: MyColor.greenColor,
            )),
          ),
        ],
      ),
    ));
  }
}
