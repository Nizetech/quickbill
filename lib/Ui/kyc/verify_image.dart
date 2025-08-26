import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/kyc/start_face_detection.dart';
import 'package:jost_pay_wallet/Ui/kyc/widget/info_wrap.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/NewStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:provider/provider.dart';

class VerifyImage extends StatefulWidget {
  final String image;
  const VerifyImage({
    super.key,
    required this.image,
  });

  @override
  State<VerifyImage> createState() => _VerifyImageState();
}

class _VerifyImageState extends State<VerifyImage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    log("==> ${widget.image}");
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/images/arrow_left.png',
                      color: themeProvider.isDarkMode()
                          ? MyColor.mainWhiteColor
                          : MyColor.dark01Color,
                    ),
                  ),
                  const Spacer(),
                  Transform.translate(
                    offset: const Offset(-20, 0),
                    child: Text(
                      'KYC Verification',
                      style: MyStyle.tx18Black.copyWith(
                        color: themedata.tertiary,
                      ),
                    ),
                  ),
                  const Spacer(), // Adds flexible space after the text
                ],
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                height: 215,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: FileImage(File(widget.image)),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InfoWrap(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'After detected, your photo is....',
                      style: MyStyle.tx14Black.copyWith(
                        color: themedata.tertiary,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildInfo('Readable,clear and well-lit', themedata),
                    _buildInfo('Unreadable,模糊 or  dark', themedata),
                  ],
                ),
              ),
              Spacer(flex: 2),
              SizedBox(
                height: 45,
                child: CustomButton(
                  text: "Submit",
                  radius: 60,
                  onTap: () {
                    Get.to(() => const StartFaceDetection());
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: themeProvider.isDarkMode()
                        ? Color(0xff1B1B1B)
                        : Color(0xffFAFAFA),
                    side: BorderSide(
                      color: themeProvider.isDarkMode()
                          ? Color(0xff121212)
                          : Color(0xffe9ebf8),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                  child: Text(
                    "Retake",
                    style: NewStyle.btnTx16SplashBlue.copyWith(
                      color: themeProvider.isDarkMode()
                          ? MyColor.mainWhiteColor
                          : MyColor.greenColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  _buildInfo(String text, ColorScheme themedata) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Icon(
              Icons.check_circle_outline,
              color: themedata.tertiary,
              size: 18,
            ),
            const SizedBox(width: 5),
            Text(text,
                style: MyStyle.tx14Black.copyWith(
                  color: themedata.tertiary,
                  fontWeight: FontWeight.w400,
                )),
          ],
        ),
      );
}
