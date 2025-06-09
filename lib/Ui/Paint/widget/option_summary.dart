import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Domain/domain_screen.dart';
import 'package:jost_pay_wallet/Ui/Paint/Paintform_screen.dart';
import 'package:jost_pay_wallet/Ui/Paint/widget/rental.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
import 'package:provider/provider.dart';

class OptionSummary extends StatefulWidget {
  final String? total;
  final String time;
  final DateTime date;
  final int? rentType;
  final String? carType;
  final String? image;

  const OptionSummary({
    super.key,
    required this.date,
    required this.time,
    this.rentType,
    this.total,
    this.carType,
    this.image,
  });

  @override
  State<OptionSummary> createState() => _OptionSummaryState();
}

class _OptionSummaryState extends State<OptionSummary> {
  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat("EEE, MMMM d yyyy");
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    final isDark = themeProvider.isDarkMode();
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 19,
        vertical: 23,
      ).copyWith(right: 18),
      decoration: BoxDecoration(
          color: isDark ? const Color(0xff101010) : const Color(0xffFCFCFC),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isDark ? const Color(0xff1B1B1B) : const Color(0xffE9EBF8),
          )),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(right: 14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DotLabel(
                flex: 4,
                text: "Rental Option",
                value: widget.rentType == 1
                    ? "Spray Booth"
                    : widget.rentType == 2
                        ? "Air Compressor"
                        : "Booth & Compressor",
                dotColor: MyColor.dark01Color,
                labelColor: const Color(0xff6E6D7A),
                textColor: isDark ? MyColor.mainWhiteColor : MyColor.blackColor,
              ),
              DotLabel(
                flex: 3,
                text: "Car Type",
                dotColor: MyColor.dark01Color,
                value: widget.carType ?? "",
                labelColor: const Color(0xff6E6D7A),
                textColor: isDark ? MyColor.mainWhiteColor : MyColor.blackColor,
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DotLabel(
                flex: 3,
                text: "Date",
                value: dateFormat.format(widget.date),
                dotColor: MyColor.dark01Color,
                labelColor: const Color(0xff6E6D7A),
                textColor: isDark ? MyColor.mainWhiteColor : MyColor.blackColor,
              ),
              DotLabel(
                flex: 2,
                text: "Time",
                value: widget.time,
                dotColor: MyColor.dark01Color,
                labelColor: const Color(0xff6E6D7A),
                textColor: isDark ? MyColor.mainWhiteColor : MyColor.blackColor,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Divider(
          color: isDark ? const Color(0xff1B1B1B) : const Color(0xffE9EBF8),
          thickness: 1,
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total",
              style: MyStyle.tx16LightBlack.copyWith(
                color: themedata.tertiary,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              widget.total ?? "",
              style: MyStyle.tx16Black.copyWith(
                color: themedata.tertiary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 38, vertical: 10),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xff0D0D0D)
                        : MyColor.mainWhiteColor,
                    border: Border.all(
                        color: isDark
                            ? const Color(0xffFFFFFF).withOpacity(0.1)
                            : const Color(0xff121212).withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    "Cancel",
                    style: MyStyle.tx14White.copyWith(
                        color: isDark
                            ? const Color(0xffDD4848)
                            : const Color(0xffD93333),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {});
                  if ((widget.rentType ?? -1) >= 0 &&
                      (widget.carType ?? "").isNotEmpty &&
                      (widget.total ?? "").isNotEmpty &&
                      (widget.image ?? "").isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaintformScreen(
                          rentalData: RentalData(
                            time: widget.time,
                            date: widget.date,
                            image: widget.image!,
                            rentType: widget.rentType!,
                            carType: widget.carType!,
                            total: widget.total!.replaceAll(',', ''),
                          ),
                        ),
                      ),
                    );
                  } else if ((widget.rentType ?? -1) < 0) {
                    log('rnt type ${widget.rentType}');
                    ErrorToast("Please select rental type");
                  } else {
                    log(" car type ${widget.carType}, total ${widget.total}, image ${widget.image}, rent type ${widget.rentType}, date ${widget.date}, time ${widget.time}, ");
                    ErrorToast("Please select all fields");
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 38, vertical: 10),
                  decoration: BoxDecoration(
                    color: MyColor.greenColor,
                    // isDark
                    //     ? const Color(0xff0D0D0D)
                    //     : MyColor.mainWhiteColor,
                    border: Border.all(
                        color: isDark
                            ? const Color(0xffFFFFFF).withOpacity(0.1)
                            : const Color(0xff121212).withOpacity(0.1)),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    "Proceed",
                    style: MyStyle.tx14White.copyWith(
                        // color: themedata.tertiary, 
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
