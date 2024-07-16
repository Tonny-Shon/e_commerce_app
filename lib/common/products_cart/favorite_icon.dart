import 'package:e_commerce_app/common/icons/icon_widget.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../features/shop/controllers/product/favorite_controller.dart';

class EFavoriteIcon extends StatelessWidget {
  const EFavoriteIcon({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoriteController());
    return Obx(
      () => ECircularIcon(
        icon:
            controller.isFavorites(productId) ? Iconsax.heart5 : Iconsax.heart,
        color: controller.isFavorites(productId) ? EColors.error : null,
        onPressed: () => controller.toggleFavoriteProducts(productId),
      ),
    );
  }
}
