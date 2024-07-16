import 'package:e_commerce_app/common/products_cart/product_card_vertical.dart';
import 'package:e_commerce_app/features/shop/controllers/category_controller.dart';
import 'package:e_commerce_app/features/shop/models/category_model.dart';
import 'package:e_commerce_app/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce_app/features/shop/screens/store/widgets/categories/category_brands.dart';
import 'package:e_commerce_app/utils/effects/vertical_shimmer_effect.dart';
import 'package:e_commerce_app/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/common_shapes/layouts/grid_layout.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';

class ECategoryTab extends StatelessWidget {
  const ECategoryTab({
    super.key,
    required this.category,
  });
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(ESizes.defaultSpace),
            child: Column(children: [
              //Images
              CategoryBrands(category: category),
              const SizedBox(
                height: ESizes.spaceBtnItems,
              ),
              ////Products
              FutureBuilder(
                  future:
                      controller.getCategoryProducts(categoryId: category.id),
                  builder: (context, snapshot) {
                    //checking the connections
                    final response =
                        ECloudHelperFunctions.checkMultiRecordState(
                            snapshot: snapshot,
                            loader: const EVerticalShimmerEffect());
                    if (response != null) return response;

                    //records found
                    final products = snapshot.data!;
                    return Column(
                      children: [
                        ESectionHeading(
                          title: 'You might like',
                          showActionButton: true,
                          onPressed: () => Get.to(
                            () => AllProducts(
                              title: category.name,
                              futureMethod: controller.getCategoryProducts(
                                categoryId: category.id,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: ESizes.spaceBtnItems,
                        ),
                        EGridLayout(
                            itemCount: products.length,
                            itemBuilder: (_, index) => EProductCardVertical(
                                  product: products[index],
                                )),
                      ],
                    );
                  }),
            ]),
          ),
        ]);
  }
}
