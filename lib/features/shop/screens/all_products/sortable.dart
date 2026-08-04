import 'package:e_commerce_app/features/shop/controllers/product/all_products_controller.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/common_shapes/layouts/grid_layout.dart';
import '../../../../common/products_cart/product_card_vertical.dart';

class ESortableProducts extends StatelessWidget {
  const ESortableProducts({
    super.key,
    required this.products,
  });
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    // final dark = EHelperFunctions.isDarkMode(context);
    controller.assignProducts(products);
    return
        //Products
        Obx(
      () => EGridLayout(
        itemCount: controller.products.length,
        itemBuilder: (_, index) => EProductCardVertical(
          product: controller.products[index],
        ),
        // ),
      ),
      // ],
    );
  }
}
