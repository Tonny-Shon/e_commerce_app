import 'package:e_commerce_app/common/common_shapes/containers/circular_container.dart';
import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/features/shop/screens/cart/checkout/coupon_widget.dart';
import 'package:e_commerce_app/features/shop/screens/cart/checkout/widgets/billing_address_section.dart';
import 'package:e_commerce_app/features/shop/screens/cart/checkout/widgets/billlin_payment_section.dart';
import 'package:e_commerce_app/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:e_commerce_app/images/images.dart';
import 'package:e_commerce_app/navigation_menu.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/success_screen/success_screen.dart';
import 'widgets/billing_amount_section.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: EAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              //item in cart
              const ECartItems(
                showAddRemoveButtons: false,
              ),
              const SizedBox(
                height: ESizes.spaceBtnItems,
              ),

              //coupon textfield

              const ECouponCode(),
              const SizedBox(
                height: ESizes.spaceBtnSections,
              ),

              //Billing section
              ERoundedContainer(
                padding: const EdgeInsets.all(ESizes.md),
                showBorder: true,
                backgroundColor: dark ? EColors.black : EColors.white,
                child: const Column(
                  children: [
                    //Pricing
                    EBillingAmountSection(),
                    SizedBox(
                      height: ESizes.spaceBtnItems,
                    ),

                    //Divider
                    Divider(),
                    SizedBox(
                      height: ESizes.spaceBtnItems,
                    ),

                    //Payment methods
                    EBillingPaymentSection(),
                    SizedBox(
                      height: ESizes.spaceBtnItems,
                    ),
                    //Addresses
                    EBillingAddressSection()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(ESizes.defaultSpace),
        child: ElevatedButton(
            onPressed: () => Get.to(
                  () => SuccessScreen(
                      onPressed: () => Get.to(() => const NavigationMenu()),
                      image: EImages.icFood,
                      title: 'Payment Successful',
                      subTitle: 'Your Item will be shipped soon'),
                ),
            child: const Text('Checkout Ugx - 14894000')),
      ),
    );
  }
}
