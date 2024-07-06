import 'package:e_commerce_app/common/common_shapes/containers/circular_container.dart';
import 'package:e_commerce_app/common/common_shapes/containers/product_text/product_text_price.dart';
import 'package:e_commerce_app/common/common_shapes/slider_images/slider_images.dart';
import 'package:e_commerce_app/common/product_size_text.dart';
import 'package:e_commerce_app/features/shop/screens/store/widgets/brand_title_icon.dart';
import 'package:e_commerce_app/images/images.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../icons/icon_widget.dart';

class EProductCardHorizontal extends StatelessWidget {
  const EProductCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        //boxShadow: [EShadowStyle.verticalProductShadow],
        borderRadius: BorderRadius.circular(
          ESizes.productImageRadius,
        ),
        color: dark ? EColors.darkerGrey : EColors.lightContainer,
      ),
      child: Row(
        children: [
          //thumbnail
          ERoundedContainer(
            height: 120,
            padding: const EdgeInsets.all(ESizes.sm),
            backgroundColor: dark ? EColors.dark : EColors.light,
            child: Stack(
              children: [
                const SizedBox(
                  width: 120,
                  height: 120,
                  child: ERoundedImage(
                    imageUrl: EImages.icBeddings,
                    applyImageRadius: true,
                  ),
                ),

                /// -- Sale tag
                Positioned(
                  top: 12,
                  child: ERoundedContainer(
                    radius: ESizes.sm,
                    backgroundColor: EColors.secondaryColor.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: ESizes.md, vertical: ESizes.md),
                    child: Center(
                      child: Text(
                        '25%',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: EColors.black),
                      ),
                    ),
                  ),
                ),
                //favorite icon button
                const Positioned(
                  top: 0,
                  right: 0,
                  child: ECircularIcon(
                    icon: Iconsax.heart5,
                    color: EColors.redColor,
                  ),
                ),
              ],
            ),
          ),
          //Details
          SizedBox(
            width: 172,
            child: Padding(
              padding: const EdgeInsets.only(top: ESizes.sm, left: ESizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EProductTitleText(
                        title: '6 x 6 Inch mattress',
                        smallSize: true,
                      ),
                      SizedBox(
                        height: ESizes.spaceBtnItems / 2,
                      ),
                      EBrandTitleVerifiedIcon(title: 'King Size')
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //price
                      const Flexible(child: EProductPriceText(price: '370k')),
                      //add to cart
                      Container(
                        decoration: const BoxDecoration(
                          color: EColors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(ESizes.cardRadiusMd),
                            bottomRight:
                                Radius.circular(ESizes.productImageRadius),
                          ),
                        ),
                        child: const SizedBox(
                          width: ESizes.iconLg * 1.2,
                          height: ESizes.iconLg * 1.2,
                          child: Center(
                            child: Icon(
                              Iconsax.add,
                              color: EColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
