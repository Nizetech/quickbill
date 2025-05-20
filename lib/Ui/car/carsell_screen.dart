import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/car/cardetail_screen.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class CarsellScreen extends StatefulWidget {
  const CarsellScreen({super.key});

  @override
  State<CarsellScreen> createState() => _CarsellScreenState();
}

class _CarsellScreenState extends State<CarsellScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final isDark = themeProvider.isDarkMode();
    final themedata = Theme.of(context).colorScheme;
    return Scaffold(
        backgroundColor: themeProvider.isDarkMode()
            ? MyColor.dark02Color
            : MyColor.mainWhiteColor,
        body: Padding(
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
                      'Autolot7 Motors',
                      style:
                          MyStyle.tx18Black.copyWith(color: themedata.tertiary),
                    ),
                  ),
                  const Spacer(), // Adds flexible space after the text
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: 3,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 18),
                  itemBuilder: (context, index) {
                    if (index == 2) {
                      return const SizedBox(
                        height: 100,
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CardetailScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            bottom: 15, right: 11, left: 13, top: 28),
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
                            Align(
                                alignment: Alignment.center,
                                child: Image.asset("assets/images/car.png")),
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
                                Text("2022 Toyota Camry S-Class",
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
                                    padding: const EdgeInsets.symmetric(
                                            horizontal: 8)
                                        .copyWith(right: 8),
                                    decoration: BoxDecoration(
                                      color: themeProvider.isDarkMode()
                                          ? const Color(0xff0D0D0D)
                                          : MyColor.mainWhiteColor,
                                      borderRadius: BorderRadius.circular(999),
                                      border: Border.all(
                                          color: themeProvider.isDarkMode()
                                              ? MyColor.outlineDasheColor
                                                  .withOpacity(0.25)
                                              : const Color(0xffE9EBF8),
                                          width: 0.7),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                    isDark
                                        ? "assets/images/svg/speed-dark.svg"
                                        : "assets/images/svg/speed.svg",
                                    "50 Miles"),
                                _buildFeature("assets/images/svg/engine.svg",
                                    "Automatic"),
                                _buildFeature(
                                    isDark
                                        ? "assets/images/svg/petrol-dark.svg"
                                        : "assets/images/svg/petrol.svg",
                                    "Petrol"),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: _buildFeature(
                                      isDark
                                          ? "assets/images/svg/hp-dark.svg"
                                          : "assets/images/svg/hp.svg",
                                      "400 HP"),
                                ),
                              ],
                            ),

                            const SizedBox(height: 18),
                            Text(
                              "N1,200,000",
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
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide.none,
                                  backgroundColor: themeProvider.isDarkMode()
                                      ? const Color(0xff0B930B)
                                      : MyColor.greenColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 14),
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
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  side: BorderSide(
                                      color: themeProvider.isDarkMode()
                                          ? const Color(0xff0B930B)
                                          : MyColor.greenColor,
                                      width: 0.6),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 14),
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
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildFeature(String icon, String text) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDark = themeProvider.isDarkMode();
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
