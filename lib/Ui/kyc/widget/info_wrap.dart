import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:provider/provider.dart';

class InfoWrap extends StatelessWidget {
  final Widget child;
  const InfoWrap({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color:
            themeProvider.isDarkMode() ? Color(0xff564F12) : Color(0xffFFF7B4),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xffFFE920),
        ),
      ),
      child: child,
    );
  }
}
class InfoWrap2 extends StatelessWidget {
  final Widget child;
  const InfoWrap2({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color:
            themeProvider.isDarkMode() ? Color(0xff241D11) : Color(0xffFDF5E7),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xffF3A218),
        ),
      ),
      child: child,
    );
  }
}
