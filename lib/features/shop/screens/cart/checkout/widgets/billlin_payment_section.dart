import 'package:e_commerce_app/common/common_shapes/containers/circular_container.dart';
import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/features/shop/screens/cart/checkout/controllers/checkout_controller.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EBillingPaymentSection extends StatelessWidget {
  const EBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CheckoutController());
    final dark = EHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        ESectionHeading(
          title: 'Payment Method',
          buttonTitle: 'Change',
          onPressed: () => controller.selectPaymentMethods(context),
        ),
        const SizedBox(
          height: ESizes.spaceBtnItems / 2,
        ),
        Obx(
          () => Row(
            children: [
              ERoundedContainer(
                width: 60,
                height: 35,
                backgroundColor: dark ? EColors.light : EColors.white,
                padding: const EdgeInsets.all(ESizes.sm),
                child: Image(
                  image:
                      AssetImage(controller.selectedPayemtMethod.value.image),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                width: ESizes.spaceBtnItems / 2,
              ),
              Text(
                controller.selectedPayemtMethod.value.name,
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
        )
      ],
    );
  }
}
