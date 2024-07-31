import 'package:e_commerce_app/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce_app/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/helpers/pricing_calculator.dart';

class EBillingAmountSection extends StatelessWidget {
  const EBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final addressController = AddressController.instance;
    return Column(
      children: [
        //subtotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Subtotal',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Ugx - $subTotal',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(
          height: ESizes.spaceBtnItems / 2,
        ),

        //Shipping fee
        Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Shipping fee',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Ugx - ${PricingCalculator.calculateShippingCost(subTotal, '${addressController.selectedAddress.value}')}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          );
        }),

        const SizedBox(
          height: ESizes.spaceBtnItems / 2,
        ),

        //tax fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tax fee',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Ugx - ${PricingCalculator.calculateTax(subTotal, '${addressController.selectedAddress.value}')}',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),

        const SizedBox(
          height: ESizes.spaceBtnItems / 2,
        ),

        //Order Total
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order Total',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Ugx - ${PricingCalculator.calculateTotalPrice(subTotal, '${addressController.selectedAddress.value}')}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
