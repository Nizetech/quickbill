import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Provider/DashboardProvider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PreviewScreen extends StatefulWidget {
  final String link;
  const PreviewScreen({super.key, required this.link});

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  bool isLoading = true;
  WebViewController? controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(widget.link));
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final dashProvider = Provider.of<DashboardProvider>(context, listen: false);
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          WebViewWidget(controller: controller!),
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
                  "Script Demo",
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
