import 'package:e_commerce_app/features/shop/models/brand_model.dart';
import 'package:e_commerce_app/features/shop/screens/store/widgets/brand_title_icon.dart';
import 'package:flutter/material.dart';

import '../../../../../common/common_shapes/containers/circular_container.dart';
import '../../../../../common/widgets/cicular_image/circular_image.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/sizes.dart';

class EBrandCard extends StatelessWidget {
  const EBrandCard({
    super.key,
    required this.showBorder,
    this.onTap,
    required this.brand,
  });
  final bool showBorder;

  final void Function()? onTap;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ERoundedContainer(
        showBorder: showBorder,
        padding: const EdgeInsets.all(ESizes.sm),
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            //Icon
            Flexible(
              child: ECircularImage(
                image: brand.image,
                isNetworkImage: true,
                backgroundColor: Colors.transparent,
                // overlayColor: EHelperFunctions.isDarkMode(context)
                //     ? EColors.black
                //     : EColors.white,
              ),
            ),
            const SizedBox(
              width: ESizes.spaceBtnItems / 2,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EBrandTitleVerifiedIcon(
                  title: brand.name,
                  brandTextSize: TextSizes.large,
                ),
                Text(
                  '${brand.productCount ?? 0} products',
                  style: Theme.of(context).textTheme.labelMedium,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
