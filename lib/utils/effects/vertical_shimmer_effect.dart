import 'package:e_commerce_app/common/common_shapes/layouts/grid_layout.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/effects/shimmer.dart';
import 'package:flutter/material.dart';

class EVerticalShimmerEffect extends StatelessWidget {
  const EVerticalShimmerEffect({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return EGridLayout(
      itemCount: itemCount,
      itemBuilder: (_, __) => const SizedBox(
        width: 380,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EShimmerEffect(width: 160, height: 100),
            SizedBox(
              height: ESizes.spaceBtnItems,
            ),

            //Text
            EShimmerEffect(width: 160, height: 15),
            SizedBox(
              height: ESizes.spaceBtnItems / 2,
            ),
            EShimmerEffect(width: 110, height: 15)
          ],
        ),
      ),
    );
  }
}
