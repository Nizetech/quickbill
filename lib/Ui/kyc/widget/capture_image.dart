import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:jost_pay_wallet/Provider/account_provider.dart';
import 'package:jost_pay_wallet/Ui/kyc/widget/info_wrap.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';
import 'package:jost_pay_wallet/main.dart';
import 'package:provider/provider.dart';

class CaptureImage extends StatefulWidget {
  final Function(XFile) onImageCaptured;
  final TabController tabController;
  const CaptureImage({
    super.key,
    required this.onImageCaptured,
    required this.tabController,
  });

  @override
  State<CaptureImage> createState() => _CaptureImageState();
}

class _CaptureImageState extends State<CaptureImage> {
  late CameraController _cameraController;
  XFile? imageFile;
  late Future<void> _initializeCameraControllerFuture;
  final AudioPlayer _audioPlayer = AudioPlayer();

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
      
      // Play camera shutter sound
      // await _playCameraSound();

      // Process the image to correct front camera inversion
      final correctedFile = await _correctImageOrientation(file);
      return correctedFile ?? file;
    } on CameraException catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<XFile?> _correctImageOrientation(XFile originalFile) async {
    try {
      // Read the original image file
      final File imageFile = File(originalFile.path);
      final Uint8List imageBytes = await imageFile.readAsBytes();

      // Decode the image
      final img.Image? originalImage = img.decodeImage(imageBytes);
      if (originalImage == null) {
        log('Failed to decode image');
        return originalFile;
      }

      // Flip the image horizontally to correct front camera mirroring
      final img.Image flippedImage = img.flipHorizontal(originalImage);

      // Encode the flipped image as JPEG
      final List<int> flippedBytes = img.encodeJpg(flippedImage, quality: 90);

      // Create a new file path for the corrected image
      final String correctedPath =
          originalFile.path.replaceAll('.jpg', '_corrected.jpg');

      // Write the corrected image
      final File correctedFile = File(correctedPath);
      await correctedFile.writeAsBytes(flippedBytes);

      log('Image orientation corrected and saved to: $correctedPath');

      // Return the corrected file
      return XFile(correctedPath);
    } catch (e) {
      log('Error correcting image orientation: $e');
      return originalFile; // Return original file if correction fails
    }
  }

  Future<void> _playCameraSound() async {
    // Play a camera shutter sound effect
    await _audioPlayer.play(AssetSource('assets/images/camera-13695.mp3'));
  }
  

  @override
  void dispose() {
    _cameraController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<String> fileToBase64(File file) async {
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }

  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context).colorScheme;
    final account = Provider.of<AccountProvider>(context, listen: false);
    return Column(
      children: [
       
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
                        child: Transform.scale(
                          scaleX: -1.0,
                          child: CameraPreview(_cameraController),
                        ),
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
            if (imageFile != null) {
              account.addKycData({
                'face_image': await fileToBase64(File(imageFile!.path)),
              });
              widget.onImageCaptured(imageFile!);
              widget.tabController.animateTo(1);
            }
          },
        )
      ],
    );
  }
}
