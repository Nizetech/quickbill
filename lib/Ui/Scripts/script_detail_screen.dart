import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Domain/domain_screen.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class ScriptDetailScreen extends StatefulWidget {
  const ScriptDetailScreen({super.key});

  @override
  State<ScriptDetailScreen> createState() => _ScriptDetailScreenState();
}

class _ScriptDetailScreenState extends State<ScriptDetailScreen> {
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
                    'Scripts',
                    style:
                        MyStyle.tx18Black.copyWith(color: themedata.tertiary),
                  ),
                ),
                const Spacer(), // Adds flexible space after the text
              ],
            ),
            const SizedBox(height: 40),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Taro-Bulk SMS Complete\n Solution",
                    style: MyStyle.tx20Grey.copyWith(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        color: themedata.tertiary),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Taro is a powerful and scalable bulk SMS solution built with PHP, designed to streamline messaging for businesses, marketers, and service providers. With an intuitive interface, robust API integrations, and efficient message delivery, Taro enables users to send mass SMS campaigns, automate notifications, and track message performance in real time. Whether for customer engagement, alerts, or marketing, Taro simplifies bulk messaging with reliability and ease.",
                    style: MyStyle.tx18Grey
                        .copyWith(color: const Color(0xff6B7280), height: 1.7),
                  ),
                  const SizedBox(height: 34),
                  Text("Additional details",
                      style: MyStyle.tx20Grey.copyWith(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          color: themedata.tertiary)),
                  const SizedBox(height: 18),
                  const Row(
                    children: [
                      DotLabel(text: "Creator", value: "Scriptlord"),
                      SizedBox(width: 120),
                      DotLabel(text: "Updated", value: "a week ago"),
                    ],
                  ),
                  const SizedBox(height: 44),
                  OutlinedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        barrierColor: const Color(0xffBCBCBC).withOpacity(0.5),
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const DomainModalSheet(),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide.none,
                      backgroundColor: themeProvider.isDarkMode()
                          ? const Color(0xff0B930B)
                          : MyColor.greenColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Purchase for",
                            style: MyStyle.tx14Black.copyWith(
                              fontFamily: 'SF Pro Rounded',
                              color: MyColor.mainWhiteColor,
                              fontWeight: FontWeight.w600,
                            )),
                        SvgPicture.asset(
                          "assets/images/svg/naira.svg",
                          color: MyColor.mainWhiteColor,
                        ),
                        Text("90,000",
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
                      child: Text("View Demo",
                          style: MyStyle.tx14Black.copyWith(
                            fontFamily: 'SF Pro Rounded',
                            color: themeProvider.isDarkMode()
                                ? const Color(0xff0B930B)
                                : MyColor.greenColor,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
