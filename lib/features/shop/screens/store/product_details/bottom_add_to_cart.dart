import 'package:e_commerce_app/common/icons/icon_widget.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../controllers/product/cart_controller.dart';

class BottomAddToCart extends StatelessWidget {
  const BottomAddToCart({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    controller.updateAlreadyAddedProductCount(product);
    final dark = EHelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: ESizes.defaultSpace, vertical: ESizes.defaultSpace / 2),
      decoration: BoxDecoration(
          color: dark ? EColors.darkerGrey : EColors.light,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(ESizes.cardRadiusLg),
            topRight: Radius.circular(ESizes.cardRadiusLg),
          )),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ECircularIcon(
                  icon: Iconsax.minus,
                  backgroundColor: EColors.darkGrey,
                  width: 40,
                  height: 40,
                  color: EColors.white,
                  onPressed: () => controller.productQuantityInCart.value < 1
                      ? null
                      : controller.productQuantityInCart.value -= 1,
                ),
                const SizedBox(
                  width: ESizes.spaceBtnItems,
                ),
                Text(
                  controller.productQuantityInCart.value.toString(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  width: ESizes.spaceBtnItems,
                ),
                ECircularIcon(
                  icon: Iconsax.add,
                  backgroundColor: EColors.black,
                  width: 40,
                  height: 40,
                  color: EColors.white,
                  onPressed: () => controller.productQuantityInCart.value += 1,
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () => controller.addToCart(product),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(ESizes.md),
                    backgroundColor: EColors.black,
                    side: const BorderSide(color: EColors.black)),
                child: const Text('Add to Cart'))
          ],
        ),
      ),
    );
  }
}
