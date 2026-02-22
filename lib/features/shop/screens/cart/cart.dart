import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/features/shop/screens/cart/checkout/check_out.dart';
import 'package:e_commerce_app/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce_app/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce_app/features/authentication/screens/login/login.dart';
import 'package:e_commerce_app/common/widgets/checkout/checkout_label.dart';
import 'package:e_commerce_app/common/widgets/checkout/checkout_action_button.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../controllers/product/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final itemCount = controller.cartItems.length;
    return Scaffold(
      appBar: EAppBar(
        showBackArrow: true,
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          if (itemCount > 0)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // Optional: Scroll to top or refresh
                    },
                    icon: const Icon(Iconsax.shopping_cart),
                  ),
                  Text(
                    '$itemCount Items',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: EColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
        ],
      ),
      body: Obx(() {
        const emptyWidget = Center(child: Text('Cart is empty'));
        if (controller.cartItems.isEmpty) {
          return emptyWidget;
        } else {
          return const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(ESizes.defaultSpace),
              //item in cart
              child: ECartItems(),
            ),
          );
        }
      }),
      //checkout button
      bottomNavigationBar: controller.cartItems.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(ESizes.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CheckoutLabel(
                    price: 'Ugx - ${controller.totalCartPrice.value} /=',
                  ),
                  CheckoutActionButton(
                    label: 'Checkout',
                    onPressed: () {
                      final auth = AuthenticationRepository.instance.authUser;
                      if (auth != null) {
                        Get.to(() => const CheckoutScreen());
                      } else {
                        Get.to(() => const LoginScreen());
                        Get.snackbar('Login required', 'Please login to continue');
                      }
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
