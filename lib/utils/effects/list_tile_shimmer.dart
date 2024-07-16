import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/effects/shimmer.dart';
import 'package:flutter/material.dart';

class EListTileShimmer extends StatelessWidget {
  const EListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            EShimmerEffect(
              width: 50,
              height: 10,
              radius: 50,
            ),
            SizedBox(
              width: ESizes.spaceBtnItems,
            ),
            Expanded(
              child: Column(
                children: [
                  Flexible(
                    child: EShimmerEffect(
                      width: 100,
                      height: 50,
                    ),
                  ),
                  SizedBox(
                    height: ESizes.spaceBtnItems / 2,
                  ),
                  EShimmerEffect(width: 80, height: 12),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
