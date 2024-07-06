import 'package:e_commerce_app/features/shop/screens/store/widgets/brand_card.dart';
import 'package:flutter/material.dart';

import '../../../../../common/common_shapes/containers/circular_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class EShowBrandCase extends StatelessWidget {
  const EShowBrandCase({
    super.key,
    required this.images,
  });
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return ERoundedContainer(
      padding: const EdgeInsets.all(ESizes.sm),
      showBorder: true,
      borderColor: EColors.darkGrey,
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.only(bottom: ESizes.spaceBtnItems),
      child: Column(
        children: [
          const EBrandCard(
            showBorder: false,
          ),
          Row(
              children: images
                  .map((image) => brandTopProductsImageWidget(image, context))
                  .toList())
        ],
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
        child: Image(
          fit: BoxFit.contain,
          image: AssetImage(image),
        ),
      ),
    );
  }
}
