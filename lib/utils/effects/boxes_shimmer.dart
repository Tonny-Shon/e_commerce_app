import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/effects/shimmer.dart';
import 'package:flutter/material.dart';

class EBoxesShimmer extends StatelessWidget {
  const EBoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: EShimmerEffect(width: 150, height: 100),
        ),
        SizedBox(
          width: ESizes.spaceBtnItems,
        ),
        Expanded(
          child: EShimmerEffect(width: 150, height: 100),
        ),
        SizedBox(
          width: ESizes.spaceBtnItems,
        ),
        Expanded(
          child: EShimmerEffect(width: 150, height: 100),
        ),
      ],
    );
  }
}
