import 'package:e_commerce_app/common/common_shapes/layouts/grid_layout.dart';
import 'package:e_commerce_app/utils/effects/shimmer.dart';
import 'package:flutter/material.dart';

class EBrandShimmer extends StatelessWidget {
  const EBrandShimmer({super.key, this.itemCount = 4});
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return EGridLayout(
      mainAxisExtent: 50,
      itemCount: itemCount,
      itemBuilder: (_, __) => const EShimmerEffect(width: 300, height: 80),
    );
  }
}
