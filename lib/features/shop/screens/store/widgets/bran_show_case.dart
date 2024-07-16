import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/features/shop/models/brand_model.dart';
import 'package:e_commerce_app/features/shop/screens/brands/brand_products.dart';
import 'package:e_commerce_app/features/shop/screens/store/widgets/brand_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/common_shapes/containers/circular_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/effects/shimmer.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class EShowBrandCase extends StatelessWidget {
  const EShowBrandCase({
    super.key,
    required this.images,
    required this.brand,
  });
  final List<String> images;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(
        () => BrandProducts(brand: brand),
      ),
      child: ERoundedContainer(
        padding: const EdgeInsets.all(ESizes.sm),
        showBorder: true,
        borderColor: EColors.darkGrey,
        backgroundColor: Colors.transparent,
        margin: const EdgeInsets.only(bottom: ESizes.spaceBtnItems),
        child: Column(
          children: [
            EBrandCard(
              showBorder: false,
              brand: brand,
            ),
            Row(
                children: images
                    .map((image) => brandTopProductsImageWidget(image, context))
                    .toList())
          ],
        ),
      ),
    );
  }

  Widget brandTopProductsImageWidget(String image, context) {
    return Expanded(
      child: ERoundedContainer(
        height: 100,
        margin: const EdgeInsets.only(right: ESizes.sm),
        padding: const EdgeInsets.all(ESizes.sm),
        backgroundColor: EHelperFunctions.isDarkMode(context)
            ? EColors.darkerGrey
            : EColors.light,
        child: CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.contain,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                const EShimmerEffect(width: 100, height: 80),
            errorWidget: (context, url, error) => const Icon(Icons.error)),
      ),
    );
  }
}
