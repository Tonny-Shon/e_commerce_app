import 'package:e_commerce_app/features/shop/screens/store/widgets/brand_text.dart';
import 'package:e_commerce_app/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class EBrandTitleVerifiedIcon extends StatelessWidget {
  const EBrandTitleVerifiedIcon({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor,
    this.iconColor = EColors.primaryColor,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        EBrandTitleText(
          title: title,
          maxLines: maxLines,
          textAlign: textAlign,
          brandTextSize: brandTextSize,
          color: dark ? EColors.white : EColors.black,
        ),
        const SizedBox(
          width: ESizes.xs,
        ),
        Icon(
          Iconsax.verify5,
          color: iconColor,
          size: ESizes.iconXs,
        )
      ],
    );
  }
}
