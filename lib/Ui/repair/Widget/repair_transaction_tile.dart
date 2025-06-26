import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Models/repair_transaction.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Domain/widget/dot.dart';
import 'package:jost_pay_wallet/Ui/Paint/paint_history.dart';
import 'package:jost_pay_wallet/Ui/Paint/widget/spray_history.dart';
import 'package:jost_pay_wallet/Ui/repair/repairsteps_screen.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/utils.dart';
import 'package:provider/provider.dart';

class RepairTransactionTile extends StatelessWidget {
  final RepairList repairTile;
  const RepairTransactionTile({super.key, required this.repairTile});

  @override
  Widget build(BuildContext context) {
    String imageBaseUrl =
        "https://smanager.jostpay.com/assets/media/uploads/auto_repair/vehicle_photo/";
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final isDark = themeProvider.isDarkMode();
    final themedata = Theme.of(context).colorScheme;
    return Consumer<ServiceProvider>(builder: (context, model, _) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 21),
        decoration: BoxDecoration(
            color: isDark ? const Color(0xff0D0D0D) : MyColor.mainWhiteColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isDark ? const Color(0xff1B1B1B) : const Color(0xffE9EBF8),
            )),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color:
                    isDark ? const Color(0xff1B1B1B) : const Color(0xffE9EBF8),
              ),
              color: isDark ? const Color(0xff101010) : const Color(0xffFCFCFC),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CachedNetworkImage(
                  imageUrl: repairTile.photo == null
                      ? ''
                      : '$imageBaseUrl${repairTile.photo}',
                  height: 68,
                  width: 86,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => SvgPicture.asset(
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
                  text: repairTile.invoiceStatus! == '1'
                      ? "Pending Payment"
                      : "Paid",
                  color: repairTile.invoiceStatus! != '1'
                      ? MyColor.greenColor
                      : isDark
                          ? const Color(0xffBE843E)
                          : const Color(0xffAB7738),
                )
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
              onPressed: repairTile.worksNotPaid! == '0' ? null : () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide.none,
                backgroundColor: repairTile.invoiceStatus! != '1' ||
                        repairTile.worksNotPaid! == '0'
                    ? MyColor.greenColor.withValues(alpha: .08)
                    : themeProvider.isDarkMode()
                        ? const Color(0xff0B930B)
                        : MyColor.greenColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              ),
              child: Text(repairTile.invoiceStatus! != '1' ? "paid" : "Pay Now",
                  style: MyStyle.tx14Black.copyWith(
                    fontFamily: 'SF Pro Rounded',
                    color: repairTile.invoiceStatus! != '1'
                        ? MyColor.grey02Color
                        : MyColor.mainWhiteColor,
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
          Row(
            children: [
              Text(repairTile.reference!,
                  style: MyStyle.tx16Black.copyWith(
                    fontWeight: FontWeight.w500,
                    color: themedata.tertiary,
                  )),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: repairTile.reference!));
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
            title1: "Service type",
            title2: "Automobile",
            value: repairTile.repairType!,
            value2: repairTile.vehicleModel!,
            isDark: isDark,
          ),
          const SizedBox(height: 22),
          dotTypeTile(
            title1: "Status",
            title2: "Date",
            value: repairTile.vehicleStatus!,
            value2: formatDateYear(repairTile.createdAt!),
            isDark: isDark,
          ),

          if (repairTile.amount != '0')
            Container(
              margin: EdgeInsets.only(top: 20),
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
                    "${Utils.naira}${formatNumber(
                      num.parse(repairTile.amount!),
                    )}",
                    style: MyStyle.tx16Black.copyWith(
                      color: themedata.tertiary,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide.none,
                backgroundColor: const Color(0xff12B76A).withOpacity(0.09),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text(
                  repairTile.status! == '1'
                      ? "Awaiting arrival"
                      : repairTile.status! == '2'
                          ? "Vehicle Towed"
                          : repairTile.status! == '3'
                              ? "Vehicle In Yard"
                              : repairTile.status == '4'
                                  ? "Ready For Pick Up"
                                  : "Vehicle Picked",
                  style: MyStyle.tx16Black.copyWith(
                    color:
                        isDark ? const Color(0xff0B930B) : MyColor.greenColor,
                    fontWeight: FontWeight.w400,
                  )),
            ),
          ),
          const SizedBox(height: 16),
          Opacity(
            opacity: repairTile.worksNotPaid! == '0' ? .4 : 1,
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: repairTile.worksNotPaid! == '0'
                    ? null
                    : () {
                        model.getRepairDetails(repairTile.id.toString(),
                            callback: () {
                          Get.to(RepairstepsScreen(
                            repairId: repairTile.id.toString(),
                          ));
                        });
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
                child: Text("See repair details",
                    style: MyStyle.tx16Black.copyWith(
                      color: themedata.tertiary,
                      fontWeight: FontWeight.w400,
                    )),
              ),
            ),
          ),
        ]),
      );
    });
  }
}
