import 'package:e_commerce_app/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce_app/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/helpers/pricing_calculator.dart';

class EBillingAmountSection extends StatelessWidget {
  const EBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final addressController = AddressController.instance;
    final dark = EHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        //subtotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Subtotal',
              style: Theme.of(context).textTheme.bodyLarge!.apply(color: dark ? EColors.white : EColors.black),
            ),
            Text(
              'Ugx - $subTotal',
              style: Theme.of(context).textTheme.bodyLarge!.apply(color: dark ? EColors.white : EColors.black) ,
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
                style: Theme.of(context).textTheme.bodyLarge!.apply(color: dark ? EColors.white : EColors.black),
              ),
              Text(
                'Ugx - ${PricingCalculator.calculateShiipingCost(subTotal, '${addressController.selectedAddress.value}')}',
                style: Theme.of(context).textTheme.labelLarge!.apply(color: dark ? EColors.white : EColors.black) ,
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
              style: Theme.of(context).textTheme.bodyMedium!.apply(color: dark ? EColors.white : EColors.black),
            ),
            Text(
              'Ugx - ${PricingCalculator.calculateTax(subTotal, '${addressController.selectedAddress.value}')}',
              style: Theme.of(context).textTheme.labelLarge!.apply(color: dark ? EColors.white : EColors.black),
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
                style: Theme.of(context).textTheme.bodyMedium!.apply(color: dark ? EColors.white : EColors.black),
              ),
              Text(
                'Ugx - ${PricingCalculator.calculateTotalPrice(subTotal, '${addressController.selectedAddress.value}')}',
                style: Theme.of(context).textTheme.titleMedium!.apply(color: dark ? EColors.white : EColors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
