import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/kyc/widget/capture_image.dart';
import 'package:jost_pay_wallet/Ui/kyc/widget/capture_success.dart';
import 'package:jost_pay_wallet/Ui/kyc/widget/preview_image.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class FaceDetection extends StatefulWidget {
  const FaceDetection({super.key});

  @override
  State<FaceDetection> createState() => _FaceDetectionState();
}

class _FaceDetectionState extends State<FaceDetection>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  XFile? imageFile;
  void onImageCaptured(XFile image) {
    setState(() {
      imageFile = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              Text(
                'Face Detection',
                style: MyStyle.tx18Black.copyWith(color: themedata.tertiary),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Get.back(),
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: themeProvider.isDarkMode()
                      ? Color(0xff171717)
                      : MyColor.grey01Color,
                  child: Icon(
                    Icons.close,
                    color: themeProvider.isDarkMode()
                        ? MyColor.whiteColor
                        : MyColor.grey,
                    size: 15,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 30),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                CaptureImage(
                  onImageCaptured: onImageCaptured,
                  tabController: tabController,
                ),
                PreviewImage(
                  imagePath: imageFile?.path ?? '',
                  tabController: tabController,
                ),
                CaptureSuccess(
                  imagePath: imageFile?.path ?? '',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
