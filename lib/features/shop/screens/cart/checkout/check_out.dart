import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce_app/features/personalization/models/address_model.dart';
import 'package:e_commerce_app/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce_app/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:e_commerce_app/utils/helpers/pricing_calculator.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../personalization/models/branch_model.dart';
import 'controllers/payment_controller.dart';
import 'widgets/billing_amount_section.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = Get.put(AddressController());
    final cartController = Get.put(CartController());
    final subTotal = cartController.totalCartPrice.value;
    // final orderController = Get.put(OrderController());
    final totalAmount = PricingCalculator.calculateTotalPrice(
        subTotal, '${addressController.selectedAddress.value}');
    final dark = EHelperFunctions.isDarkMode(context);
    final controller = Get.put(PaymentController());

    return Scaffold(
      appBar: EAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: dark ? EColors.white : EColors.black),
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
              ESectionHeading(
                title: 'Choose Branch',
                showActionButton: false,
                textColor: dark ? EColors.white : EColors.black,
              ),
              const SizedBox(
                height: ESizes.sm,
              ),
              // const ELocationSelection(),
              Obx(() {
                return DropdownButtonFormField<BranchModel>(
                  value: addressController.selectedBranch.value.id.isEmpty
                      ? null
                      : addressController.selectedBranch.value,
                  hint: const Text("Select Branch"),
                  items: addressController.branches.map((branch) {
                    return DropdownMenuItem<BranchModel>(
                      value: branch,
                      child: Text(branch.name,
                          style: TextStyle(
                              color: dark ? EColors.white : EColors.black)),
                    );
                  }).toList(),
                  onChanged: (value) => addressController.selectBranch(value!),
                );
              }),

              const SizedBox(
                height: ESizes.spaceBtnSections,
              ),

              ESectionHeading(
                title: 'Choose Pick Station',
                showActionButton: false,
                textColor: dark ? EColors.white : EColors.black,
              ),

              const SizedBox(
                height: ESizes.sm,
              ),

              Obx(() {
                return DropdownButtonFormField<AddressModel>(
                  focusColor: Colors.transparent,
                  value: addressController.selectedAddress.value.id.isEmpty
                      ? null
                      : addressController.selectedAddress.value,
                  hint: const Text("Select Pick Station"),
                  items: addressController.address.map((station) {
                    return DropdownMenuItem(
                      value: station,
                      child: Text(
                        "${station.name} - UGX ${station.shippingAmount}",
                        style: TextStyle(
                            color: dark ? EColors.white : EColors.black),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) => addressController.selectStation(value!),
                );
              }),

              const SizedBox(
                height: ESizes.spaceBtnSections,
              ),

              ESectionHeading(
                title: 'Payment Details',
                showActionButton: false,
                textColor: dark ? EColors.whiteColor : EColors.black,
              ),
              const SizedBox(
                height: 12,
              ),
              //Billing section
              const Column(
                children: [
                  //Pricing
                  EBillingAmountSection(),
                  SizedBox(
                    height: ESizes.spaceBtnItems,
                  ),

                  //Divider
                  Divider(
                    height: 1,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(ESizes.defaultSpace),
        child: Obx(
          () => ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: EColors.primaryColor,
              side: BorderSide.none,
            ),
            onPressed: () {
              if (subTotal <= 0) {
                ELoaders.warningSnackBar(
                  title: 'Empty Cart',
                  message: 'Add items to proceed',
                );
                return;
              }

              if (controller.isProcessing.value) {
                return; // Button is already disabled while processing
              }
              // Get.to(() => PaymentScreen(totalAmount: totalAmount));
              controller.startPayment(totalAmount);
            },
            child: Text(
              'Checkout UGX - ${PricingCalculator.calculateTotalPrice(subTotal, '${addressController.selectedAddress.value}')}',
            ),
          ),
        ),
      ),
    );
  }
}
