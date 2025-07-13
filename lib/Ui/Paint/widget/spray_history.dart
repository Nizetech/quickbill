import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Domain/domain_screen.dart';
import 'package:jost_pay_wallet/Ui/Domain/widget/dot.dart';
import 'package:jost_pay_wallet/Ui/Paint/paint_history.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

import '../../../Models/spray_history_model.dart' as his;

class SprayHistory extends StatelessWidget {
  final his.History history;
  const SprayHistory({
    super.key,
    required this.history,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final isDark = themeProvider.isDarkMode();
    final themedata = Theme.of(context).colorScheme;
    return Consumer<ServiceProvider>(builder: (context, model, _) {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 21,
        ),
        decoration: BoxDecoration(
            color: isDark ? const Color(0xff0D0D0D) : MyColor.mainWhiteColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isDark ? const Color(0xff1B1B1B) : const Color(0xffE9EBF8),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark
                      ? const Color(0xff1B1B1B)
                      : const Color(0xffE9EBF8),
                ),
                color:
                    isDark ? const Color(0xff101010) : const Color(0xffFCFCFC),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        'https://jostpay.com/uploads/${history.image}',
                    height: 68,
                    width: 86,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                                                           SvgPicture.asset(
                    isDark
                        ? 'assets/images/svg/file-dark.svg'
                        : 'assets/images/svg/file.svg',
                  ),
                    errorWidget: (context, url, error) => SvgPicture.asset(
                      isDark
                          ? 'assets/images/svg/file-dark.svg'
                          : 'assets/images/svg/file.svg',
                    ),
                  ),
                  StatusIndicator(
                    text: history.status! == '2' ? "Paid" : "Pending Payment",
                    color: history.status! == '2'
                        ? const Color(0xff0B930B)
                        : const Color(0xffBE843E),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Manage Details Button
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFAAAAAA).withOpacity(0.08), // 8% opacity
                    offset: const Offset(0, 5.05), // x: 0, y: 5.05
                    blurRadius: 8.41,
                    spreadRadius: 0,
                  ),
                ],
              ),
              width: double.infinity,
              child: OutlinedButton(
                onPressed: history.status! == '2'
                    ? null
                    : () {
                        model.payPending(int.parse(history.id!));
                      },
                style: OutlinedButton.styleFrom(
                  side: BorderSide.none,
                  backgroundColor: history.status! != '2'
                      ? MyColor.greenColor
                      : themeProvider.isDarkMode()
                          ? const Color(0xff162A16).withOpacity(0.7)
                          : const Color(0xffE6F2E6).withOpacity(0.7),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                ),
                child: Text("Pay Now",
                    style: MyStyle.tx14Black.copyWith(
                      fontFamily: 'SF Pro Rounded',
                      color: MyColor.mainWhiteColor,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                const Dot(color: MyColor.dark01Color),
                const SizedBox(width: 6),
                Text(
                  "Ref number",
                  style: MyStyle.tx14Grey.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff6E6D7A)),
                )
              ],
            ),
            const SizedBox(height: 6),
            //todo
              Row(
                children: [
                  Text(history.reference!,
                      style: MyStyle.tx16Black.copyWith(
                        fontWeight: FontWeight.w500,
                        color: themedata.tertiary,
                      )),
                  GestureDetector(
                    onTap: () {
                      // Copy to clipboard
                      Clipboard.setData(
                          ClipboardData(text: history.reference!));
                    Fluttertoast.showToast(msg: "Copied to clipboard");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: SvgPicture.asset(
                        isDark
                            ? 'assets/images/svg/copy-dark.svg'
                            : 'assets/images/svg/copy.svg',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
           
            dotTypeTile(
              title1: "Rent type",
              title2: "Car type",
              value: history.rentType!,
              value2: history.carType!,
              isDark: isDark,
            ),
            const SizedBox(height: 22),
            dotTypeTile(
              title1: "Paint type",
              title2: "Date",
              value: history.paintType == '3'
                  ? "No package"
                  : history.paintType == '1'
                      ? "Full Body Paint"
                      : history.paintType == '2'
                          ? 'Touch Up'
                          : 'Color change',
              value2: formatDateYear(history.date!),
              isDark: isDark,
            ),
              const SizedBox(height: 22),
            dotTypeTile(
              title1: "Time",
              title2: "Care Day",
              value: history.time!,
              value2: history.paintType == '2' || history.paintType == '3'
                        ? 'NIL'
                        : "${history.careDay} Days AfterCare",
              isDark: isDark,
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                DotLabel(
                  text: "Painter type",
                  value: history.paintType == '3'
                      ? "Use My Own Painter"
                      : "Company Painter",
                  dotColor: MyColor.dark01Color,
                  labelColor: const Color(0xff6E6D7A),
                  textColor:
                      isDark ? MyColor.mainWhiteColor : MyColor.blackColor,
                ),
              ],
            ),

            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 19),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: isDark
                        ? const Color(0xff1B1B1B)
                        : const Color(0xffE9EBF8),
                    width: 1,
                  ),
                ),
                color:
                    isDark ? const Color(0xff101010) : const Color(0xffFCFCFC),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: MyStyle.tx16Black.copyWith(
                      color: const Color(0xff6E6D7A),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "N${formatNumber(
                      num.parse(history.total!),
                    )}",
                    style: MyStyle.tx16Black.copyWith(
                      color: themedata.tertiary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  model.sprayDetails(int.parse(history.id!));
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: themeProvider.isDarkMode()
                        ? const Color(0xff1B1B1B)
                        : const Color(0xffE9EBF8),
                  ),
                  backgroundColor: themeProvider.isDarkMode()
                      ? const Color(0xff101010)
                      : const Color(0xffFCFCFC),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text("See details",
                    style: MyStyle.tx16Black.copyWith(
                      color: themedata.tertiary,
                      fontWeight: FontWeight.w400,
                    )),
              ),
            ),
          ],
        ),
      );
    });
  }
}


Widget dotTypeTile({
  required bool isDark,
  required String title1,
  required String title2,
  required String value,
  required String value2,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      DotLabel(
        text: title1,
        flex: 3,
        value: value,
        dotColor: MyColor.dark01Color,
        labelColor: const Color(0xff6E6D7A),
        textColor: isDark ? MyColor.mainWhiteColor : MyColor.blackColor,
      ),
      DotLabel(
        flex: 2,
        text: title2,
        value: value2,
        dotColor: MyColor.dark01Color,
        labelColor: const Color(0xff6E6D7A),
        textColor: isDark ? MyColor.mainWhiteColor : MyColor.blackColor,
      ),
    ],
  );
}
