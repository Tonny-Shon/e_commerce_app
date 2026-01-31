import 'package:e_commerce_app/common/products_cart/product_card_vertical.dart';
import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/features/shop/controllers/category_controller.dart';
import 'package:e_commerce_app/features/shop/models/category_model.dart';
import 'package:e_commerce_app/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/effects/vertical_shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeProductSection extends StatelessWidget {
  const HomeProductSection({
    super.key,
    required this.category,
  });
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Section Header
        ESectionHeading(
          title: category.name,
          showActionButton: true,
          onPressed: () => Get.to(() => AllProducts(title: category.name)),
        ),

        const SizedBox(
          height: ESizes.spaceBtnItems,
        ),

        //Products
        FutureBuilder(
            future: controller.getCategoryProducts(categoryId: category.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const EVerticalShimmerEffect();
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const SizedBox.shrink();
                // Text('No Products found',
                // style: Theme.of(context).textTheme.bodyMedium,);
              }

              final products = snapshot.data!;

              return SizedBox(
                height: 220,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: ESizes.spaceBtnItems),
                  itemBuilder: (_, index) =>  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: EProductCardVertical(product: products[index]),
                  ),
                  
                ),
              );
            })
      ],
    );
  }
}
