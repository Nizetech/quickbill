import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';

class PaintPackages extends StatelessWidget {
  const PaintPackages({
    super.key,
    required this.isDark,
    required this.price,
    required this.title,
    required this.themedata,
    required this.themeProvider,
    required this.isSelected,
    required this.onTap,
  });

  final bool isDark;
  final bool isSelected;
  final String price;
  final VoidCallback onTap;
  final String title;
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
                    title,
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
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                side: !isSelected
                    ? BorderSide(
                        color: !isDark
                            ? const Color(0xff1B1B1B)
                            : const Color(0xffE9EBF8),
                      )
                    : BorderSide.none,
                backgroundColor: !isSelected
                    ? Colors.transparent
                    : themeProvider.isDarkMode()
                        ? const Color(0xff0B930B)
                        : MyColor.greenColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text("Select Package",
                  style: MyStyle.tx14Black.copyWith(
                    fontFamily: 'SF Pro Rounded',
                    color: !isSelected
                        ? isDark
                            ? MyColor.mainWhiteColor
                            : MyColor.blackColor
                        : MyColor.mainWhiteColor,
                    fontWeight: FontWeight.w500,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
