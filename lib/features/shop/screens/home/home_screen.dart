import 'package:e_commerce_app/common/products_cart/product_card_vertical.dart';
import 'package:e_commerce_app/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce_app/features/shop/screens/home/widgets/carousel_slider.dart';
import 'package:e_commerce_app/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/common_shapes/containers/primary_curved_widget.dart';
import '../../../../common/common_shapes/containers/search_container.dart';
import '../../../../common/common_shapes/home_categories/home_categories.dart';
import '../../../../common/common_shapes/layouts/grid_layout.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../images/images.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

                  //search bar
                  ESearchContainer(
                    text: 'Search In Store',
                    icon: Iconsax.search_normal,
                  ),

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
                  const ECarouselSlider(
                    banners: [
                      EImages.slider1,
                      EImages.slider2,
                      EImages.slider3
                    ],
                  ),
                  const SizedBox(
                    height: ESizes.spaceBtnItems,
                  ),
                  ESectionHeading(
                      title: 'Popular products',
                      onPressed: () => Get.to(() => const AllProducts())),
                  EGridLayout(
                    itemCount: 4,
                    itemBuilder: (_, index) => const EProductCardVertical(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
