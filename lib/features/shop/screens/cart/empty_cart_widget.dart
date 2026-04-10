import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../navigation_menu.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class EEmptyCartWidget extends StatelessWidget {
  const EEmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.all(ESizes.defaultSpace),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 1. Visual Element (Icon or Lottie)
          const Icon(Iconsax.shopping_bag, size: 100, color: EColors.grey),
          const SizedBox(height: ESizes.spaceBtnSections),

          // 2. Headline
          Text(
            'Whoops! Empty Cart',
            style: Theme.of(context).textTheme.headlineMedium!.apply(color: dark ? EColors.white : EColors.black),
          ),
          const SizedBox(height: ESizes.spaceBtnItems),

          // 3. Subtitle
          Text(
            'It looks like you haven\'t added anything to your cart yet. Start exploring our amazing collection!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge!.apply(color: dark ? EColors.white : EColors.black),
          ),
          const SizedBox(height: ESizes.spaceBtnSections),

          // 4. Call to Action Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.offAll(() => const NavigationMenu()),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: ESizes.spaceBtnItems),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                backgroundColor: EColors.primaryColor,
                side: const BorderSide(color: EColors.primaryColor),
              ), // Go back to Home
              child: const Text('Start Shopping'),
            ),
          ),
        ],
      ),
    );
  }
}