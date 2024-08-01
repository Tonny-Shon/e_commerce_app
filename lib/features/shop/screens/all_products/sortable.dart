import 'package:e_commerce_app/features/shop/controllers/product/all_products_controller.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/common_shapes/layouts/grid_layout.dart';
import '../../../../common/products_cart/product_card_vertical.dart';
import '../../../../utils/constants/sizes.dart';

class ESortableProducts extends StatelessWidget {
  const ESortableProducts({
    super.key,
    required this.products,
  });
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);
    return Column(
      children: [
        //drop down
        DropdownButtonFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.sort),
            ),
            value: controller.selectedSortOption.value,
            items: [
              'Name',
              'Higher Price',
              'Lower Price',
              'Newest',
            ]
                .map(
                  (option) => DropdownMenuItem(
                    value: option,
                    child: Text(option),
                  ),
                )
                .toList(),
            onChanged: (value) {
              controller.sortProducts(value!);
            }),
        const SizedBox(
          height: ESizes.spaceBtnSections,
        ),

        //Products
        Obx(
          () => EGridLayout(
            itemCount: controller.featuredProducts.length,
            itemBuilder: (_, index) => EProductCardVertical(
              product: controller.featuredProducts[index],
            ),
          ),
        ),
      ],
    );
  }
}
