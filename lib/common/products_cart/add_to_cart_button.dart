import 'package:e_commerce_app/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';

class ProductCardAddToCartButton extends StatelessWidget {
  const ProductCardAddToCartButton({
    super.key,
    required this.product,
  });
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return GestureDetector(
      onTap: () {
        final cartItem = cartController.convertToCartItem(product, 1);
        cartController.addItemToCart(cartItem);
      },
      child: Obx(() {
        final productQuantityInCart =
            cartController.getProductQuantityInCart(product.id);
        return Container(
          decoration: BoxDecoration(
            color: productQuantityInCart > 0 ? EColors.redColor : Colors.black,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(
                ESizes.cardRadiusMd,
              ),
              bottomRight: Radius.circular(ESizes.productImageRadius),
            ),
          ),
          child: SizedBox(
            width: ESizes.iconLg * 1.2,
            height: ESizes.iconLg * 1.2,
            child: Center(
              child: productQuantityInCart > 0
                  ? Text(
                      productQuantityInCart.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .apply(color: EColors.white),
                    )
                  : const Icon(
                      Iconsax.add,
                      color: EColors.white,
                    ),
            ),
          ),
        );
      }),
    );
  }
}
