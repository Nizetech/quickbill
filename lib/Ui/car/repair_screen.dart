import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/car/cardetail_screen.dart';
import 'package:jost_pay_wallet/Ui/car/repairdetail_screen.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class RepairScreen extends StatefulWidget {
  const RepairScreen({super.key});

  @override
  State<RepairScreen> createState() => _RepairScreenState();
}

class _RepairScreenState extends State<RepairScreen> {
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
                        style: MyStyle.tx18Black
                            .copyWith(color: themedata.tertiary),
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
                            "Choose Your Repair Option",
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
                          text: "Vehicle Repair",
                          suffixIcon: Icons.expand_more,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Appointment/Pickup date",
                              style: MyStyle.tx16Black.copyWith(
                                fontFamily: 'SF Pro Rounded',
                                color: const Color(0xff6B7280),
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        const CustomTextField(
                          text: "Thu, 30 2025",
                          asset: "assets/images/svg/calendar.svg",
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Vehicle Status",
                              style: MyStyle.tx16Black.copyWith(
                                fontFamily: 'SF Pro Rounded',
                                color: const Color(0xff6B7280),
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        const CustomTextField(
                          text: "Run & Drive",
                          suffixIcon: Icons.expand_more,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Vehicle Make",
                              style: MyStyle.tx16Black.copyWith(
                                fontFamily: 'SF Pro Rounded',
                                color: const Color(0xff6B7280),
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        const CustomTextField(
                          text: "Benz c300",
                          suffixIcon: Icons.expand_more,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Vehicle Model",
                              style: MyStyle.tx16Black.copyWith(
                                fontFamily: 'SF Pro Rounded',
                                color: const Color(0xff6B7280),
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        const CustomTextField(
                          text: "C 300",
                          suffixIcon: Icons.expand_more,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Vehicle Year",
                              style: MyStyle.tx16Black.copyWith(
                                fontFamily: 'SF Pro Rounded',
                                color: const Color(0xff6B7280),
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        const CustomTextField(
                          text: "2022 S Class",
                          suffixIcon: Icons.expand_more,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const RepairdetailScreen(),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide.none,
                              backgroundColor: themeProvider.isDarkMode()
                                  ? const Color(0xff0B930B)
                                  : MyColor.greenColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 11),
                            ),
                            child: Text("Schedule Appointment/Pickup",
                                style: MyStyle.tx16Black.copyWith(
                                  fontFamily: 'SF Pro Rounded',
                                  color: MyColor.mainWhiteColor,
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
            )));
  }
}

class CustomTextField extends StatelessWidget {
  final String text;
  final IconData? suffixIcon;
  final String? asset;
  const CustomTextField(
      {super.key, required this.text, this.suffixIcon, this.asset});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    final isDark = themeProvider.isDarkMode();

    return TextField(
      controller: TextEditingController(text: text),
      enabled: false,
      decoration: InputDecoration(
        filled: true,
        fillColor: isDark ? MyColor.dark02Color : Colors.white,
        enabled: false,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
              width: 1.2,
              color:
                  isDark ? const Color(0xff1B1B1B) : const Color(0xffE9EBF8)),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
              width: 1.2,
              color:
                  isDark ? const Color(0xff1B1B1B) : const Color(0xffE9EBF8)),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon, size: 22, color: Colors.grey)
            : asset != null
                ? Padding(
                    padding: const EdgeInsets.all(15),
                    child: SvgPicture.asset(
                      asset!,
                    ),
                  )
                : null,
      ),
      style: MyStyle.tx14Black.copyWith(
        color: themedata.tertiary,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
