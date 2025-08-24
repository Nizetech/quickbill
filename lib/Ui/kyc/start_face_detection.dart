import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/kyc/face_detection.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:provider/provider.dart';

class StartFaceDetection extends StatelessWidget {
  const StartFaceDetection({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Transform.translate(
                      offset: const Offset(-20, 0), child: BackBtn()),
                  const Spacer(),
                  Transform.translate(
                    offset: const Offset(-20, 0),
                    child: Text(
                      'Live Face Detection',
                      style:
                          MyStyle.tx18Black.copyWith(color: themedata.tertiary),
                    ),
                  ),
                  const Spacer(), // Adds flexible space after the text
                ],
              ),
              const SizedBox(height: 30),
              Text(
                'Face Capture Verification',
                style: MyStyle.tx14Black.copyWith(
                  color: themedata.tertiary,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Scan your face to activate limit and features',
                style: MyStyle.tx14Black.copyWith(
                  color: MyColor.grey03Color,
                  fontWeight: FontWeight.w300,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              Image.asset(
                themeProvider.isDarkMode()
                    ? 'assets/images/capture_dk.png'
                    : 'assets/images/capture_li.png',
                width: double.infinity,
                height: 150,
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/mask_face.svg',
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Uncovered face',
                    style: MyStyle.tx14Black.copyWith(
                      color: themeProvider.isDarkMode()
                          ? MyColor.mainWhiteColor
                          : MyColor.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    'assets/images/sun.svg',
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Well-lit',
                    style: MyStyle.tx14Black.copyWith(
                      color: themeProvider.isDarkMode()
                          ? MyColor.mainWhiteColor
                          : MyColor.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                height: 45,
                child: CustomButton(
                  radius: 60,
                  text: 'Start Live Capturing',
                  bgColor: themeProvider.isDarkMode()
                      ? Color(0xff0B930B)
                      : MyColor.greenColor,
                  fontWeight: FontWeight.w500,
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) => FaceDetection());
                  },
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'We will automatically detect your face',
                  style: MyStyle.tx14Black.copyWith(
                    color: themeProvider.isDarkMode()
                        ? MyColor.mainWhiteColor
                        : MyColor.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
