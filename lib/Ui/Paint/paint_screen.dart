import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Domain/domain_screen.dart';
import 'package:jost_pay_wallet/Ui/Paint/Paintform_screen.dart';
import 'package:jost_pay_wallet/Ui/Paint/widget/rent_option.dart';
import 'package:jost_pay_wallet/Ui/car/repair_screen.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

class PaintScreen extends StatefulWidget {
  const PaintScreen({super.key});

  @override
  State<PaintScreen> createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {
  final carType = TextEditingController();
  final option = TextEditingController();
  final date = TextEditingController();
  final time = TextEditingController();
  @override
  void initState() {
    super.initState();
    // final service = Provider.of<ServiceProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //   service.getCarTypes();
      date.text = dateFormat.format(now);
      time.text = nowTime.format(context);
    });
  }
  final now = DateTime.now();
  final nowTime = TimeOfDay.now();
  final dateFormat = DateFormat("EEEE, MMMM d yyyy");

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    final isDark = themeProvider.isDarkMode();
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode()
          ? MyColor.dark02Color
          : MyColor.mainWhiteColor,
      body: Consumer<ServiceProvider>(builder: (context, model, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 68)
              .copyWith(bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      'Paint',
                      style:
                          MyStyle.tx18Black.copyWith(color: themedata.tertiary),
                    ),
                  ),
                  const Spacer(), // Adds flexible space after the text
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 17,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 19),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: isDark
                                  ? const Color(0xff1B1B1B)
                                  : const Color(0xffE9EBF8),
                              width: 2,
                            ),
                          ),
                          color: isDark
                              ? const Color(0xff101010)
                              : const Color(0xffFCFCFC),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Choose Your Rental Option",
                          style: MyStyle.tx20Grey.copyWith(
                            fontWeight: FontWeight.w400,
                            color: themedata.tertiary,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              barrierColor: Colors.blueGrey.withOpacity(.5),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              )),
                              context: context,
                              builder: (context) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: themeProvider.isDarkMode()
                                          ? MyColor.dark02Color
                                          : MyColor.mainWhiteColor,
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      )),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(height: 16),
                                      Text(
                                        'Choose Rental Option',
                                        style: MyStyle.tx18Black.copyWith(
                                            color: themedata.tertiary),
                                      ),
                                      RentOption(
                                        title: 'Rent Spray Booth',
                                        amount:
                                            "N ${formatNumber(num.parse(model.carTypeModel!.booth!))} /hr",
                                        onTap: () {
                                          Navigator.pop(context);
                                          setState(() {
                                            option.text =
                                                "Spray Booth ${formatNumber(num.parse(model.carTypeModel!.booth!))} /hr";
                                          });
                                        },
                                      ),
                                      RentOption(
                                        title: 'Rent Air Compressor',
                                        amount:
                                            "N ${formatNumber(num.parse(model.carTypeModel!.compressor!))} /75CL",
                                        onTap: () {
                                          Navigator.pop(context);
                                          setState(() {
                                            option.text =
                                                "Air Compressor ${formatNumber(num.parse(model.carTypeModel!.compressor!))} /75CL";
                                          });
                                        },
                                      ),
                                      RentOption(
                                        title:
                                            'Rent both Spray Booth & Compressor',
                                        amount:
                                            "N ${formatNumber(num.parse(model.carTypeModel!.booth!) + num.parse(model.carTypeModel!.compressor!))} /hr",
                                        onTap: () {
                                          Navigator.pop(context);
                                          setState(() {
                                            option.text =
                                                "Booth & Compressor ${formatNumber(num.parse(model.carTypeModel!.booth!) + num.parse(model.carTypeModel!.compressor!))}";
                                          });
                                        },
                                      ),
                                      SizedBox(height: 16),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: CustomTextField(
                          text: "Choose Option",
                          controller: option,
                          suffixIcon: Icons.expand_more,
                        ),
                      ),
                      const SizedBox(
                        height: 31,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Select car type",
                            style: MyStyle.tx16Black.copyWith(
                              fontFamily: 'SF Pro Rounded',
                              color: const Color(0xff6B7280),
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              barrierColor: Colors.blueGrey.withOpacity(.5),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              )),
                              context: context,
                              builder: (context) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: themeProvider.isDarkMode()
                                          ? MyColor.dark02Color
                                          : MyColor.mainWhiteColor,
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      )),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(height: 16),
                                      Text(
                                        'Select car type',
                                        style: MyStyle.tx18Black.copyWith(
                                            color: themedata.tertiary),
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount:
                                              model.carTypeModel!.cars!.length,
                                          itemBuilder: (_, i) => ListTile(
                                            onTap: () {
                                              Navigator.pop(context);
                                              setState(() {
                                                carType.text = model
                                                    .carTypeModel!
                                                    .cars![i]
                                                    .name!;
                                              });
                                            },
                                            title: Text(
                                              model
                                                  .carTypeModel!.cars![i].name!,
                                              style: MyStyle.tx18Black.copyWith(
                                                  color: themedata.tertiary),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        child: CustomTextField(
                          text: "Select",
                          controller: carType,
                          suffixIcon: Icons.expand_more,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Select date",
                            style: MyStyle.tx16Black.copyWith(
                              fontFamily: 'SF Pro Rounded',
                              color: const Color(0xff6B7280),
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2005),
                              lastDate: DateTime(60000),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: MyColor.progressBar,
                                    ),
                                    dialogBackgroundColor:
                                        MyColor.mainWhiteColor,
                                  ),
                                  child: child!,
                                );
                              }).then((value) {
                            setState(() {
                              date.text = dateFormat.format(value!);
                            });
                          });
                        },
                        child: CustomTextField(
                          controller: date,
                          text: dateFormat.format(now),
                          suffixIcon: Icons.expand_more,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Time",
                            style: MyStyle.tx16Black.copyWith(
                              fontFamily: 'SF Pro Rounded',
                              color: const Color(0xff6B7280),
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: const ColorScheme.light(
                                      primary: MyColor.progressBar,
                                    ),
                                    dialogBackgroundColor:
                                        MyColor.mainWhiteColor,
                                  ),
                                  child: child!,
                                );
                              }).then((value) {
                            setState(() {
                              time.text = value!.format(context);
                            });
                          });
                        },
                        child: CustomTextField(
                          text: nowTime.format(context),
                          controller: time,
                          suffixIcon: Icons.expand_more,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Capture",
                            style: MyStyle.tx14Black.copyWith(
                              fontSize: 17,
                              color: themedata.tertiary,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(8),
                        color: isDark
                            ? const Color(0xff0B930B)
                            : MyColor.greenColor,
                        strokeWidth: 1,
                        dashPattern: const [6, 3],
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(isDark
                                  ? "assets/images/svg/upload-dark.svg"
                                  : "assets/images/svg/upload.svg"),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.black87,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        color: isDark
                                            ? const Color(0xff1B1B1B)
                                            : const Color(0xffE9EBF8)),
                                  ),
                                  elevation: 0,
                                ),
                                onPressed: () async {
                                  await FilePicker.platform.pickFiles();
                                },
                                child: Text(
                                  'Browse files',
                                  style: MyStyle.tx18Grey.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11,
                                    color: themedata.tertiary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: isDark
                                  ? const Color(0xff1B1B1B)
                                  : const Color(0xffE9EBF8)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Uploading...',
                                    style: MyStyle.tx12Black.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: themedata.tertiary),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        '65%',
                                        style: MyStyle.tx12Black.copyWith(
                                            fontSize: 12,
                                            color: const Color(0xff6B7280)),
                                      ),
                                      const SizedBox(width: 3),
                                      Text(
                                        '•',
                                        style: MyStyle.tx12Black.copyWith(
                                            fontSize: 12,
                                            color: const Color(0xff6B7280)),
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        '30 seconds remaining',
                                        style: MyStyle.tx12Black.copyWith(
                                            color: const Color(0xff6B7280)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(94),
                                    child: LinearProgressIndicator(
                                      value: 0.65,
                                      backgroundColor: isDark
                                          ? const Color(0xff121212)
                                          : const Color(0xffFAFAFA),
                                      color: isDark
                                          ? MyColor.greenColor
                                          : const Color(0xff1849D6),
                                      minHeight: 9,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {},
                              child: SvgPicture.asset(
                                isDark
                                    ? "assets/images/svg/close-dark.svg"
                                    : "assets/images/svg/close.svg",
                                height: 24,
                                width: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 19,
                          vertical: 23,
                        ).copyWith(right: 18),
                        decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xff101010)
                                : const Color(0xffFCFCFC),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isDark
                                  ? const Color(0xff1B1B1B)
                                  : const Color(0xffE9EBF8),
                            )),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 14.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    DotLabel(
                                      text: "Rental Option",
                                      value: "Rent spray booth",
                                      dotColor: MyColor.dark01Color,
                                      labelColor: const Color(0xff6E6D7A),
                                      textColor: isDark
                                          ? MyColor.mainWhiteColor
                                          : MyColor.blackColor,
                                    ),
                                    DotLabel(
                                      text: "Car Type",
                                      dotColor: MyColor.dark01Color,
                                      value: "Saloon Car",
                                      labelColor: const Color(0xff6E6D7A),
                                      textColor: isDark
                                          ? MyColor.mainWhiteColor
                                          : MyColor.blackColor,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 22),
                              Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    DotLabel(
                                      text: "Date",
                                      value: "Wed, 28 2025",
                                      dotColor: MyColor.dark01Color,
                                      labelColor: const Color(0xff6E6D7A),
                                      textColor: isDark
                                          ? MyColor.mainWhiteColor
                                          : MyColor.blackColor,
                                    ),
                                    DotLabel(
                                      text: "Time",
                                      value: "12:30 PM",
                                      dotColor: MyColor.dark01Color,
                                      labelColor: const Color(0xff6E6D7A),
                                      textColor: isDark
                                          ? MyColor.mainWhiteColor
                                          : MyColor.blackColor,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Divider(
                                color: isDark
                                    ? const Color(0xff1B1B1B)
                                    : const Color(0xffE9EBF8),
                                thickness: 1,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total",
                                    style: MyStyle.tx16LightBlack.copyWith(
                                      color: themedata.tertiary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "N25,000",
                                    style: MyStyle.tx16Black.copyWith(
                                      color: themedata.tertiary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 38, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: isDark
                                              ? const Color(0xff0D0D0D)
                                              : MyColor.mainWhiteColor,
                                          border: Border.all(
                                              color: isDark
                                                  ? const Color(0xffFFFFFF)
                                                      .withOpacity(0.1)
                                                  : const Color(0xff121212)
                                                      .withOpacity(0.1)),
                                          borderRadius:
                                              BorderRadius.circular(999),
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
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const PaintformScreen(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 38, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: isDark
                                              ? const Color(0xff0D0D0D)
                                              : MyColor.mainWhiteColor,
                                          border: Border.all(
                                              color: isDark
                                                  ? const Color(0xffFFFFFF)
                                                      .withOpacity(0.1)
                                                  : const Color(0xff121212)
                                                      .withOpacity(0.1)),
                                          borderRadius:
                                              BorderRadius.circular(999),
                                        ),
                                        child: Text(
                                          "Proceed",
                                          style: MyStyle.tx14White.copyWith(
                                              color: themedata.tertiary,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ]),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
      ),
    );
  }
}
