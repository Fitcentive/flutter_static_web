import 'package:flutter/material.dart';
import 'package:flutter_static_web/values/values.dart';

class CustomVerticalDivider extends StatelessWidget {
  const CustomVerticalDivider({
    this.thickness = 0.8,
    this.width,
    this.color = AppColors.black,
  });

  final double? width;
  final double thickness;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(thickness: thickness);
  }
}
