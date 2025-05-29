import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Ui/Domain/domain_screen.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';

class PaintSummary extends StatelessWidget {
  final bool isDark;
  final String carType, time, date, parkage;
  final int rentType;

  const PaintSummary(
      {super.key,
      required this.isDark,
      required this.rentType,
      required this.carType,
      required this.time,
      required this.date,
      required this.parkage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 19,
        vertical: 23,
      ).copyWith(bottom: 31, right: 10),
      decoration: BoxDecoration(
          color: isDark ? const Color(0xff101010) : const Color(0xffFCFCFC),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isDark ? const Color(0xff1B1B1B) : const Color(0xffE9EBF8),
          )),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DotLabel(
              text: "Rent Option",
              value: rentType == 1
                  ? "Spray Booth"
                  : rentType == 2
                      ? "Air Compressor"
                      : "Booth & Compressor",
              dotColor: MyColor.dark01Color,
              labelColor: const Color(0xff6E6D7A),
              textColor: isDark ? MyColor.mainWhiteColor : MyColor.blackColor,
            ),
            DotLabel(
              text: "Car type",
              dotColor: MyColor.dark01Color,
              value: carType,
              labelColor: const Color(0xff6E6D7A),
              textColor: isDark ? MyColor.mainWhiteColor : MyColor.blackColor,
            ),
          ],
        ),
        if (parkage.isNotEmpty) ...[
          const SizedBox(height: 22),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DotLabel(
                text: "Parkage",
                value: parkage,
                dotColor: MyColor.dark01Color,
                labelColor: const Color(0xff6E6D7A),
                textColor: isDark ? MyColor.mainWhiteColor : MyColor.blackColor,
              ),
              DotLabel(
                text: "Car Type",
                value: "NIL",
                dotColor: MyColor.dark01Color,
                labelColor: const Color(0xff6E6D7A),
                textColor: isDark ? MyColor.mainWhiteColor : MyColor.blackColor,
              ),
            ],
          ),
        ],
        const SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DotLabel(
              flex: 2,
              text: "Date",
              value: date,
              dotColor: MyColor.dark01Color,
              labelColor: const Color(0xff6E6D7A),
              textColor: isDark ? MyColor.mainWhiteColor : MyColor.blackColor,
            ),
            DotLabel(
              flex: 2,
              text: "Time",
              value: time,
              dotColor: MyColor.dark01Color,
              labelColor: const Color(0xff6E6D7A),
              textColor: isDark ? MyColor.mainWhiteColor : MyColor.blackColor,
            ),
          ],
        ),
      ]),
    );
  }
}
