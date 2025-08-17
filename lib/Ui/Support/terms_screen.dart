import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/DashboardProvider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/utils.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsScreen extends StatefulWidget {
  final bool isFromHome;
  final bool isFromPaint;
  const TermsScreen({
    super.key,
    this.isFromHome = false,
    this.isFromPaint = false,
  });

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  bool isLoading = true;
  WebViewController? controller;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
              if (mounted) {
            setState(() {
              isLoading = false;
            });
              }
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(Utils.termsUrl));
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final dashProvider = Provider.of<DashboardProvider>(context, listen: false);
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          if (controller != null)
          WebViewWidget(controller: controller!),
          Visibility(
            visible: isLoading && controller == null,
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
                  child: BackBtn(
                    onTap: () {
                      if (widget.isFromHome) {
                        dashProvider.changeBottomIndex(0);
                        Get.back();
                      } else if (widget.isFromPaint) {
                        Get.back();
                      } else {
                        dashProvider.changeBottomIndex(4);
                        Get.back();
                      }
                    },
                  ),
                ),
                const Spacer(flex: 2),
                Text(
                  "Terms & Conditions",
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
