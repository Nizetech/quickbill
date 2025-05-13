import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';

class MyStyle {
  static const tx18White = TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontFamily: 'InterRegular');

  static const tx18Green = TextStyle(
      fontSize: 16,
      color: MyColor.greenColor,
      fontWeight: FontWeight.w400,
      fontFamily: 'SF Pro Rounded');

  static const tx16LightBlack = TextStyle(
      fontSize: 16,
      color: MyColor.lightBlackColor,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter');

  static const tx16Black = TextStyle(
      fontSize: 16,
      color: MyColor.blackColor,
      fontWeight: FontWeight.w600,
      fontFamily: 'SF Pro Rounded');

  static const tx22Green = TextStyle(
      fontSize: 22,
      color: MyColor.greenColor,
      fontWeight: FontWeight.w600,
      fontFamily: 'SF Pro Rounded');

  static const tx14Green = TextStyle(
      fontSize: 14,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      color: MyColor.greenColor);

  static const tx14Grey = TextStyle(
      fontSize: 14,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      color: MyColor.grey03Color);

  static const tx9Green = TextStyle(
      fontSize: 9.3,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      color: MyColor.greenColor);

  static const tx12White = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: 'SF Pro Rounded',
      color: Colors.white);

  static const tx12Grey = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter',
      color: Color(0xFF606773));

  static const tx20Grey = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    fontFamily: 'SF Pro Rounded',
    color: Color(0xFF595959),
  );

  static const tx36Grey = TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w500,
      fontFamily: 'SF Pro Rounded',
      color: MyColor.grey02Color);

  static const tx24Grey = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      fontFamily: 'SF Pro Rounded',
      color: MyColor.grey02Color);

  static const tx14White = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      fontFamily: 'SF Pro Rounded',
      color: Colors.white);

  static const tx14Black = TextStyle(
      fontSize: 14,
      color: MyColor.blackColor,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter');

  static const tx32Black = TextStyle(
      fontSize: 32,
      color: MyColor.blackColor,
      fontWeight: FontWeight.w500,
      fontFamily: 'SF Pro Rounded');

  static const tx12GreenUnder = TextStyle(
      fontSize: 12,
      color: Colors.green,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.underline,
      decorationColor: MyColor.greenColor,
      decorationThickness: 2.0);

  static const tx16White = TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontFamily: 'SF Pro Rounded');

  static const tx30Black = TextStyle(
      fontSize: 30,
      color: Colors.black,
      fontWeight: FontWeight.w700,
      fontFamily: 'Roboto');

  static const tx16Gray = TextStyle(
      fontSize: 16,
      color: MyColor.signGray,
      fontWeight: FontWeight.w400,
      fontFamily: 'InterRegular');

  static const tx28Black = TextStyle(
      fontSize: 28,
      color: MyColor.darkColor,
      fontWeight: FontWeight.w600,
      fontFamily: 'SF Pro Rounded');

  static const tx28Green = TextStyle(
      fontSize: 28,
      color: MyColor.greenColor,
      fontWeight: FontWeight.w600,
      fontFamily: 'SF Pro Rounded');

  static const tx16Green = TextStyle(
      fontSize: 16,
      color: MyColor.greenColor,
      fontWeight: FontWeight.w400,
      fontFamily: 'SF Pro Rounded');

  static const tx18Black = TextStyle(
      fontSize: 18,
      fontFamily: 'SF Pro Rounded',
      fontWeight: FontWeight.w600,
      color: MyColor.darkColor);

  static const tx18Grey = TextStyle(
      fontSize: 18,
      color: MyColor.grey02Color,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400);

  static const tx11Grey = TextStyle(
      fontSize: 12,
      color: MyColor.greyColor,
      fontWeight: FontWeight.w400,
      fontFamily: 'SF Pro Rounded');

  static const tx8White = TextStyle(
      fontSize: 8,
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontFamily: 'SF Pro Rounded');

  static const widgetShadow = BoxShadow(
    color: MyColor.blackTColor, // Shadow color with opacity
    spreadRadius: 0, // Spread radius
    blurRadius: 5.65, // Blur radius
    offset: Offset(0, 4.52), // Offset in x and y direction
  );

  static const tx12Black = TextStyle(
      fontSize: 12,
      color: MyColor.dark01Color,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400);

  static const tx12Green = TextStyle(
      fontSize: 12,
      color: MyColor.greenColor,
      fontFamily: 'SF Pro Rounded',
      fontWeight: FontWeight.w400);

  static const tx28BYellow = TextStyle(
    fontSize: 28,
    fontFamily: 'NimbusSanLBol',
    color: MyColor.yellowColor,
  );

  static const tx28RGreen = TextStyle(
    fontSize: 28,
    fontFamily: 'NimbusSanLRegular',
    color: MyColor.greenColor,
  );

  static const tx22RWhite = TextStyle(
    fontSize: 22,
    fontFamily: 'NimbusSanLRegular',
    color: MyColor.whiteColor,
  );

  static const tx18RWhite = TextStyle(
    fontSize: 18,
    fontFamily: 'NimbusSanLRegular',
    color: MyColor.mainWhiteColor,
  );

  static const tx18BWhite = TextStyle(
    fontSize: 18,
    fontFamily: 'NimbusSanLBol',
    color: MyColor.mainWhiteColor,
  );

  static BoxDecoration buttonDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: MyColor.greenColor,
  );

  static BoxDecoration invalidDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: MyColor.boarderColor,
  );

  static InputDecoration textInputDecoration = InputDecoration(
      isDense: true,
      filled: true,
      fillColor: MyColor.backgroundColor,
      border: InputBorder.none,
      errorStyle:
          MyStyle.tx18RWhite.copyWith(fontSize: 12, color: MyColor.redColor),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: MyColor.redColor, width: 0.8)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: MyColor.redColor, width: 0.8)),
      hintStyle: MyStyle.tx22RWhite
          .copyWith(fontSize: 18, color: MyColor.whiteColor.withOpacity(0.7)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:
              const BorderSide(color: MyColor.boarderColor, width: 0.8)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:
              const BorderSide(color: MyColor.boarderColor, width: 0.8)));

  static InputDecoration textInputDecoration2 = InputDecoration(
      isDense: true,
      border: InputBorder.none,
      errorStyle:
          MyStyle.tx18RWhite.copyWith(fontSize: 12, color: MyColor.redColor),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: const BorderSide(color: MyColor.redColor, width: 0.8)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: const BorderSide(color: MyColor.redColor, width: 0.8)),
      hintStyle: MyStyle.tx22RWhite
          .copyWith(fontSize: 18, color: MyColor.whiteColor.withOpacity(0.7)),
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide:
              const BorderSide(color: MyColor.boarderColor, width: 0.8)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide:
              const BorderSide(color: MyColor.boarderColor, width: 0.8)));
}
