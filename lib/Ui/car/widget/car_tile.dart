import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jost_pay_wallet/Models/car_listing.dart';
import 'package:jost_pay_wallet/Provider/service_provider.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/car/buy_car_summary.dart';
import 'package:jost_pay_wallet/Ui/car/schedule_inspection.dart';
import 'package:jost_pay_wallet/Values/Helper/helper.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:jost_pay_wallet/Values/utils.dart';
import 'package:provider/provider.dart';

class CarTile extends StatelessWidget {
  final Car car;
  const CarTile({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final model = context.watch<ServiceProvider>();
    final isDark = themeProvider.isDarkMode();
    return GestureDetector(
      onTap: () {
        model.getCarDetails(car.id!);
      },
      child: Container(
        padding:
            const EdgeInsets.only(bottom: 15, right: 11, left: 13, top: 28),
        decoration: BoxDecoration(
          color: themeProvider.isDarkMode()
              ? const Color(0xff101010)
              : const Color(0xffFCFCFC),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: themeProvider.isDarkMode()
                  ? MyColor.outlineDasheColor.withOpacity(0.25)
                  : const Color(0xffE9EBF8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: car.carImage!,
                // height: 68,
                // width: 86,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(),
                errorWidget: (context, url, error) => Container(),
              ),
            ),

            const SizedBox(height: 12),
            Divider(
              color: themeProvider.isDarkMode()
                  ? MyColor.outlineDasheColor.withOpacity(0.25)
                  : const Color(0xffE9EBF8),
              thickness: 0.6,
            ),
            const SizedBox(height: 15),
            // Services and SSL
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(car.title!,
                    style: MyStyle.tx18Black.copyWith(
                      color: themeProvider.isDarkMode()
                          ? MyColor.mainWhiteColor
                          : const Color(0xff000000),
                      fontWeight: FontWeight.w600,
                    )),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 30,
                    padding: const EdgeInsets.symmetric(horizontal: 8)
                        .copyWith(right: 8),
                    decoration: BoxDecoration(
                      color: themeProvider.isDarkMode()
                          ? const Color(0xff0D0D0D)
                          : MyColor.mainWhiteColor,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                          color: themeProvider.isDarkMode()
                              ? MyColor.outlineDasheColor.withOpacity(0.25)
                              : const Color(0xffE9EBF8),
                          width: 0.7),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Details",
                            style: MyStyle.tx14Black.copyWith(
                              fontFamily: 'SF Pro Rounded',
                              color: isDark
                                  ? const Color(0xffCBD2EB)
                                  : MyColor.blackColor,
                              fontWeight: FontWeight.w500,
                            )),
                        const SizedBox(width: 8),
                        SvgPicture.asset(
                          "assets/images/svg/link.svg",
                          height: 14,
                          width: 14,
                          color: isDark
                              ? const Color(0xffCBD2EB)
                              : MyColor.blackColor,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Divider(
              color: themeProvider.isDarkMode()
                  ? MyColor.outlineDasheColor.withOpacity(0.25)
                  : const Color(0xffE9EBF8),
              thickness: 0.6,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 40, // horizontal space between columns
              runSpacing: 20, // vertical space between rows
              children: [
                _buildFeature(
                    isDark: isDark,
                    isDark
                        ? "assets/images/svg/speed-dark.svg"
                        : "assets/images/svg/speed.svg",
                    car.mileage!),
                _buildFeature(
                    isDark: isDark,
                    "assets/images/svg/engine.svg",
                    car.transmission!),
                _buildFeature(
                    isDark: isDark,
                    isDark
                        ? "assets/images/svg/petrol-dark.svg"
                        : "assets/images/svg/petrol.svg",
                    car.fuel!),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: _buildFeature(
                      isDark: isDark,
                      isDark
                          ? "assets/images/svg/hp-dark.svg"
                          : "assets/images/svg/hp.svg",
                      car.model!),
                ),
              ],
            ),

            const SizedBox(height: 18),
            Text(
              "${Utils.naira} ${formatNumber(num.parse(car.price!))}",
              style: MyStyle.tx16Black.copyWith(
                  fontSize: 26,
                  color: isDark
                      ? MyColor.mainWhiteColor
                      : const Color(0xff000000)),
            ),

            const SizedBox(height: 15),
            // Manage Details Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => BuyCarSummary(
                      data: {
                        "id": car.id,
                        "image": car.carImage!,
                        "title": car.title,
                        "price": car.price,
                      },
                    )),
                style: OutlinedButton.styleFrom(
                  side: BorderSide.none,
                  backgroundColor: themeProvider.isDarkMode()
                      ? const Color(0xff0B930B)
                      : MyColor.greenColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
                child: Text("Buy Now",
                    style: MyStyle.tx14Black.copyWith(
                      fontFamily: 'SF Pro Rounded',
                      color: MyColor.mainWhiteColor,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => ScheduleInspection(
                      data: {
                        "image": car.carImage!,
                        "id": car.id,
                        "title": car.title,
                      },
                    )),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  side: BorderSide(
                      color: themeProvider.isDarkMode()
                          ? const Color(0xff0B930B)
                          : MyColor.greenColor,
                      width: 0.6),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
                child: Text("Schedule an inspection",
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
    );
  }

  Widget _buildFeature(String icon, String text, {required bool isDark}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          icon,
        ),
        const SizedBox(width: 8),
        Text(text,
            style: MyStyle.tx14Grey.copyWith(
              color: isDark ? const Color(0xffCBD2EB) : MyColor.blackColor,
              fontWeight: FontWeight.w400,
            )),
      ],
    );
  }
}
