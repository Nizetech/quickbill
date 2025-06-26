import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class SectionChip extends StatelessWidget {
  final String title;
  const SectionChip({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    final isDark = themeProvider.isDarkMode();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xff0D0D0D) : MyColor.mainWhiteColor,
        border: Border.all(
            color: isDark ? const Color(0xff1B1B1B) : const Color(0xffE9EBF8)),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        title,
        style: MyStyle.tx12Green
            .copyWith(color: themedata.tertiary, fontWeight: FontWeight.w500),
      ),
    );
  }
}
