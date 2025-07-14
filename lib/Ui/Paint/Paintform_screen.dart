import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:jost_pay_wallet/Models/color_paint_mode.dart' as paint;
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Paint/paint_screen.dart';
import 'package:jost_pay_wallet/Ui/Paint/widget/dropdown_option.dart';
import 'package:jost_pay_wallet/Ui/Paint/widget/paint_parkages.dart';
import 'package:jost_pay_wallet/Ui/Paint/widget/paint_summary.dart';
import 'package:jost_pay_wallet/Ui/Paint/widget/rental.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/utils/toast.dart';
import 'package:provider/provider.dart';

class PaintformScreen extends StatefulWidget {
  final RentalData rentalData;
  const PaintformScreen({super.key, required this.rentalData});

  @override
  State<PaintformScreen> createState() => _PaintformScreenState();
}

class _PaintformScreenState extends State<PaintformScreen> {
  int painterindex = 0;
  List parkageList = ["Full Body Painting", "Touch-up", "Color Change"];
  List painterType = ["Use Company Painter", "Use My Own Painter"];
  List careDurationList = [
    '30 days After Care',
    '90 days After Care',
    '180 days After Care'
  ];
  List tags = ['Premium', 'Standard', 'Basic'];
  int careDuration = 0;
  int packageIndex = 0;
  List<paint.PaintColor> selectedTouch = [];
  int touchIndex = 0;
  String packageId = '34';
  num total = 0;

  @override
  void initState() {
    super.initState();
    final model = Provider.of<ServiceProvider>(context, listen: false);
    total = num.parse(widget.rentalData.total) +
        widget.rentalData.price15 +
        num.parse(touchPrice(
            parkageIndex: packageIndex,
            color: model.colorPaintModel!.color!,
            careIndex: careDuration,
            paint: model.colorPaintModel!.paints![touchIndex]));
  }

