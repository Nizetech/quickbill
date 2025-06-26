import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  final Color color;
  final double? size;
  const Dot({super.key, required this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 7,
      height: size ?? 7,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
