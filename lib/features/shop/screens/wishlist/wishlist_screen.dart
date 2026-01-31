import 'package:e_commerce_app/common/products_cart/product_card_vertical.dart';
import 'package:e_commerce_app/features/shop/controllers/product/favorite_controller.dart';
import 'package:e_commerce_app/utils/effects/vertical_shimmer_effect.dart';
import 'package:e_commerce_app/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/common_shapes/layouts/grid_layout.dart';
import '../../../../common/products_cart/cart_menu_icon.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoriteController());

    return Scaffold(
        appBar: EAppBar(
          title: Text(
            'WishList',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          showBackArrow: false,
          actions: const [
             ECartControlIcon(
          iconColor: EColors.primaryColor,
        )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(ESizes.defaultSpace),
            child: Obx(
                  () => FutureBuilder(
                  future: controller.favoriteProducts(),
                  builder: (context, snapshot) {
                    const loader = EVerticalShimmerEffect(
                      itemCount: 4,
                    );
                    // Check for empty state
                if (snapshot.connectionState == ConnectionState.done &&
                    (snapshot.data == null || snapshot.data!.isEmpty)) {
                  return _buildEmptyWishlist(context);
                }
                    //Nothing found
                    // const emptyWidget = Center(
                    //   child: Column(
                    //     children: [Text('Your wish List is empty')],
                    //   ),
                    // );
                    final widget = ECloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot,
                        loader: loader,
                        nothingFound: _buildEmptyWishlist(context));
                    if (widget != null) return widget;

                    final products = snapshot.data!;
                    return EGridLayout(
                      itemCount: products.length,
                      itemBuilder: (_, index) => EProductCardVertical(
                        product: products[index],
                      ),
                    );
                  }),
            ),
          ),
        ));
  }

    Widget _buildEmptyWishlist(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: ESizes.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated Heart Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    EColors.primaryColor.withValues(alpha:0.2),
                    EColors.secondaryColor.withValues(alpha:0.2),
                  ],
                ),
              ),
              child: const Icon(
                Iconsax.heart,
                size: 60,
                color: EColors.primaryColor,
              ),
            ),
            const SizedBox(height: ESizes.spaceBtnItems * 2),

            // Title
            Text(
              'Your Wishlist is Empty',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: EColors.darkerGrey,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: ESizes.spaceBtnItems),

            // Description
            Text(
              'Looks like you haven\'t added anything to your wishlist yet. Start exploring and add items you love!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: EColors.darkGrey,
                  ),
              textAlign: TextAlign.center,
            ),
            // const SizedBox(height: ESizes.spaceBtnSections * 2),

            // Explore Button
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     onPressed: () => Get.to(() => const HomeScreen()),
            //     style: ElevatedButton.styleFrom(
            //       padding: const EdgeInsets.symmetric(vertical: 16),
            //       backgroundColor: EColors.primaryColor,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //       elevation: 0,
            //       shadowColor: Colors.transparent,
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         const Icon(Iconsax.shop, color: Colors.white, size: 20),
            //         const SizedBox(width: ESizes.sm),
            //         Text(
            //           'Explore Products',
            //           style: Theme.of(context)
            //               .textTheme
            //               .titleMedium
            //               ?.copyWith(color: Colors.white),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            // const SizedBox(height: ESizes.spaceBtnItems),

            // // Browse Categories Button
            // OutlinedButton(
            //   onPressed: () {},
            //   // => Get.to(() => const CategoriesScreen()),
            //   style: OutlinedButton.styleFrom(
            //     padding: const EdgeInsets.symmetric(vertical: 16),
            //     side: const BorderSide(color: EColors.primaryColor),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       const Icon(Iconsax.category, color: EColors.primaryColor, size: 20),
            //       const SizedBox(width: ESizes.sm),
            //       Text(
            //         'Browse Categories',
            //         style: Theme.of(context)
            //             .textTheme
            //             .titleMedium
            //             ?.copyWith(color: EColors.primaryColor),
            //       ),
            //     ],
            //   ),
            // ),

            // Tip Section
            const SizedBox(height: ESizes.spaceBtnSections * 2),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: EColors.light.withValues(alpha:0.5),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: EColors.grey.withValues(alpha:0.2)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: EColors.primaryColor.withValues(alpha:0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Iconsax.lamp_charge,
                          color: EColors.primaryColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: ESizes.sm),
                      Text(
                        'Pro Tip',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: ESizes.sm),
                  Text(
                    'Tap the heart icon on any product to add it to your wishlist for later.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: EColors.darkGrey,
                        ),
                    textAlign: TextAlign.center,
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