  @override
  Widget build(BuildContext context) {
    // log("Price 15 =>> ${widget.rentalData.price15}. ===> ${num.parse(widget.rentalData.total) + widget.rentalData.price15}");
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
                      'Paint & Spray Booth',
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
                          "Choose Your Painting Package",
                          style: MyStyle.tx20Grey.copyWith(
                            fontWeight: FontWeight.w400,
                            color: themedata.tertiary,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      DropdownOption(
                        title: painterType[painterindex],
                        option: painterType,
                        onSelected: (val) {
                          setState(() {
                            painterindex = painterType.indexOf(val);
                            if (painterindex == 1) {
                              total = num.parse(widget.rentalData.total);
                              // +
                              // widget.rentalData.price15;
                            } else {
                              if (packageIndex == 1) {
                                selectedTouch = [];
                                total = num.parse(widget.rentalData.total) +
                                    widget.rentalData.price15;
                              } else {
                                total = num.parse(widget.rentalData.total) +
                                    widget.rentalData.price15 +
                                    num.parse(
                                      touchPrice(
                                        parkageIndex: packageIndex,
                                        color: model.colorPaintModel!.color!,
                                        careIndex: careDuration,
                                        paint: model.colorPaintModel!
                                            .paints![touchIndex],
                                      ),
                                    );
                              }
                            }
                          });
                        },
                      ),
                      const SizedBox(
                        height: 31,
                      ),
                      if (painterindex == 0) ...[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Select package",
                              style: MyStyle.tx16Black.copyWith(
                                fontFamily: 'SF Pro Rounded',
                                color: const Color(0xff6B7280),
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownOption(
                          title: parkageList[packageIndex],
                          option: parkageList,
                          onSelected: (val) {
                            setState(() {
                              packageIndex = parkageList.indexOf(val);
                              if (packageIndex != 1) {
                                total = num.parse(widget.rentalData.total) +
                                    widget.rentalData.price15 +
                                    num.parse(touchPrice(
                                        parkageIndex: packageIndex,
                                        color: model.colorPaintModel!.color!,
                                        careIndex: careDuration,
                                        paint: model.colorPaintModel!
                                            .paints![touchIndex]));
                              } else {
                                selectedTouch = [];
                                total = num.parse(widget.rentalData.total);
                                // +
                                //     widget.rentalData.price15;
                              }
                            });
                          },
                        ),
                        if (packageIndex != 1) ...[
                          const SizedBox(
                            height: 16,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Select care duration",
                                style: MyStyle.tx16Black.copyWith(
                                  fontFamily: 'SF Pro Rounded',
                                  color: const Color(0xff6B7280),
                                  fontWeight: FontWeight.w400,
                                )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DropdownOption(
                            title: careDurationList[careDuration],
                            option: careDurationList,
                            onSelected: (val) {
                              setState(() {
                                careDuration = careDurationList.indexOf(val);
                                total = num.parse(widget.rentalData.total) +
                                    widget.rentalData.price15 +
                                    num.parse(touchPrice(
                                        parkageIndex: packageIndex,
                                        color: model.colorPaintModel!.color!,
                                        careIndex: careDuration,
                                        paint: model.colorPaintModel!
                                            .paints![touchIndex]));
                              });
                            },
                          ),
                        ],
                        const SizedBox(
                          height: 29,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 11),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xff181818)
                                  : const Color(0xffF4F4F4),
                              border: Border(
                                right: BorderSide(
                                  color: isDark
                                      ? const Color(0xffC8FBC8)
                                      : const Color(0xff043704),
                                  width: 3,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isDark
                                        ? const Color(0xffC8FBC8)
                                        : const Color(0xff043704),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/images/svg/list.svg',
                                    color: isDark
                                        ? MyColor.dark02Color
                                        : MyColor.mainWhiteColor,
                                  ),
                                ),
                                const SizedBox(width: 11),
                                Text(
                                    packageIndex == 0
                                        ? "Full Body Painting"
                                        : packageIndex == 1
                                            ? "Touch-up"
                                            : "Full Body Painting Color-change",
                                    style: MyStyle.tx16Black.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: themedata.tertiary,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        if (packageIndex != 1 &&
                            model.colorPaintModel != null) ...[
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            separatorBuilder: (_, i) => SizedBox(height: 16),
                            itemCount: model.colorPaintModel!.paints!.length,
                            itemBuilder: (_, i) {
                              num durationDay = careDuration == 0
                                  ? 30
                                  : careDuration == 1
                                      ? 90
                                      : 180;
                              num price = num.parse(touchPrice(
                                  careIndex: careDuration,
                                  parkageIndex: packageIndex,
                                  color: model.colorPaintModel!.color!,
                                  paint: model.colorPaintModel!.paints![i]));
                              return PaintPackages(
                                  onTap: () {
                                    setState(() {
                                      touchIndex = i;
                                      packageId =
                                          model.colorPaintModel!.paints![i].id!;
                                      total =
                                          num.parse(widget.rentalData.total) +
                                              widget.rentalData.price15 +
                                              price;
                                      log('packageId: $packageId');
                                    });
                                  },
                                  subtitle: i == 0
                                      ? "Premium-grade paint: sleek finish, top durability. $durationDay-dayaftercare: any defects reported within $durationDay days will be fixed free of charge."
                                      : i == 1
                                          ? "High-quality paint: smooth finish, strong durability. $durationDay-dayaftercare: any defects reported within $durationDay days will be fixed free of charge."
                                          : "Good-quality paint: solid durability, clean finish. $durationDay-dayaftercare: any defects found within $durationDay days after delivery will be fixed free of charge.",
                                  isSelected: i == touchIndex,
                                  tag: tags[i],
                                  title:
                                      model.colorPaintModel!.paints![i].name!,
                                  isDark: isDark,
                                  price:
                                      "N${formatNumber(price + widget.rentalData.price15)}",
                                  themedata: themedata,
                                  themeProvider: themeProvider);
                            },
                          ),
                          const SizedBox(
                            height: 37,
                          ),
                        ] else ...[
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: isDark
                                      ? const Color(0xff131313)
                                      : const Color(0xffF9F9F9)),
                              child: Container(
                                padding: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isDark
                                        ? const Color(0xff1B1B1B)
                                        : const Color(0xffE9EBF8),
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  color: isDark
                                      ? MyColor.dark02Color
                                      : MyColor.mainWhiteColor,
                                ),
                                child: Stack(children: [
                                  if (!isDark)
                                    Positioned(
                                      right: 3,
                                      top: 10,
                                      child: SvgPicture.asset(
                                        'assets/images/svg/check-list.svg',
                                      ),
                                    ),
                                  if (model.colorPaintModel != null)
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      itemCount: model
                                          .colorPaintModel!.touches!.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 4),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  checkboxTheme:
                                                      CheckboxThemeData(
                                                    fillColor:
                                                        WidgetStateProperty
                                                            .resolveWith<Color>(
                                                                (states) {
                                                      if (states.contains(
                                                          WidgetState
                                                              .selected)) {
                                                        return isDark
                                                            ? const Color(
                                                                0xff0B930B)
                                                            : MyColor
                                                                .greenColor;
                                                      }
                                                      return Colors.transparent;
                                                    }),
                                                    checkColor:
                                                        WidgetStateProperty.all<
                                                                Color>(
                                                            Colors.white),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3)),
                                                    side: WidgetStateBorderSide
                                                        .resolveWith((states) {
                                                      if (states.contains(
                                                          WidgetState
                                                              .selected)) {
                                                        return BorderSide(
                                                          color: isDark
                                                              ? MyColor
                                                                  .mainWhiteColor
                                                              : const Color(
                                                                  0xffD1D1D1),
                                                        );
                                                      } else {
                                                        return BorderSide(
                                                          color: isDark
                                                              ? const Color(
                                                                  0xff3B3B3B)
                                                              : const Color(
                                                                  0xffD1D1D1),
                                                        );
                                                      }
                                                    }),
                                                  ),
                                                ),
                                                child: SizedBox(
                                                  height: 30,
                                                  child: Checkbox(
                                                    value: selectedTouch
                                                        .contains(model
                                                            .colorPaintModel!
                                                            .touches![index]),
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        if (selectedTouch
                                                            .contains(model
                                                                .colorPaintModel!
                                                                .touches![index])) {
                                                          selectedTouch.remove(model
                                                              .colorPaintModel!
                                                              .touches![index]);
                                                        } else {
                                                          selectedTouch.add(model
                                                              .colorPaintModel!
                                                              .touches![index]);
                                                        }
                                                        total = num.parse(widget
                                                                .rentalData
                                                                .total) +
                                                            // widget.rentalData
                                                            //     .price15 +
                                                            selectedTouch.fold(
                                                                0,
                                                                (previousValue,
                                                                        element) =>
                                                                    previousValue +
                                                                    num.parse(
                                                                        element
                                                                            .price!));
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '${model.colorPaintModel!.touches![index].name} - ₦${model.colorPaintModel!.touches![index].price}',
                                                  style: MyStyle
                                                      .tx12Black
                                                      .copyWith(
                                                          color: isDark
                                                              ? MyColor
                                                                  .mainWhiteColor
                                                              : const Color(
                                                                  0xff6B7280),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                ]),
                              ))
                        ],
                      ],
                      if (packageIndex != 1 && painterindex == 0)
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            "This cost covers paint, equipment rental, interior/engine wash, and labour. If any dents or damaged parts are found on your vehicle, the invoice will be updated to include repair or replacement costs.",
                            style: MyStyle.tx12Black.copyWith(
                              height: 1.5,
                              color: MyColor.dark01GreenColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color:
                                MyColor.dark01GreenColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: MyColor.dark01GreenColor,
                            ),
                          ),
                        ),
                      PaintSummary(
                        time: widget.rentalData.time,
                        date: dateFormat.format(widget.rentalData.date),
                        carType: widget.rentalData.carType,
                        rentType: widget.rentalData.rentType,
                        isDark: isDark,
                        parkage:
                            painterindex == 1 ? "" : parkageList[packageIndex],
                      ),
                      const SizedBox(height: 30),
                      Divider(
                        color: isDark
                            ? const Color(0xff1B1B1B)
                            : const Color(0xffE9EBF8),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total",
                              style: MyStyle.tx14Black.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: themedata.tertiary,
                              )),
                          Text("N${formatNumber(total)}",
                              style: MyStyle.tx14Black.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: themedata.tertiary,
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            List tourchId =
                                selectedTouch.map((e) => e.id).toList();
                            Map<String, dynamic> sprayData = {};
                            sprayData = {
                              "rentType": widget.rentalData.rentType,
                              "carType": widget.rentalData.carType,
                              "date": DateFormat("yyyy-MM-dd")
                                  .format(widget.rentalData.date),
                              "time": widget.rentalData.time,
                              "total": total,
                              "image": widget.rentalData.image,
                              "price": num.parse(widget.rentalData.total),
                              "paintType": painterindex == 1
                                  ? 3
                                  : packageIndex == 1
                                      ? 2
                                      : packageIndex == 2
                                          ? 5
                                          : 1,
                              "colorChange": painterindex == 1
                                  ? 0
                                  : packageIndex == 2
                                      ? 1
                                      : 0,
                              if (painterindex != 1)
                                "packages":
                                    packageIndex != 1 ? [packageId] : tourchId,
                              if (packageIndex != 1 || painterindex != 1)
                                "careDay": careDurationList[careDuration]
                                    .toString()
                                    .split(" ")
                                    .first,
                            };
                            if (selectedTouch.isEmpty && packageIndex == 1) {
                              ErrorToast('Please select at least one touch');
                            } else {
                            model.rentSpray(sprayData);
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide.none,
                            backgroundColor: themeProvider.isDarkMode()
                                ? const Color(0xff0B930B)
                                : MyColor.greenColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                          child: Text("Pay Now",
                              style: MyStyle.tx16Black.copyWith(
                                color: MyColor.mainWhiteColor,
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                color: isDark
                                    ? const Color(0xff1B1B1B)
                                    : const Color(0xffE9EBF8)),
                            backgroundColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                          child: Text(
                            "Cancel",
                            style: MyStyle.tx14Black.copyWith(
                              color: isDark
                                  ? const Color(0xffDD4848)
                                  : const Color(0xffD93333),
                              fontFamily: 'SF Pro Rounded',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
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
      }),
    );
  }

  String touchPrice({
    required paint.PaintColor paint,
    required paint.PaintColor color,
    required int careIndex,
    required int parkageIndex,
  }) {
    if (careIndex == 0) {
      if (parkageIndex == 2) {
        return (num.parse(color.price15!) + num.parse(paint.price15!))
            .toString();
      } else {
        return paint.price15!;
      }
    } else if (careIndex == 1) {
      if (parkageIndex == 2) {
        return (num.parse(color.price30!) + num.parse(paint.price30!))
            .toString();
      } else {
        return paint.price30!;
      }
    } else {
      if (parkageIndex == 2) {
        return (num.parse(paint.price60!) + num.parse(color.price60!))
            .toString();
      } else {
        return paint.price60!;
      }
    }
  }
}
