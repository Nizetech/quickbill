import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';

class ServiceChip extends StatelessWidget {
  const ServiceChip({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
    this.height = 80,
  });
  final double height;
  final VoidCallback onTap;
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border:
                Border.all(color: MyColor.grey02Color.withValues(alpha: 0.2)),
            color: MyColor.grey01Color.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(icon),
              const SizedBox(height: 5),
              Text(
                title,
                style: MyStyle.tx14Black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
