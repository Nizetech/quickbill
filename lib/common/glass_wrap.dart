import 'package:flutter/material.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:jost_pay_wallet/Values/MyColor.dart';

class GlassWrap extends StatelessWidget {
  const GlassWrap({
    super.key,
    required this.child,
    this.radius,
    this.width,
    this.height,
    this.bgImage,
    this.blur = 10,
    this.hasBorder = false,
  });
  final Widget child;
  final double? radius;
  final double? width;
  final double? height;
  final double blur;
  final String? bgImage;
  final bool hasBorder;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: hasBorder
          ? BoxDecoration(
              border:
                  Border.all(color: MyColor.whiteColor.withValues(alpha: .2)),
              borderRadius: BorderRadius.circular(radius ?? 10),
            )
          : bgImage != null
              ? BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(bgImage!),
                    fit: BoxFit.cover,
                  ),
                )
              : null,
      child: GlassContainer(
        border: 0,
        width: width,
        height: height,
        blur: blur,
        borderRadius: BorderRadius.circular(radius ?? 10),
        child: child,
      ),
    );
  }
}
