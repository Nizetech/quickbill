import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/utils.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  late InAppWebViewController _webViewController;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(Utils.aboutUs)),
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
