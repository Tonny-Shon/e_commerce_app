import 'package:e_commerce_app/common/common_shapes/layouts/grid_layout.dart';
import 'package:e_commerce_app/common/products_cart/cart_menu_icon.dart';
import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/features/shop/controllers/category_controller.dart';
import 'package:e_commerce_app/features/shop/controllers/product/brand_controller.dart';
import 'package:e_commerce_app/features/shop/screens/brands/brand_products.dart';
import 'package:e_commerce_app/features/shop/screens/store/widgets/brand_card.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';

import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/effects/brand_shimmer.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/tabbar.dart';
import '../brands/all_brands.dart';
import '../search_screen/search_screen.dart';
import 'widgets/category_tab.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    final brandController = Get.put(BrandController());
    final controller = CategoryController.instance.featuredCategories;
    return DefaultTabController(
      length: controller.length,
      child: Scaffold(
        appBar: EAppBar(
          title: Row(
            children: [
              Text(
                'Abrah',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .apply(color: dark ? EColors.white : EColors.black),
              ),
              const SizedBox(
                width: ESizes.spaceBtnItems / 2,
              ),
              Text(
                'Store',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .apply(color: dark ? EColors.white : EColors.black),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () => Get.to(() => const ESearchScreen()),
              icon: Icon(
                Iconsax.search_favorite,
                size: 24,
                color: dark ? EColors.white : EColors.black,
              ),
            ),
            const ECartControlIcon()
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: EHelperFunctions.isDarkMode(context)
                    ? EColors.black
                    : EColors.white,
                expandedHeight: 270,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(ESizes.defaultSpace),
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      // const SizedBox(
                      //   height: ESizes.spaceBtnItems,
                      // ),
                      // const ESearchContainer(
                      //   text: 'Search In Store',
                      //   showBorder: true,
                      //   showBackground: false,
                      //   padding: EdgeInsets.zero,
                      // ),
                      // const SizedBox(
                      //   height: ESizes.spaceBtnItems,
                      // ),

                      //-- featured brands
                      ESectionHeading(
                        title: 'Featured Brands',
                        textColor: dark ? EColors.white : EColors.black,
                        //showActionButton: true,
                        onPressed: () => Get.to(() => const AllBrandsScreen()),
                      ),
                      const SizedBox(height: ESizes.spaceBtnItems / 1.5),
                      Obx(() {
                        if (brandController.isLoading.value) {
                          return const EBrandShimmer();
                        }
                        if (brandController.featuredBrands.isEmpty) {
                          return Center(
                            child: Text(
                              'No Data Found.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .apply(color: Colors.black),
                            ),
                          );
                        }
                        return EGridLayout(
                          mainAxisExtent: 55,
                          itemCount: brandController.featuredBrands.length,
                          itemBuilder: (_, index) {
                            final brand = brandController.featuredBrands[index];

                            return EBrandCard(
                              showBorder: true,
                              onTap: () =>
                                  Get.to(() => BrandProducts(brand: brand)),
                              brand: brand,
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ),

                //tabs
                bottom: ETabBar(
                  tabs: controller
                      .map((category) => Tab(
                            child: Text(category.name),
                          ))
                      .toList(),
                ),
              ),
            ];
          },
          //body
          body: TabBarView(
            children: controller
                .map((category) => ECategoryTab(category: category))
                .toList(),
          ),
        ),
      ),
    );
  }
}
