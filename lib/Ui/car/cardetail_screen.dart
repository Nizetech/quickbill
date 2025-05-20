import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class CardetailScreen extends StatefulWidget {
  const CardetailScreen({super.key});

  @override
  State<CardetailScreen> createState() => _CardetailScreenState();
}

class _CardetailScreenState extends State<CardetailScreen> {
  String mainImg = 'assets/images/main-car.png';
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final isDark = themeProvider.isDarkMode();
    final width = (MediaQuery.of(context).size.width -
            MediaQuery.of(context).padding.horizontal) -
        55;
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

            // Main Car Image

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),

                    Text(
                      "2013 Ford Escape Titanium",
                      style: MyStyle.tx18Grey.copyWith(
                        fontWeight: FontWeight.w500,
                        color: themedata.tertiary,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //
                    ClipRRect(
                      child: Image.asset(
                        mainImg,
                        height: 243,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 2),

                    // Thumbnail Row
                    SizedBox(
                      height: 80,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3, // Number of thumbnails
                        separatorBuilder: (_, __) => const SizedBox(width: 2),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (index == 0) {
                                setState(() {
                                  selectedIndex = index;
                                  // Update the main image to the first thumbnail
                                  mainImg = 'assets/images/main-car.png';
                                });
                                // Handle thumbnail tap
                              } else {
                                setState(() {
                                  selectedIndex = index;
                                  // Update the main image based on the thumbnail tapped
                                  mainImg = 'assets/images/car${index + 1}.png';
                                });
                              }
                            },
                            child: Container(
                              width: width / 3,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedIndex == index
                                      ? isDark
                                          ? const Color(0xff0B930B)
                                          : MyColor.splashBtn
                                      : Colors.transparent,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(2.4),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(2.19),
                                child: Image.asset(
                                  'assets/images/car${index + 1}.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        border: Border(
                          top: BorderSide(
                            color: isDark
                                ? const Color(0xff1B1B1B)
                                : const Color(0xffE9EBF8),
                            width: 1.0,
                          ),
                          left: BorderSide(
                            color: isDark
                                ? const Color(0xff1B1B1B)
                                : const Color(0xffE9EBF8),
                            width: 1.0,
                          ),
                          right: BorderSide(
                            color: isDark
                                ? const Color(0xff1B1B1B)
                                : const Color(0xffE9EBF8),
                            width: 1.0,
                          ),
                          bottom: BorderSide(
                            color: isDark
                                ? const Color(0xff1B1B1B)
                                : const Color(0xffE9EBF8),
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                            child: Text(
                              "Key Specs",
                              style: MyStyle.tx18Grey.copyWith(
                                fontWeight: FontWeight.w500,
                                color: themedata.tertiary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Specs List
                          _buildSpecRow("Exterior color", "Pearl White Multi"),
                          _buildSpecRow("Accidents or damage", "No Reported"),
                          _buildSpecRow("Drive train", "All-wheel drive"),
                          _buildSpecRow("Transmission", "1-Speed automatic"),
                          _buildSpecRow("Engine", "Electric"),
                          _buildSpecRow("VIN", "747848648649569"),
                          _buildSpecRow("Mileage", "65,238 mi"),
                          _buildSpecRow("Seating", "Leather seat, memory seat"),
                          _buildSpecRow("1-Owner vehicle", "Yes"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Buttons
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: themeProvider.isDarkMode()
                                ? const Color(0xff131313)
                                : const Color(0xffF9F9F9),
                            side: BorderSide(
                                color: themeProvider.isDarkMode()
                                    ? const Color(0xff1B1B1B)
                                    : const Color(0xffE9EBF8),
                                width: 0.6),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 21, vertical: 12),
                          ),
                          child: Text("Schedule Inspection",
                              style: MyStyle.tx14Black.copyWith(
                                fontFamily: 'SF Pro Rounded',
                                color: themeProvider.isDarkMode()
                                    ? MyColor.mainWhiteColor
                                    : MyColor.dark01Color,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                        const SizedBox(width: 23),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: BorderSide.none,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: themeProvider.isDarkMode()
                                  ? const Color(0xff0B930B)
                                  : MyColor.greenColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 38, vertical: 12),
                            ),
                            child: Text("Buy Now",
                                style: MyStyle.tx14Black.copyWith(
                                  fontFamily: 'SF Pro Rounded',
                                  color: MyColor.mainWhiteColor,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            )
            // Key Specs Header
          ],
        ),
      ),
    );
  }

  Widget _buildSpecRow(String title, String value) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);

    final isDark = themeProvider.isDarkMode();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark ? const Color(0xff1B1B1B) : const Color(0xffE9EBF8),
            width: 0.5,
          ),
        ),
      ),
      padding: const EdgeInsets.only(right: 3, left: 7, top: 18, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: MyStyle.tx14Green.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color:
                    isDark ? const Color(0xffD8DDF0) : const Color(0xff0F1427)),
          ),
          const SizedBox(width: 10),
          Text(value,
              style: MyStyle.tx14Grey.copyWith(color: MyColor.grey02Color)),
        ],
      ),
    );
  }
}
