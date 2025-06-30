
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jost_pay_wallet/Models/domain_list.dart';
import 'package:jost_pay_wallet/Provider/theme_provider.dart';
import 'package:jost_pay_wallet/Ui/Domain/domain_screen.dart';
import 'package:jost_pay_wallet/Ui/Domain/widget/domain_card.dart';
import 'package:jost_pay_wallet/Ui/Domain/widget/host_plan.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';
import 'package:provider/provider.dart';

class DomainModalSheet extends StatefulWidget {
  final DomainList domain;
  const DomainModalSheet({super.key, required this.domain});

  @override
  State<DomainModalSheet> createState() => _DomainModalSheetState();
}


bool isExpired(String dateStr) {
  // Parse input date
  final inputDate = DateTime.parse(
    DateFormat('MMM dd, yyyy').parse(dateStr).toIso8601String(),
  );
  // Get current date (without time)
  final today = DateTime.now();
  final nowDateOnly = DateTime(today.year, today.month, today.day);

  return inputDate.isBefore(nowDateOnly);
}

class _DomainModalSheetState extends State<DomainModalSheet> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final isDark = themeProvider.isDarkMode();
    final themedata = Theme.of(context).colorScheme;

    return Container(
      height: 500,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14)
          .copyWith(right: 21),
      decoration: BoxDecoration(
        color:
            // Colors.red,
            isDark ? MyColor.dark02Color : MyColor.mainWhiteColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: ListView(
        // controller: controller,
        children: [
          Center(
            child: Container(
              width: 107,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color:
                    isDark ? const Color(0xff8F8F90) : const Color(0xffE5E4E4),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // 👇 Put the content shown in the image here
          DomainInfoCard(
            title: widget.domain.dns!,
            subtitle: "Domain name",
            statusIcon: isDark
                ? "assets/images/svg/home-dark.svg"
                : "assets/images/svg/home.svg",
            status: "Active",
            expiryDate: widget.domain.expiryAt,
            autoRenew: widget.domain.autoRenew == '0',
            // onToggleRenew: (value) {
            //   setState(() {
            //     _autoRenew = value;
            //   });
            // },
          ),
          const SizedBox(height: 35),
          DomainInfoCard(
            title: "Domain Privacy",
            subtitle: "",
            status: isExpired(widget.domain.expiryAt!) ? "OFF" : "ON",
            hasExpiry: true,
            statusIcon: isDark
                ? "assets/images/svg/security-dark.svg"
                : "assets/images/svg/security.svg",
            expiryDate: widget.domain.expiryAt,
            autoRenew: !isExpired(widget.domain.expiryAt!),
          ),
          const SizedBox(height: 16),
          Divider(
            color: themeProvider.isDarkMode()
                ? const Color(0xff1B1B1B)
                : const Color(0xffE9EBF8),
            thickness: 0.6,
            indent: 3,
            endIndent: 3,
          ),

          const SizedBox(height: 12),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
        
            children: [
              SvgPicture.asset(
                isDark
                    ? "assets/images/svg/lock-dark.svg"
                    : "assets/images/svg/lock.svg",
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "PositiveSSl",
                    style: MyStyle.tx18Black.copyWith(
                        fontWeight: FontWeight.w400, color: themedata.tertiary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "SSl Certificate",
                    style: MyStyle.tx14Grey.copyWith(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff6B7280)),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/images/svg/circle.svg",
                        width: 22,
                        height: 22,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        isExpired(widget.domain.expiryAt!)
                            ? "INACTIVE"
                            : "ACTIVE",
                        style: MyStyle.tx14Grey.copyWith(
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff6B7280)),
                      )
                    ],
                  ),
                ],
              ),
Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
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
                        isExpired(widget.domain.expiryAt!)
                            ? "Inactive"
                            : "Active",
                        style: MyStyle.tx14Green,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                
                  DotLabelFlexFree(
                    text: "Expiry date",
                    value: widget.domain.expiryAt!,
                    labelStyle: MyStyle.tx14Black.copyWith(
                        fontStyle: FontStyle.italic,
                        color: const Color(0xff6B7280),
                        fontWeight: FontWeight.w400),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 14),
          Divider(
            color: themeProvider.isDarkMode()
                ? const Color(0xff1B1B1B)
                : const Color(0xffE9EBF8),
            thickness: 0.6,
            indent: 3,
            endIndent: 3,
          ),
       
          if (widget.domain.hostingPlan != null)
            Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    isDark
                        ? "assets/images/svg/security-dark.svg"
                        : "assets/images/svg/security.svg",
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hosting Plan",
                        style: MyStyle.tx18Black.copyWith(
                            fontWeight: FontWeight.w400,
                            color: themedata.tertiary),
                      ),
                      SizedBox(height: 5),
                      if (widget.domain.hostingPlan!.type != null)
                        HostPlan(
                          title: "Type",
                          value: widget.domain.hostingPlan!.type!,
                        ),
                      if (widget.domain.hostingPlan!.name != null)
                        HostPlan(
                          title: "Name",
                          value: widget.domain.hostingPlan!.name!,
                        ),
                      if (widget.domain.hostingPlan!.level != null)
                        HostPlan(
                          title: "Level",
                          value: widget.domain.hostingPlan!.level!,
                        ),
                    ],
                  ),
                ],
              ),
          ),
      
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: themeProvider.isDarkMode()
                      ? const Color(0xff1B1B1B)
                      : const Color(0xffE9EBF8),
                ),
                backgroundColor: themeProvider.isDarkMode()
                    ? MyColor.dark02Color
                    : MyColor.mainWhiteColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
              child: Text("Close",
                  style: MyStyle.tx14Black.copyWith(
                    fontFamily: 'SF Pro Rounded',
                    color: themeProvider.isDarkMode()
                        ? MyColor.whiteColor
                        : MyColor.blackColor,
                    fontWeight: FontWeight.w600,
                  )),
            ),
          ),
          SizedBox(height: 30),

        ],
      ),
    );

    //   },
    // );
  }
}
