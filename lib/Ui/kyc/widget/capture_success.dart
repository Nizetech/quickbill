import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/common/button.dart';

class CaptureSuccess extends StatelessWidget {
  final String imagePath;
  const CaptureSuccess({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context).colorScheme;
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 110,
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: Image.file(
                  File(imagePath),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 30,
              right: 0,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                child: Icon(
                  Icons.check_circle,
                  color: MyColor.greenColor,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          'Face Capture Successful',
          style: MyStyle.tx14Black.copyWith(
            color: themedata.tertiary,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Your live face has been captured successfully. You can now transact and use our service.',
          textAlign: TextAlign.center,
          style: MyStyle.tx14Black.copyWith(
            color: MyColor.grey,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        Spacer(flex: 2),
        CustomButton(
          radius: 60,
          text: 'Go Home',
          onTap: () {},
        ),
        Spacer(),
      ],
    );
  }
}
