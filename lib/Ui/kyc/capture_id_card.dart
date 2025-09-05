import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Ui/kyc/verify_image.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/main.dart';

class CaptureIdCard extends StatefulWidget {
  const CaptureIdCard({super.key});

  @override
  State<CaptureIdCard> createState() => _CaptureIdCardState();
}

class _CaptureIdCardState extends State<CaptureIdCard> {
  CameraController? _cameraController;
  XFile? imageFile;
  late Future<void> _initializeCameraControllerFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _cameraController?.initialize();
    _initializeCameraControllerFuture = _initializeCameraController();
    });
  }

  Future<void> _initializeCameraController() async {
    _cameraController = CameraController(
      cameras[0],
      ResolutionPreset.max,
      enableAudio: false,
    );
    //request camera permission

    await _cameraController?.initialize();
    // set front camera
    // await _cameraController.setLensDirection(LensDirection.front);
    setState(() {});
  }

  Future<void> setFlashMode(FlashMode mode) async {
    if (!_cameraController!.value.isInitialized) {
      return;
    }

    try {
      await _cameraController!.setFlashMode(mode);
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
    if (!_cameraController!.value.isInitialized) {
      log('Error: select a camera first.');
      return null;
    }

    if (_cameraController!.value.isTakingPicture) {
      log('A capture is already pending, do nothing.');
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await _cameraController!.takePicture();
      log('Picture taken: ${file.path}');
      return file;
    } on CameraException catch (e) {
      log(e.toString());
      return null;
    }
  }

  @override
  void dispose() {
    _cameraController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (_cameraController!.value.isInitialized)
          IconButton(
            onPressed: () async {
              await setFlashMode(
                  _cameraController!.value.flashMode == FlashMode.off
                    ? FlashMode.torch
                    : FlashMode.off,
              );
              setState(() {});
            },
            icon: Icon(
                _cameraController!.value.flashMode == FlashMode.off
                  ? Icons.flash_off
                    : _cameraController!.value.flashMode == FlashMode.auto
                      ? Icons.flash_auto
                      : Icons.flash_on,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Place the information page of your Passport in the frame',
                textAlign: TextAlign.center,
                style: MyStyle.tx16Black.copyWith(
                  fontSize: 30,
                  color: theme.tertiary,
                ),
              ),
              Spacer(flex: 2),
              if (!_cameraController!.value.isInitialized)
                const Center(child: CircularProgressIndicator()),
              if (_cameraController!.value.isInitialized)
                Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 242,
                          width: 350,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: AspectRatio(
                              aspectRatio: _cameraController!.value.aspectRatio,
                              child: CameraPreview(_cameraController!),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Image.asset(
                            'assets/images/card_frame.png',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: () async {
                        imageFile = await takePicture();
                        setState(() {});
                        log(
                          imageFile.toString(),
                        );
                        if (imageFile != null) {
                          // if flash is on, then take picture
                          if (_cameraController!.value.flashMode ==
                              FlashMode.torch) {
                            // off flash
                            await setFlashMode(FlashMode.off);
                            setState(() {});
                          }
                          Get.to(
                            () => VerifyImage(
                              image: imageFile!.path,
                            ),
                          );
                        }
                      },
                      child: SvgPicture.asset(
                        'assets/images/snap_dot.svg',
                        color: theme.tertiary,
                      ),
                    )
                  ],
                ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
