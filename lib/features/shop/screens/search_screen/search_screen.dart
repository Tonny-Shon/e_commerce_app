import 'package:e_commerce_app/common/common_shapes/layouts/grid_layout.dart';
import 'package:e_commerce_app/features/shop/controllers/product/product_controller.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/products_cart/product_card_vertical.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/styles.dart';

class ESearchScreen extends StatelessWidget {
  const ESearchScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());
    //final searchBox = productController.searchController.text.trim();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: productController.searchController,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(
                      fontFamily: semibold, color: EColors.textfieldGrey),
                  hintText: 'Search Products',
                  isDense: true,
                  fillColor: EColors.lightGrey,
                  filled: true,
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: EColors.redColor),
                  ),
                ),
                onChanged: (value) {
                  productController.filterProducts(value);
                },
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(ESizes.defaultSpace),
        child: Obx(() {
          if (productController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (productController.searchResults.isEmpty) {
            return const Center(
              child: Text('No Products Found'),
            );
          }
          return EGridLayout(
            itemCount: productController.searchResults.length,
            itemBuilder: (_, index) => EProductCardVertical(
              product: productController.searchResults[index],
            ),
          );
        }),
      ),
    );
  }
}
