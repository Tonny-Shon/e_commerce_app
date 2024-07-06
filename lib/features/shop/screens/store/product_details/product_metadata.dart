import 'package:e_commerce_app/common/common_shapes/containers/circular_container.dart';
import 'package:e_commerce_app/images/images.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../common/common_shapes/containers/product_text/product_text_price.dart';
import '../../../../../common/product_size_text.dart';
import '../../../../../common/widgets/cicular_image/circular_image.dart';
import '../../../../../utils/constants/enums.dart';
import '../widgets/brand_text.dart';

class EProductMetaData extends StatelessWidget {
  const EProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    //final darkMode = EHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            //size tag
            ERoundedContainer(
              radius: ESizes.sm,
              backgroundColor: EColors.secondaryColor.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: ESizes.sm, vertical: ESizes.xs),
              child: Text(
                '25%',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: EColors.black),
              ),
            ),
            const SizedBox(
              width: ESizes.spaceBtnItems,
            ),

            //price
            Text(
              'Ugx 400k',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .apply(decoration: TextDecoration.lineThrough),
            ),
            const SizedBox(
              width: ESizes.spaceBtnItems,
            ),
            const EProductPriceText(
              price: '370k',
              isLarge: true,
            )
          ],
        ),
        const SizedBox(
          height: ESizes.spaceBtnItems / 1.5,
        ),
        //title
        const EProductTitleText(
          title: '6 x 6 inch King size Bed',
        ),
        const SizedBox(
          height: ESizes.spaceBtnItems / 1.5,
        ),

        // Stock status
        Row(
          children: [
            const EProductTitleText(title: 'Status'),
            const SizedBox(
              width: 8,
            ),
            Text(
              'In Stock',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(
          height: ESizes.spaceBtnItems / 2,
        ),

        //Brand
        const Row(
          children: [
            ECircularImage(
              image: EImages.icBeddings,
              width: 40,
              height: 40,
              //overlayColor: darkMode ? EColors.white : EColors.black,
            ),
            EBrandTitleText(
              title: 'King Size Bed',
              brandTextSize: TextSizes.medium,
            ),
          ],
        ),
      ],
    );
  }
}
