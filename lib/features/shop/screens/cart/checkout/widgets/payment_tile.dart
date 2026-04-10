import 'package:e_commerce_app/common/common_shapes/containers/circular_container.dart';
import 'package:e_commerce_app/features/shop/models/payment_method_model.dart';
import 'package:e_commerce_app/features/shop/screens/cart/checkout/controllers/checkout_controller.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class PaymentTile extends StatelessWidget {
  const PaymentTile({super.key, required this.paymentMethod});
  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    final checkoutController = CheckoutController.instance;
    final dark = EHelperFunctions.isDarkMode(context);
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        checkoutController.selectedPayemtMethod.value = paymentMethod;
        Get.back();
      },
      leading: ERoundedContainer(
        width: 60,
        height: 45,
        backgroundColor: EHelperFunctions.isDarkMode(context)
            ? EColors.light
            : EColors.white,
        padding: const EdgeInsets.all(ESizes.sm),
        child: Image(
          image: AssetImage(paymentMethod.image),
          fit: BoxFit.contain,
        ),
      ),
      title: Text(paymentMethod.name, style: TextStyle(color: dark ? EColors.white : EColors.black),),
      trailing: const Icon(Iconsax.arrow_right_34),
    );
  }
}
