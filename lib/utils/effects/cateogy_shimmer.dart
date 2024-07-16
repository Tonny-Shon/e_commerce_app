import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/effects/shimmer.dart';
import 'package:flutter/material.dart';

class ECategoryShimmer extends StatelessWidget {
  const ECategoryShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (_, __) {
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EShimmerEffect(
                  width: 55,
                  height: 55,
                  radius: 55,
                ),
                SizedBox(
                  height: ESizes.spaceBtnItems / 2,
                ),

                ///Text
                EShimmerEffect(width: 55, height: 8)
              ],
            );
          },
          separatorBuilder: (_, __) => const SizedBox(
                width: ESizes.spaceBtnItems,
              ),
          itemCount: itemCount),
    );
  }
}
