import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Domain/domain_screen.dart';
import 'package:jost_pay_wallet/Ui/Domain/widget/custom_switch.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class DomainInfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String status;
  final String statusIcon;
  final String? expiryDate;
  final bool autoRenew;
  final bool hasExpiry;
  final bool isPrivacy;
  final void Function(bool)? onToggleRenew;
  const DomainInfoCard({
    super.key,
    required this.title,
    this.isPrivacy = false, 
    required this.subtitle,
    required this.statusIcon,
    required this.status,
    this.expiryDate,
    required this.autoRenew,
    this.hasExpiry = true,
    this.onToggleRenew,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final isDark = themeProvider.isDarkMode();
    final themedata = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isPrivacy
                    ? SvgPicture.asset(
                        isDark
                            ? "assets/images/svg/lock-dark.svg"
                            : "assets/images/svg/lock.svg",
                        width: 24,
                        height: 24,
                      )
                    :
                SvgPicture.asset(
                  statusIcon,
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: MyStyle.tx18Black.copyWith(
                      fontWeight: FontWeight.w400, color: themedata.tertiary),
                ),
              ],
            ),
            const SizedBox(height: 2),
            if (subtitle.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  subtitle,
                  style: MyStyle.tx14Grey.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff6B7280)),
                ),
              ),
            const SizedBox(height: 25),
            if (hasExpiry && !isPrivacy)
              SizedBox(
                width: 150,
                child: DotLabelFlexFree(
                  text: "Expiry date",
                  value: expiryDate!,
                  labelStyle: MyStyle.tx14Black.copyWith(
                      fontStyle: FontStyle.italic,
                      color: const Color(0xff6B7280),
                      fontWeight: FontWeight.w400),
                ),
              ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 102,
              height: 38,
              decoration: BoxDecoration(
                color: const Color(0xff12B76A).withOpacity(0.09),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  status,
                  style: MyStyle.tx14Green,
                ),
              ),
            ),
            if (isPrivacy)
              SizedBox(
                width: 150,
                child: DotLabel(
                  text: "Expiry date",
                  value: expiryDate!,
                  labelStyle: MyStyle.tx14Black.copyWith(
                      fontStyle: FontStyle.italic,
                      color: const Color(0xff6B7280),
                      fontWeight: FontWeight.w400),
                ),
              ),
            if (hasExpiry && !isPrivacy) ...[
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: CustomSwitch(
                  value: autoRenew,
                  onChanged: (value) {
                    // onToggleRenew(value); // Handle switch change
                  },
                ),
              ),
              // const SizedBox(height: 8),
              // Padding(
              //   padding: const EdgeInsets.only(left: 15),
              //   child: Text(
              //     "Auto Renew",
              //     style: MyStyle.tx14Grey.copyWith(
              //         fontStyle: FontStyle.italic,
              //         fontWeight: FontWeight.w400,
              //         color: const Color(0xff6B7280)),
              //   ),
              // ),
            ],
          ],
        )
      ],
    );
  }
}
