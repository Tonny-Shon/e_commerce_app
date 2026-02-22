import 'dart:math';

import 'package:e_commerce_app/common/products_cart/product_card_vertical.dart';
import 'package:e_commerce_app/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce_app/features/shop/screens/home/widgets/carousel_slider.dart';
import 'package:e_commerce_app/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:e_commerce_app/features/shop/screens/home/widgets/home_product_section.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/constants/texts.dart';
import 'package:e_commerce_app/utils/effects/cateogy_shimmer.dart';
import 'package:e_commerce_app/utils/effects/shimmer.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/common_shapes/containers/primary_curved_widget.dart';
import '../../../../common/common_shapes/home_categories/home_categories.dart';
import '../../../../common/common_shapes/layouts/grid_layout.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../controllers/category_controller.dart';
import '../../controllers/product/product_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    final controller = Get.put(ProductController());
    final categoryController = Get.put(CategoryController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const EPrimaryCurvedWidget(
              child: Column(
                children: [
                  //appbar
                  EHomeAppBar(),

                  // SizedBox(
                  //   height: ESizes.spaceBtnItems,
                  // ),

                  //categories
                  Padding(
                    padding: EdgeInsets.only(left: ESizes.defaultSpace),
                    child: Column(
                      children: [
                        // ESearchContainer(
                        //   text: 'Search Products',
                        //   ontap: () => Get.to(() => const ESearchScreen()),
                        // ),
                        SizedBox(
                          height: ESizes.spaceBtnItems / 4,
                        ),
                        //Heading
                        ESectionHeading(
                          textColor: EColors.whiteColor,
                          title: ETexts.popularCategories,
                          showActionButton: false,
                        ),
                        SizedBox(
                          height: ESizes.spaceBtnItems / 2,
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
              padding: const EdgeInsets.all(ESizes.md),
              child: Column(
                children: [
                  const ECarouselSlider(),
                  const SizedBox(
                    height: ESizes.spaceBtnItems,
                  ),
                  ESectionHeading(
                    title: 'Featured products',
                    textColor: dark ?Colors.white : EColors.black,
                    onPressed: () => Get.to(
                          () => AllProducts(
                        title: 'Featured Products',
                        
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
                        
                        itemCount: min(controller.featuredProducts.length, 4),
                        itemBuilder: (_, index) => EProductCardVertical(
                          product: controller.featuredProducts[index],
                        ),
                      );
                    // }
                  }}),
                  const SizedBox(height: ESizes.spaceBtnSections,),

                  //Shoes Section
                  Obx((){
                    if(categoryController.isLoadingCategories.value){
                      return const ECategoryShimmer();
                    }
                    return Column(
                      children: categoryController.allCategories.map((category) => 
                      Padding(padding: const EdgeInsets.only(bottom: ESizes.spaceBtnSections),
                      child: HomeProductSection(category: category),)).toList(),
                    );
                  }),

                  const SizedBox(height: ESizes.spaceBtnSections,),

                  // HomeProductSection(title: 'Sports', futureMethod: controller.getCategoryProducts('Sports'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
