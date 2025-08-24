import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Ui/kyc/widget/info_wrap.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:jost_pay_wallet/main.dart';

class CaptureImage extends StatefulWidget {
  const CaptureImage({super.key});

  @override
  State<CaptureImage> createState() => _CaptureImageState();
}

class _CaptureImageState extends State<CaptureImage> {
  late CameraController _cameraController;
  XFile? imageFile;
  late Future<void> _initializeCameraControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCameraControllerFuture = _initializeCameraController();
  }

  Future<void> _initializeCameraController() async {
    // Find front camera
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras[0],
    );
    _cameraController = CameraController(
      frontCamera,
      ResolutionPreset.max,
      enableAudio: false,
    );
    //request camera permission

    await _cameraController.initialize();

    setState(() {});
  }

  Future<void> setFlashMode(FlashMode mode) async {
    if (!_cameraController.value.isInitialized) {
      return;
    }

    try {
      await _cameraController.setFlashMode(mode);
    } on CameraException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _cameraController;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCameraController();
    }
  }

  Future<XFile?> takePicture() async {
    if (!_cameraController.value.isInitialized) {
      log('Error: select a camera first.');
      return null;
    }

    if (_cameraController.value.isTakingPicture) {
      log('A capture is already pending, do nothing.');
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await _cameraController.takePicture();
      log('Picture taken: ${file.path}');
      return file;
    } on CameraException catch (e) {
      log(e.toString());
      return null;
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context).colorScheme;
    return Column(
      children: [
        // Container(
        //   height: Get.height * 0.3,
        //   width: Get.width * 0.7,
        //   decoration: BoxDecoration(
        //     color: MyColor.grey01Color,
        //     borderRadius: BorderRadius.circular(10),
        //   ),
        // ),
        if (!_cameraController.value.isInitialized)
          const Center(child: CircularProgressIndicator()),
        if (_cameraController.value.isInitialized)
          Column(children: [
            Stack(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      height: Get.height * 0.3,
                      width: Get.width * 0.7,
                      child: AspectRatio(
                        aspectRatio: _cameraController.value.aspectRatio,
                        child: CameraPreview(_cameraController),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Image.asset(
                      'assets/images/pass_frame.png',
                      height: Get.height * 0.28,
                    ),
                  ),
                ),
              ],
            ),
          ]),

        const SizedBox(height: 30),
        InfoWrap(
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/face_info.svg',
                    color: themedata.tertiary,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Text(
                    'Read instruction carefully',
                    style: MyStyle.tx14Black.copyWith(
                      color: themedata.tertiary,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  )),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Place capture your live image using your device camera. Make sure you are in a well lit environment and take a clear. clean picture of your face. Remember to grant camera permissions from your device browser to enable camera access. Please blink, then nod down and back. We will auto-capture after both. Check the sample image.',
                style: MyStyle.tx14Black.copyWith(
                  color: themedata.tertiary,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        CustomButton(
          text: "I'm Ready",
          radius: 60,
          onTap: () async {
            imageFile = await takePicture();
            setState(() {});
            log(
              imageFile.toString(),
            );
          },
        )
      ],
    );
  }
}
