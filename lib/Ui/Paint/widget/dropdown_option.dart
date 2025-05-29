import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class DropdownOption extends StatelessWidget {
  final String title;
  final List option;
  final Function(String) onSelected;
  const DropdownOption(
      {super.key,
      required this.title,
      required this.option,
      required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    final isDark = themeProvider.isDarkMode();
    return DropdownButtonHideUnderline(
      child: Container(
        height: 53,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: isDark ? MyColor.dark02Color : Colors.white,
          border: Border.all(
            color: isDark ? const Color(0xff1B1B1B) : const Color(0xffE9EBF8),
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: DropdownButton<String>(
          value: title,
          icon: const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Icon(Icons.expand_more, size: 22, color: Colors.grey),
          ),
          dropdownColor:
              isDark ? const Color(0xff181818) : const Color(0xffFCFCFC),
          selectedItemBuilder: (context) {
            return option.map((e) {
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
          items: option.map((e) {
            return DropdownMenuItem<String>(
              value: e,
              child: Text(
                e,
                style: MyStyle.tx14White.copyWith(
                  color: const Color(0xff6B7280),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
          onChanged: (val) {
            if (val != null) {
              onSelected(val);
            }
          },
        ),
      ),
    );
  }
}
