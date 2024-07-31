import 'package:e_commerce_app/common/common_shapes/containers/circular_container.dart';
import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce_app/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce_app/features/shop/screens/cart/checkout/coupon_widget.dart';
import 'package:e_commerce_app/features/shop/screens/cart/checkout/widgets/billlin_payment_section.dart';
import 'package:e_commerce_app/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:e_commerce_app/utils/helpers/pricing_calculator.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/order_controller.dart';
import 'widgets/billing_amount_section.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = Get.put(AddressController());
    final cartController = Get.put(CartController());
    final subTotal = cartController.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final totalAmount = PricingCalculator.calculateTotalPrice(
        subTotal, '${addressController.selectedAddress.value}');
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

              //location field
              const ESectionHeading(
                title: 'Choose location',
                showActionButton: false,
              ),
              const SizedBox(
                height: ESizes.sm,
              ),
              const ELocationSelection(),
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
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(ESizes.defaultSpace),
        child: Obx(
          () => ElevatedButton(
              onPressed: subTotal > 0
                  ? () => orderController.processOrder(totalAmount)
                  : () => ELoaders.warningSnackBar(
                      title: 'Empty Cart',
                      message: 'Add item in the cat in order to proceed'),
              child: Text(
                  'Checkout Ugx - ${PricingCalculator.calculateTotalPrice(subTotal, '${addressController.selectedAddress.value}')}')),
        ),
      ),
    );
  }
}
