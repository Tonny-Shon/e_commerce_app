import 'package:e_commerce_app/common/products_cart/product_card_vertical.dart';
import 'package:e_commerce_app/features/shop/controllers/product/favorite_controller.dart';
import 'package:e_commerce_app/utils/effects/vertical_shimmer_effect.dart';
import 'package:e_commerce_app/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/common_shapes/layouts/grid_layout.dart';
import '../../../../common/widgets/appbar/appbar.dart';
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
          // actions: [
          //   ECircularIcon(
          //     icon: Icons.add,
          //     onPressed: () => Get.to(
          //       () => const NavigationMenu(),
          //     ),
          //   ),
          // ],
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
                    //Nothing found
                    const emptyWidget = Center(
                      child: Column(
                        children: [Text('Your wish List is empty')],
                      ),
                    );
                    final widget = ECloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot,
                        loader: loader,
                        nothingFound: emptyWidget);
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
}
