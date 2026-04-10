import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../utils/constants/colors.dart';
import '../utils/constants/enums.dart';

class EProductTitleText extends StatelessWidget {
  const EProductTitleText(
      {super.key,
      required this.title,
      this.smallSize = false,
      this.maxlines = 2,
      this.textAlign = TextAlign.left,
      this.brandTextSize = TextSizes.small});

  final String title;
  final bool smallSize;
  final int maxlines;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Text(
      title,
      style: smallSize
          ? Theme.of(context).textTheme.labelLarge!.apply(color: dark ? EColors.white : EColors.black)
          : Theme.of(context).textTheme.titleSmall!.apply(color: dark ? EColors.white : EColors.black),
      overflow: TextOverflow.ellipsis,
      maxLines: maxlines,
      textAlign: textAlign,
    );
  }
}
