import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class PaintInvoiceScreen extends StatefulWidget {
  const PaintInvoiceScreen({super.key});

  @override
  State<PaintInvoiceScreen> createState() => _PaintInvoiceScreenState();
}

class _PaintInvoiceScreenState extends State<PaintInvoiceScreen> {
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
                    'Paint Invoice',
                    style:
                        MyStyle.tx18Black.copyWith(color: themedata.tertiary),
                  ),
                ),
                const Spacer(), // Adds flexible space after the text
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 29),
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
                      Text(
                        "Collision module",
                        style: MyStyle.tx16Black.copyWith(
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff6E6D7A)),
                      ),
                      Text(
                        "NGN 35,0000",
                        style: MyStyle.tx16Black.copyWith(
                            fontWeight: FontWeight.w600,
                            color: themedata.tertiary),
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
                  const SizedBox(height: 13),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sikkens Paint",
                        style: MyStyle.tx16Black.copyWith(
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff6E6D7A)),
                      ),
                      Text(
                        "NGN 135,0000",
                        style: MyStyle.tx16Black.copyWith(
                            fontWeight: FontWeight.w600,
                            color: themedata.tertiary),
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
                  const SizedBox(height: 13),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Panel Work",
                        style: MyStyle.tx16Black.copyWith(
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff6E6D7A)),
                      ),
                      Text(
                        "NGN 20,0000",
                        style: MyStyle.tx16Black.copyWith(
                            fontWeight: FontWeight.w600,
                            color: themedata.tertiary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 19),
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
                    "N250,000",
                    style: MyStyle.tx16Black.copyWith(
                      color: themedata.tertiary,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              color: isDark ? const Color(0xff1B1B1B) : const Color(0xffE9EBF8),
            ),
            const SizedBox(height: 137),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide.none,
                backgroundColor: themeProvider.isDarkMode()
                    ? const Color(0xff0B930B)
                    : MyColor.greenColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 11),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
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
    );
  }
}
