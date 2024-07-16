import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/icons/icon_widget.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class EProductWithAddAndRemoveButton extends StatelessWidget {
  const EProductWithAddAndRemoveButton({
    super.key,
    required this.removeButton,
    required this.addButton,
    this.quantity = 0,
  });

  final VoidCallback removeButton, addButton;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ECircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: ESizes.md,
          color: EHelperFunctions.isDarkMode(context)
              ? EColors.white
              : EColors.black,
          backgroundColor: EHelperFunctions.isDarkMode(context)
              ? EColors.darkerGrey
              : EColors.light,
          onPressed: removeButton,
        ),
        const SizedBox(
          width: ESizes.spaceBtnItems,
        ),
        Text(
          quantity.toString(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          width: ESizes.spaceBtnItems,
        ),
        ECircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: ESizes.md,
          color: EColors.white,
          backgroundColor: EColors.primaryColor,
          onPressed: addButton,
        ),
      ],
    );
  }
}
