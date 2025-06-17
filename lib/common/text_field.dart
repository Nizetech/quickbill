import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final IconData? suffixIcon;
  final IconData? preffixIcon;
  final String? asset;
  final bool enabled;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  const CustomTextField({
    super.key,
    required this.text,
    this.onChanged,
    this.enabled = false,
    this.suffixIcon,
    this.preffixIcon,
    this.asset,
    this.onTap,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final themedata = Theme.of(context).colorScheme;
    final isDark = themeProvider.isDarkMode();

    return TextField(
      controller: controller,
      enabled: enabled,
      onTap: onTap,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: preffixIcon != null
            ? Icon(preffixIcon, size: 22, color: Colors.grey)
            : null,
        hintText: text,
        filled: true,
        fillColor: isDark ? MyColor.dark02Color : Colors.white,
        hintStyle: MyStyle.tx14Black.copyWith(
          color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        enabled: false,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
              width: 1.2,
              color:
                  isDark ? const Color(0xff1B1B1B) : const Color(0xffE9EBF8)),
        ),
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
