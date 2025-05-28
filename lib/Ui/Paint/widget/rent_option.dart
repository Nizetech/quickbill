import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';

class RentOption extends StatelessWidget {
  final String title;
  final String amount;
  final VoidCallback onTap;
  const RentOption(
      {super.key,
      required this.title,
      required this.amount,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context).colorScheme;
    // final isDark = themeProvider.isDarkMode();
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: MyStyle.tx18Black.copyWith(
          color: themedata.tertiary,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        amount,
        style: MyStyle.tx16Black.copyWith(
            color: themedata.tertiary,
            fontSize: 14,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
