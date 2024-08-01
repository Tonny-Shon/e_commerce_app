import 'package:e_commerce_app/common/common_shapes/slider_images/slider_images.dart';
import 'package:e_commerce_app/common/products_cart/product_card_horizontal.dart';
import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/features/shop/controllers/category_controller.dart';
import 'package:e_commerce_app/features/shop/models/category_model.dart';
import 'package:e_commerce_app/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/effects/vertical_shimmer_effect.dart';
import '../../models/product_model.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: EAppBar(
        title: Text(
          category.name,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              //Banner
              ERoundedImage(
                imageUrl: category.image,
                width: double.infinity,
                isNetworkImage: true,
                height: null,
                applyImageRadius: true,
              ),
              const SizedBox(
                height: ESizes.spaceBtnItems,
              ),

              //subCategories
              FutureBuilder<List<CategoryModel>>(
                  future: controller.getSubCategories(categoryId: category.id),
                  builder: (context, snapshot) {
                    const loader = EVerticalShimmerEffect();
                    final widget = ECloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);
                    if (widget != null) return widget;

                    final subCategories = snapshot.data!;
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: subCategories.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          final subCategory = subCategories[index];
                          return FutureBuilder<List<ProductModel>>(
                              future: controller.getCategoryProducts(
                                  categoryId: subCategory.id),
                              builder: (context, snapshot) {
                                const loader = EVerticalShimmerEffect();
                                final widget =
                                    ECloudHelperFunctions.checkMultiRecordState(
                                        snapshot: snapshot, loader: loader);
                                if (widget != null) return widget;

                                final products = snapshot.data!;

                                return Column(
                                  children: [
                                    ESectionHeading(
                                      title: subCategory.name,
                                      onPressed: () => Get.to(
                                        () => AllProducts(
                                          title: subCategory.name,
                                          futureMethod:
                                              controller.getCategoryProducts(
                                            categoryId: subCategory.id,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: ESizes.spaceBtnItems / 2,
                                    ),
                                    SizedBox(
                                      height: 120,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                          width: ESizes.spaceBtnItems,
                                        ),
                                        itemBuilder: (context, index) =>
                                            EProductCardHorizontal(
                                          product: products[index],
                                        ),
                                        itemCount: products.length,
                                      ),
                                    )
                                  ],
                                );
                              });
                        });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
