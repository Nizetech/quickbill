import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class PaintInvoiceScreen extends StatefulWidget {
  final int historyId;
  const PaintInvoiceScreen({super.key, required this.historyId});

  @override
  State<PaintInvoiceScreen> createState() => _PaintInvoiceScreenState();
}

class _PaintInvoiceScreenState extends State<PaintInvoiceScreen> {
  num total = 0;
  num colorChangePrice = 0;
  num pendingPrice = 0;
  @override
  void initState() {
    super.initState();
    final model = Provider.of<ServiceProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var totalPrice = model.sprayDetailsModel!.data!.fold<num>(
        0,
        (prev, item) {
          String? priceString;
          if (item.extraFee != null) {
            priceString = item.extraFee;
          } else if (item.careDay != null &&
              model.sprayDetailsModel!.check!.paintType != '2') {
            if (item.careDay == '15') {
              priceString = item.price15;
            } else if (item.careDay == '30') {
              priceString = item.price30;
            } else if (item.careDay == '60') {
              priceString = item.price60;
            } else {
              priceString = item.price;
            }
          } else {
            priceString = item.price;
          }
          return prev + num.parse(priceString ?? '0');
        },
      );
      if (model.sprayDetailsModel!.data!
          .any((data) => data.status == '1' || data.extraFee != null)) {
        pendingPrice = model.sprayDetailsModel!.data!.fold<num>(
          0,
          (prev, item) {
            return prev +
                num.parse(
                    item.extraFee == null ? item.price ?? '0' : item.extraFee!);
          },
        );
      }
      if (model.sprayDetailsModel!.check!.paintType == '5') {
        if (model.sprayDetailsModel!.check!.careDay != null) {
          setState(() {
            if (model.sprayDetailsModel!.check!.careDay == '15') {
              colorChangePrice =
                  num.parse(model.sprayDetailsModel!.color!.price15!);
            } else if (model.sprayDetailsModel!.check!.careDay == '30') {
              colorChangePrice =
                  num.parse(model.sprayDetailsModel!.color!.price30!);
            } else {
              colorChangePrice =
                  num.parse(model.sprayDetailsModel!.color!.price60!);
            }
            total = totalPrice +
                colorChangePrice +
                num.parse(model.sprayDetailsModel!.check!.price!);
          });
        }
      } else {
        setState(() {
          total =
              totalPrice + num.parse(model.sprayDetailsModel!.check!.price!);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    final isDark = themeProvider.isDarkMode();
    log('pendingPrice: $pendingPrice');
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode()
          ? MyColor.dark02Color
          : MyColor.mainWhiteColor,
      body: Consumer<ServiceProvider>(builder: (context, model, _) {
        log("model: ${model.sprayDetailsModel!.toJson()}");
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
                      'Paint Invoice',
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
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 29),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: themeProvider.isDarkMode()
                                ? const Color(0xff1B1B1B)
                                : const Color(0xffE9EBF8),
                          ),
                          color: themeProvider.isDarkMode()
                              ? const Color(0xff101010)
                              : const Color(0xffFCFCFC),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (model.sprayDetailsModel!.check!.paintType ==
                                '5') ...[
                              Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Color Change',
                                          style: MyStyle.tx16Black.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xff6E6D7A)),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          model.sprayDetailsModel!.check!
                                                      .status ==
                                                  '2'
                                              ? "Paid"
                                              : "Pending",
                                          style: MyStyle.tx12Black.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: model.sprayDetailsModel!
                                                        .check!.status ==
                                                    '2'
                                                ? MyColor.greenColor
                                                : MyColor.redColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                  child: Text(
                                      model.sprayDetailsModel!.check!.careDay ==
                                              '15'
                                          ? "NGN ${formatNumber(num.parse(model.sprayDetailsModel!.color!.price15!))}"
                                          : model.sprayDetailsModel!.check!
                                                      .careDay ==
                                                  '30'
                                              ? "NGN ${formatNumber(num.parse(model.sprayDetailsModel!.color!.price30!))}"
                                              : "NGN ${formatNumber(num.parse(model.sprayDetailsModel!.color!.price60!))}",
                                      textAlign: TextAlign.right,
                                      style: MyStyle.tx16Black.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: themedata.tertiary),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Divider(
                                height: 1,
                                color: isDark
                                    ? const Color(0xff1B1B1B)
                                    : const Color(0xffE9EBF8),
                              ),
                              SizedBox(height: 10),
                            ],
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        model.sprayDetailsModel!.check!
                                            .rentType!,
                                        style: MyStyle.tx16Black.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff6E6D7A)),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        
                                        "Paid",
                                        style: MyStyle.tx12Black.copyWith(
                                          fontWeight: FontWeight.w600,
                                            color: MyColor.greenColor
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    "NGN ${formatNumber(num.parse(model.sprayDetailsModel!.check!.price!))}",
                                    textAlign: TextAlign.right,
                                    style: MyStyle.tx16Black.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: themedata.tertiary),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Divider(
                              height: 1,
                              color: isDark
                                  ? const Color(0xff1B1B1B)
                                  : const Color(0xffE9EBF8),
                            ),
                            SizedBox(height: 10),
                            ListView.separated(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: model.sprayDetailsModel!.data!.length,
                              separatorBuilder: (context, index) =>
                                  const Padding(
                                padding:
                                    EdgeInsets.symmetric(vertical: 10),
                                child: Divider(
                                  height: 1,
                                  color: Color(0xffE9EBF8),
                                ),
                              ),
                              itemBuilder: (_, i) {
                                final data = model.sprayDetailsModel!.data![i];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.status == '1' ||
                                                    data.description != null
                                                ? data.description
                                                : data.name ?? "",
                                            style: MyStyle.tx16Black.copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xff6E6D7A)),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            data.status == '2'
                                                ? "Paid"
                                                : "Pending",
                                            style: MyStyle.tx12Black.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: data.status == '2'
                                                  ? MyColor.greenColor
                                                  : MyColor.redColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        data.status == '1' ||
                                                data.extraFee != null
                                            ? "NGN ${formatNumber(num.parse(data.extraFee == null ? '0' : data.extraFee!))}"
                                            : data.careDay != null &&
                                                    model.sprayDetailsModel!
                                                            .check!.paintType !=
                                                        '2'
                                                ? data.careDay == '15'
                                                    ? "NGN ${formatNumber(num.parse(data.price == null ? '0' : data.price15!))}"
                                                    : data.careDay == '30'
                                                        ? "NGN ${formatNumber(num.parse(data.price == null ? '0' : data.price30!))}"
                                                        : data.careDay == '60'
                                                            ?
                                                            "NGN ${formatNumber(num.parse(data.price == null ? '0' : data.price60!))}"
                                                        : "NGN ${formatNumber(num.parse(data.price == null ? '0' : data.price!))}"
                                                : "NGN ${formatNumber(num.parse(data.price == null ? '0' : data.price!))}",
                                        style: MyStyle.tx16Black.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: themedata.tertiary),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 19),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Cost",
                              style: MyStyle.tx16Black.copyWith(
                                color: const Color(0xff6E6D7A),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "N ${formatNumber(total)}",
                              style: MyStyle.tx16Black.copyWith(
                                color: themedata.tertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: isDark
                            ? const Color(0xff1B1B1B)
                            : const Color(0xffE9EBF8),
                      ),
                      const SizedBox(height: 100),
                      OutlinedButton(
                        onPressed: () {
                          model.getPdfReceipt(widget.historyId);
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide.none,
                          backgroundColor: themeProvider.isDarkMode()
                              ? const Color(0xff0B930B)
                              : MyColor.greenColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 11),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/svg/share.svg",
                              color: MyColor.mainWhiteColor,
                            ),
                            const SizedBox(width: 12),
                            Text("Share invoice",
                                style: MyStyle.tx14Black.copyWith(
                                  fontFamily: 'SF Pro Rounded',
                                  color: MyColor.mainWhiteColor,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            side: BorderSide(
                                color: themeProvider.isDarkMode()
                                    ? const Color(0xff0B930B)
                                    : MyColor.greenColor,
                                width: 0.6),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 13),
                          ),
                          child: Text("Back to Paint history",
                              style: MyStyle.tx14Black.copyWith(
                                fontFamily: 'SF Pro Rounded',
                                color: themeProvider.isDarkMode()
                                    ? const Color(0xff0B930B)
                                    : MyColor.greenColor,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ),
                      const SizedBox(height: 40),
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
}
