import 'package:e_commerce_app/common/products_cart/product_card_vertical.dart';
import 'package:e_commerce_app/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce_app/features/shop/screens/home/widgets/carousel_slider.dart';
import 'package:e_commerce_app/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/constants/texts.dart';
import 'package:e_commerce_app/utils/effects/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/common_shapes/containers/primary_curved_widget.dart';
import '../../../../common/common_shapes/home_categories/home_categories.dart';
import '../../../../common/common_shapes/layouts/grid_layout.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../controllers/product/product_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const EPrimaryCurvedWidget(
              child: Column(
                children: [
                  //appbar
                  EHomeAppBar(),

                  SizedBox(
                    height: ESizes.spaceBtnSections,
                  ),

                  //categories
                  Padding(
                    padding: EdgeInsets.only(left: ESizes.defaultSpace),
                    child: Column(
                      children: [
                        //Heading
                        ESectionHeading(
                          title: ETexts.popularCategories,
                          showActionButton: false,
                        ),
                        SizedBox(
                          height: ESizes.spaceBtnItems,
                        ),

                        //Categories
                        EHomeCategories(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ESizes.spaceBtnSections,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(ESizes.defaultSpace),
              child: Column(
                children: [
                  const ECarouselSlider(),
                  const SizedBox(
                    height: ESizes.spaceBtnItems,
                  ),
                  ESectionHeading(
                    title: 'Popular products',
                    onPressed: () => Get.to(
                      () => AllProducts(
                        title: 'Popular Products',
                        //query: FirebaseFirestore.instance.collection('Products').where('IsFeatured', isEqualTo: true).limit(2),
                        futureMethod: controller.fetchAllFeaturedProducts(),
                      ),
                    ),
                  ),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const EShimmerEffect(width: 55, height: 55);
                    }
                    if (controller.featuredProducts.isEmpty) {
                      return Center(
                        child: Text(
                          'No Featured Products found!',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    } else {
                      return EGridLayout(
                        itemCount: controller.featuredProducts.length,
                        itemBuilder: (_, index) => EProductCardVertical(
                          product: controller.featuredProducts[index],
                        ),
                      );
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
