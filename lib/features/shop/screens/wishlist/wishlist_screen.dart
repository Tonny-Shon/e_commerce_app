import 'package:e_commerce_app/common/products_cart/product_card_vertical.dart';
import 'package:e_commerce_app/features/shop/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/common_shapes/layouts/grid_layout.dart';
import '../../../../common/icons/icon_widget.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: EAppBar(
          title: Text(
            'WishList',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            ECircularIcon(
              icon: Icons.add,
              onPressed: () => Get.to(
                () => const HomeScreen(),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(ESizes.defaultSpace),
            child: Column(
              children: [
                EGridLayout(
                  itemCount: 3,
                  itemBuilder: (_, index) => const EProductCardVertical(),
                ),
              ],
            ),
          ),
        ));
  }
}
