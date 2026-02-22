import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../../utils/helpers/helper_functions.dart';

class EProductPriceText extends StatelessWidget {
  const EProductPriceText({
    super.key,
    this.currencySign = 'Ugx ',
    required this.price,
    this.maxLines = 1,
    this.isLarge = false,
    this.lineThrough = false,
  });
  final String currencySign, price;
  final int maxLines;
  final bool isLarge;
  final bool lineThrough;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Text(
      currencySign + price,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: isLarge
          ? Theme.of(context).textTheme.headlineMedium!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null, color: dark ? EColors.white : EColors.black)
          : Theme.of(context).textTheme.titleLarge!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null, color: dark ? EColors.white : EColors.black),
    );
  }
}
