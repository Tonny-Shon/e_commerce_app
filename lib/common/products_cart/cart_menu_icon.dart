import 'package:e_commerce_app/features/shop/screens/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../features/shop/controllers/product/cart_controller.dart';
import '../../utils/constants/colors.dart';

class ECartControlIcon extends StatelessWidget {
  const ECartControlIcon({
    super.key,
    this.iconColor,
  });
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    return Stack(
      children: [
        IconButton(
          onPressed: () => Get.to(() => const CartScreen()),
          icon: Icon(Iconsax.shopping_bag, color: iconColor),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: EColors.black,
              borderRadius: BorderRadius.circular(200),
            ),
            child: Center(
              child: Obx(
                () => Text(
                  controller.numberOfCartItems.value.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: EColors.white, fontSizeFactor: 1),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
