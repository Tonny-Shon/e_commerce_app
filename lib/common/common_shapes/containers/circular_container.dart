import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class ERoundedContainer extends StatelessWidget {
  const ERoundedContainer(
      {super.key,
      this.width,
      this.height,
      this.radius = ESizes.cardRadiusLg,
      this.padding,
      this.margin,
      this.child,
      this.backgroundColor = EColors.white,
      this.showBorder = false,
      this.borderColor = EColors.borderPrimary});

  final double? width;
  final double? height;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final Color? backgroundColor;
  final bool showBorder;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: backgroundColor,
          border: showBorder
              ? Border.all(color: EColors.darkGrey, width: 0.8)
              : null),
      child: child,
    );
  }
}
