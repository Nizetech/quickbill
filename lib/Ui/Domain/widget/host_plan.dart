import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Domain/widget/dot.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class HostPlan extends StatelessWidget {
  final String title;
  final String value;
  const HostPlan({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final isDark = themeProvider.isDarkMode();
    final themedata = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Dot(
            color: (themeProvider.isDarkMode()
                ? MyColor.whiteColor
                : MyColor.dark01Color),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: MyStyle.tx14Grey.copyWith(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff6B7280)),
              ),
              Text(
                value,
                style: MyStyle.tx14Black.copyWith(
                    fontWeight: FontWeight.w400, color: themedata.tertiary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
