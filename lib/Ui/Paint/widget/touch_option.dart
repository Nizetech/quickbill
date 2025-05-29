import 'package:flutter/material.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';
import 'package:jost_pay_wallet/Values/MyStyle.dart';

class TouchupOptions extends StatefulWidget {
  const TouchupOptions({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  State<TouchupOptions> createState() => _TouchupOptionsState();
}

class _TouchupOptionsState extends State<TouchupOptions> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          checkColor: MyColor.mainWhiteColor,
          activeColor:
              widget.isDark ? const Color(0xff0B930B) : MyColor.greenColor,
          side: BorderSide(color: const Color(0xffD1D1D1)),
          value: false,
          onChanged: (value) {},
        ),
        Text(
          "data",
          style: MyStyle.tx12Black.copyWith(
              color: widget.isDark
                  ? MyColor.mainWhiteColor
                  : const Color(0xff6B7280),
              fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
