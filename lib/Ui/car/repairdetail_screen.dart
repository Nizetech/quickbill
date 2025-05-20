import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Domain/domain_screen.dart';
import 'package:jost_pay_wallet/Ui/car/cardetail_screen.dart';
import 'package:jost_pay_wallet/Ui/car/repair_screen.dart';
import 'package:jost_pay_wallet/Ui/car/repairsteps_screen.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class RepairdetailScreen extends StatefulWidget {
  const RepairdetailScreen({super.key});

  @override
  State<RepairdetailScreen> createState() => _RepairdetailScreenState();
}

class _RepairdetailScreenState extends State<RepairdetailScreen> {
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
                      'Repair',
                      style:
                          MyStyle.tx18Black.copyWith(color: themedata.tertiary),
                    ),
                  ),
                  const Spacer(), // Adds flexible space after the text
                ],
              ),
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(children: [
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 19),
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
                    "Repair/Service History",
                    style: MyStyle.tx20Grey.copyWith(
                      fontWeight: FontWeight.w400,
                      color: themedata.tertiary,
                    ),
                  ),
                ),
                const SizedBox(height: 17),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RepairScreen(),
                      ),
                    );
                  },
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
                            'assets/images/svg/appointment.svg',
                            color: isDark
                                ? MyColor.dark02Color
                                : MyColor.mainWhiteColor,
                          ),
                        ),
                        const SizedBox(width: 11),
                        Text("Schedule Appointment/Pick Up",
                            style: MyStyle.tx16Black.copyWith(
                              fontWeight: FontWeight.w400,
                              color: themedata.tertiary,
                            )),
                        const SizedBox(width: 10),
                        SvgPicture.asset(
                          'assets/images/svg/line.svg',
                          width: 28,
                          color: isDark ? MyColor.mainWhiteColor : Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 21,
                  ).copyWith(top: 9),
                  decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xff0D0D0D)
                          : MyColor.mainWhiteColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isDark
                            ? const Color(0xff1B1B1B)
                            : const Color(0xffE9EBF8),
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
                            color: isDark
                                ? const Color(0xff101010)
                                : const Color(0xffFCFCFC),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                scale: 1.4,
                                "assets/images/auto.png",
                              ),
                              StatusIndicator(
                                text: "Pending Payment",
                                color: isDark
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
                                color: Color(0xFFAAAAAA)
                                    .withOpacity(0.08), // 8% opacity
                                offset: const Offset(0, 5.05), // x: 0, y: 5.05
                                blurRadius: 8.41,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: BorderSide.none,
                              backgroundColor: themeProvider.isDarkMode()
                                  ? const Color(0xff0B930B)
                                  : MyColor.greenColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 10),
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
                        Row(
                          children: [
                            Text("420516-51443-7897-SPR",
                                style: MyStyle.tx16Black.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: themedata.tertiary,
                                )),
                            GestureDetector(
                              onTap: () {
                                // Copy to clipboard
                                Clipboard.setData(const ClipboardData(
                                    text: "420516-51443-7897-SPR"));
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
                        Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DotLabel(
                                text: "Service type",
                                value: "Vehicle repair",
                                dotColor: MyColor.dark01Color,
                                labelColor: const Color(0xff6E6D7A),
                                textColor: isDark
                                    ? MyColor.mainWhiteColor
                                    : MyColor.blackColor,
                              ),
                              DotLabel(
                                text: "Automobile",
                                dotColor: MyColor.dark01Color,
                                value: "Mazda C9 2009",
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
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DotLabel(
                                text: "Status",
                                value: "Run & Drive",
                                dotColor: MyColor.dark01Color,
                                labelColor: const Color(0xff6E6D7A),
                                textColor: isDark
                                    ? MyColor.mainWhiteColor
                                    : MyColor.blackColor,
                              ),
                              DotLabel(
                                text: "Date",
                                value: "12th, Dec 2025",
                                dotColor: MyColor.dark01Color,
                                labelColor: const Color(0xff6E6D7A),
                                textColor: isDark
                                    ? MyColor.mainWhiteColor
                                    : MyColor.blackColor,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 19),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: isDark
                                    ? const Color(0xff1B1B1B)
                                    : const Color(0xffE9EBF8),
                                width: 1,
                              ),
                            ),
                            color: isDark
                                ? const Color(0xff101010)
                                : const Color(0xffFCFCFC),
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
                                "N200,000",
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
                              backgroundColor:
                                  const Color(0xff12B76A).withOpacity(0.09),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                            child: Text("Awaiting arrival",
                                style: MyStyle.tx16Black.copyWith(
                                  color: isDark
                                      ? const Color(0xff0B930B)
                                      : MyColor.greenColor,
                                  fontWeight: FontWeight.w400,
                                )),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return const RepairstepsScreen();
                                },
                              ));
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                            child: Text("See repair details",
                                style: MyStyle.tx16Black.copyWith(
                                  color: themedata.tertiary,
                                  fontWeight: FontWeight.w400,
                                )),
                          ),
                        ),
                      ]),
                ),
                const SizedBox(height: 34),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 21,
                  ).copyWith(top: 9),
                  decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xff0D0D0D)
                          : MyColor.mainWhiteColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isDark
                            ? const Color(0xff1B1B1B)
                            : const Color(0xffE9EBF8),
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
                            color: isDark
                                ? const Color(0xff101010)
                                : const Color(0xffFCFCFC),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                scale: 1.4,
                                "assets/images/auto.png",
                              ),
                              StatusIndicator(
                                text: "Paid",
                                color: isDark
                                    ? const Color(0xff0B930B)
                                    : MyColor.greenColor,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Manage Details Button
                        Container(
                          padding: const EdgeInsets.only(bottom: 0),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFAAAAAA)
                                    .withOpacity(0.08), // 8% opacity
                                offset: const Offset(0, 5.05), // x: 0, y: 5.05
                                blurRadius: 8.41,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: BorderSide.none,
                              backgroundColor: themeProvider.isDarkMode()
                                  ? const Color(0xff162A16).withOpacity(0.7)
                                  : const Color(0xffE6F2E6).withOpacity(0.7),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 10),
                            ),
                            child: Text("Paid Now",
                                style: MyStyle.tx16Black.copyWith(
                                  color: const Color(0xff9CA3AF),
                                  fontWeight: FontWeight.w400,
                                )),
                          ),
                        ),
                        const SizedBox(height: 28),
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
                            Text("420516-51443-7897-SPR",
                                style: MyStyle.tx16Black.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: themedata.tertiary,
                                )),
                            GestureDetector(
                              onTap: () {
                                // Copy to clipboard
                                Clipboard.setData(const ClipboardData(
                                    text: "420516-51443-7897-SPR"));
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
                        Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DotLabel(
                                text: "Service type",
                                value: "Vehicle repair",
                                dotColor: MyColor.dark01Color,
                                labelColor: const Color(0xff6E6D7A),
                                textColor: isDark
                                    ? MyColor.mainWhiteColor
                                    : MyColor.blackColor,
                              ),
                              DotLabel(
                                text: "Automobile",
                                value: "Mazda C9 2009",
                                dotColor: MyColor.dark01Color,
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
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DotLabel(
                                text: "Status",
                                value: "Run & Drive",
                                dotColor: MyColor.dark01Color,
                                labelColor: const Color(0xff6E6D7A),
                                textColor: isDark
                                    ? MyColor.mainWhiteColor
                                    : MyColor.blackColor,
                              ),
                              DotLabel(
                                text: "Date",
                                value: "12th, Dec 2025",
                                dotColor: MyColor.dark01Color,
                                labelColor: const Color(0xff6E6D7A),
                                textColor: isDark
                                    ? MyColor.mainWhiteColor
                                    : MyColor.blackColor,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 19),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: isDark
                                    ? const Color(0xff1B1B1B)
                                    : const Color(0xffE9EBF8),
                                width: 1,
                              ),
                            ),
                            color: isDark
                                ? const Color(0xff101010)
                                : const Color(0xffFCFCFC),
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
                                "N200,000",
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
                              backgroundColor:
                                  const Color(0xff12B76A).withOpacity(0.09),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                            child: Text("Awaiting arrival",
                                style: MyStyle.tx16Black.copyWith(
                                  color: isDark
                                      ? const Color(0xff0B930B)
                                      : MyColor.greenColor,
                                  fontWeight: FontWeight.w400,
                                )),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: themeProvider.isDarkMode()
                                    ? const Color(0xff1B1B1B)
                                    : const Color(0xffE9EBF8),
                              ),
                              backgroundColor: themeProvider.isDarkMode()
                                  ? const Color(0xff101010)
                                  : const Color(0xffFCFCFC),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                            child: Text("See repair details",
                                style: MyStyle.tx16Black.copyWith(
                                  color: themedata.tertiary,
                                  fontWeight: FontWeight.w400,
                                )),
                          ),
                        ),
                      ]),
                ),
                const SizedBox(height: 64),
              ]))),
            ],
          ),
        ));
  }
}

class StatusIndicator extends StatelessWidget {
  final String text;
  final Color color;
  const StatusIndicator({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text,
            style: MyStyle.tx14White.copyWith(
              fontWeight: FontWeight.w400,
              color: color,
            )),
        const SizedBox(width: 8),
        Dot(
          color: color,
          size: 15,
        )
      ],
    );
  }
}
