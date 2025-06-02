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
  const PaintInvoiceScreen({super.key});

  @override
  State<PaintInvoiceScreen> createState() => _PaintInvoiceScreenState();
}

class _PaintInvoiceScreenState extends State<PaintInvoiceScreen> {
  num total = 0;
  @override
  void initState() {
    super.initState();
    final model = Provider.of<ServiceProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var totalPrice = model.sprayDetailsModel!.data!.fold<num>(
        0,
        (prev, item) =>
            prev +
            num.parse(
              (item.extraFee != null && item.extraFee!.isNotEmpty)
                  ? item.extraFee!
                  : item.price!,
            ),
      );
      setState(() {
        total = totalPrice + num.parse(model.sprayDetailsModel!.check!.price!);
      });
    });
  }

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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    model.sprayDetailsModel!.check!.rentType!,
                                    style: MyStyle.tx16Black.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff6E6D7A)),
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
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: const Divider(
                                  height: 1,
                                  color: Color(0xffE9EBF8),
                                ),
                              ),
                              itemBuilder: (_, i) {
                                final data = model.sprayDetailsModel!.data![i];
                                log('Data:===> ${data.extraFee}, status: ${data.status}');
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        data.status == '1'
                                            ? data.description
                                            : data.name ?? "",
                                        style: MyStyle.tx16Black.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff6E6D7A)),
                                      ),
                                      Text(
                                        data.status == '1'
                                            ? "NGN ${formatNumber(num.parse(data.extraFee!))}"
                                            : "NGN ${formatNumber(num.parse(data.price!))}",
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
                              // "N ${formatNumber(num.parse(model.sprayDetailsModel!.check!.total!))}",
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
                      const SizedBox(height: 137),
                      OutlinedButton(
                        onPressed: () {},
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
