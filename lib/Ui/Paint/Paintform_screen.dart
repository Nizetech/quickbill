import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Domain/domain_screen.dart';
import 'package:jost_pay_wallet/Ui/Paint/paint_history.dart';
import 'package:jost_pay_wallet/Ui/car/repair_screen.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

class PaintformScreen extends StatefulWidget {
  const PaintformScreen({super.key});

  @override
  State<PaintformScreen> createState() => _PaintformScreenState();
}

class _PaintformScreenState extends State<PaintformScreen> {
  String package = "Color Change";
  @override
  void initState() {
    super.initState();
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
                    const CustomTextField(
                      text: "Use Company Painter",
                      suffixIcon: Icons.expand_more,
                    ),
                    const SizedBox(
                      height: 31,
                    ),
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
                    DropdownButtonHideUnderline(
                      child: Container(
                        height: 53,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: isDark ? MyColor.dark02Color : Colors.white,
                          border: Border.all(
                            color: isDark
                                ? const Color(0xff1B1B1B)
                                : const Color(0xffE9EBF8),
                            width: 1.2,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: DropdownButton<String>(
                          value: package,
                          icon: const Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Icon(Icons.expand_more,
                                size: 22, color: Colors.grey),
                          ),
                          dropdownColor: isDark
                              ? const Color(0xff181818)
                              : const Color(0xffFCFCFC),
                          selectedItemBuilder: (context) {
                            return [
                              "Full Body Painting",
                              "Touch-up",
                              "Color Change"
                            ].map((e) {
                              return Center(
                                child: Text(
                                  e,
                                  style: MyStyle.tx14Black.copyWith(
                                    color: themedata.tertiary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList();
                          },
                          items: [
                            "Full Body Painting",
                            "Touch-up",
                            "Color Change"
                          ].map((e) {
                            return DropdownMenuItem<String>(
                              value: e,
                              child: Text(
                                e,
                                style: MyStyle.tx14Black.copyWith(
                                  color: const Color(0xff6B7280),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              if (val != null) {
                                package = val;
                              }
                            });
                          },
                        ),
                      ),
                    ),
                    // const CustomTextField(
                    //   text: "Color Change",
                    //   suffixIcon: Icons.expand_more,
                    // ),
                    if (package != 'Touch-up') ...[
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
                      const CustomTextField(
                        text: "15 days After care",
                        suffixIcon: Icons.expand_more,
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
                                package != 'Touch-up'
                                    ? "Full Body Package"
                                    : "Touch-up package",
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
                    if (package != 'Touch-up') ...[
                      PaintPackages(
                          isDark: isDark,
                          price: "N30,000",
                          themedata: themedata,
                          themeProvider: themeProvider),
                      const SizedBox(
                        height: 16,
                      ),
                      PaintPackages(
                          isDark: isDark,
                          price: "N40,000",
                          themedata: themedata,
                          themeProvider: themeProvider),
                      const SizedBox(
                        height: 16,
                      ),
                      PaintPackages(
                          isDark: isDark,
                          price: "N70,000",
                          themedata: themedata,
                          themeProvider: themeProvider),
                      const SizedBox(
                        height: 58,
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: isDark
                                  ? MyColor.dark02Color
                                  : MyColor.mainWhiteColor,
                            ),
                            child: TouchupOptions(isDark: isDark),
                          ))
                    ],
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
                        Text("N30,000",
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PaintHistory(),
                            ),
                          );
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
                        child: Text("Cancel",
                            style: MyStyle.tx14Black.copyWith(
                              color: isDark
                                  ? const Color(0xffDD4848)
                                  : const Color(0xffD93333),
                              fontFamily: 'SF Pro Rounded',
                              fontWeight: FontWeight.w500,
                            )),
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
      ),
    );
  }
}

class TouchupOptions extends StatelessWidget {
  const TouchupOptions({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          checkColor: MyColor.mainWhiteColor,
          activeColor: isDark ? const Color(0xff0B930B) : MyColor.greenColor,
          side: BorderSide(color: const Color(0xffD1D1D1)),
          value: false,
          onChanged: (value) {},
        ),
        Text(
          "data",
          style: MyStyle.tx12Black.copyWith(
              color: isDark ? MyColor.mainWhiteColor : const Color(0xff6B7280),
              fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}

class PaintPackages extends StatelessWidget {
  const PaintPackages({
    super.key,
    required this.isDark,
    required this.price,
    required this.themedata,
    required this.themeProvider,
  });

  final bool isDark;
  final String price;
  final ColorScheme themedata;
  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark ? const Color(0xff1B1B1B) : const Color(0xffE9EBF8),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 18),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color:
                    isDark ? const Color(0xff131313) : const Color(0xffF9F9F9)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 27, vertical: 8),
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
                    "Kapci",
                    style: MyStyle.tx14White.copyWith(
                        color: themedata.tertiary,
                        fontSize: 10,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 31,
                ),
                Row(
                  children: [
                    Text(price,
                        style: MyStyle.tx32Black.copyWith(
                          fontWeight: FontWeight.w600,
                          color: themedata.tertiary,
                        )),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 6),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xff162A16)
                            : const Color(0xffE6F2E6),
                        borderRadius: BorderRadius.circular(666),
                      ),
                      child: Center(
                        child: Text(
                          "Popular",
                          style: MyStyle.tx14Green.copyWith(
                              fontSize: 10,
                              color: isDark
                                  ? const Color(0xff0B930B)
                                  : MyColor.greenColor,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 13,
          ),
          Text(
            "Premium, high-quality paint with excellent durability",
            style: MyStyle.tx16Black.copyWith(
                fontWeight: FontWeight.w400, color: const Color(0xff6B7280)),
          ),
          const SizedBox(
            height: 18,
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide.none,
                backgroundColor: themeProvider.isDarkMode()
                    ? const Color(0xff0B930B)
                    : MyColor.greenColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text("Select Package",
                  style: MyStyle.tx14Black.copyWith(
                    fontFamily: 'SF Pro Rounded',
                    color: MyColor.mainWhiteColor,
                    fontWeight: FontWeight.w500,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
