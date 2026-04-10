import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class CheckoutLabel extends StatelessWidget {
  const CheckoutLabel({super.key, required this.price});
  final String price;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Total',
          style: Theme.of(context).textTheme.bodySmall,
        ),
       const SizedBox(height: ESizes.spaceBtnItems),
        Text(
          price,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: EColors.primaryColor, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
