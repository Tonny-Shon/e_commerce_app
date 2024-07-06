import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/device/device_utility.dart';
import '../../../utils/helpers/helper_functions.dart';

class ESearchContainer extends StatelessWidget {
  const ESearchContainer({
    super.key,
    required this.text,
    this.icon,
    this.showBackground = true,
    this.showBorder = true,
    this.ontap,
    this.padding = const EdgeInsets.symmetric(horizontal: ESizes.defaultSpace),
  });
  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? ontap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: padding,
        child: Container(
          width: EDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(ESizes.md),
          decoration: BoxDecoration(
              color: showBackground
                  ? dark
                      ? EColors.dark
                      : EColors.light
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(ESizes.cardRadiusLg),
              border: showBorder ? Border.all(color: EColors.grey) : null),
          child: Row(children: [
            const Icon(
              Iconsax.search_normal,
              color: EColors.darkGrey,
            ),
            const SizedBox(
              width: ESizes.spaceBtnItems,
            ),
            Text(
              'Search In Store',
              style: Theme.of(context).textTheme.bodySmall,
            )
          ]),
        ),
      ),
    );
  }
}
