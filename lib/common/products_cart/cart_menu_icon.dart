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
        Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: IconButton(
            onPressed: () => Get.to(() => const CartScreen()),
            icon: Icon(Iconsax.shopping_bag, color: iconColor),
          ),
        ),
        Positioned(
          right: 5,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: EColors.white,
              borderRadius: BorderRadius.circular(200),
            ),
            child: Center(
              child: Obx(
                    () => Text(
                  '${controller.cartItems.length}',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: EColors.primaryColor, fontSizeFactor: 1),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
