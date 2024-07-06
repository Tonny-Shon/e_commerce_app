import 'package:e_commerce_app/common/common_shapes/containers/circular_container.dart';
import 'package:e_commerce_app/common/common_shapes/containers/shadow.dart';
import 'package:e_commerce_app/common/common_shapes/slider_images/slider_images.dart';
import 'package:e_commerce_app/common/product_size_text.dart';
import 'package:e_commerce_app/features/shop/screens/store/product_details/product_details.dart';
import 'package:e_commerce_app/images/images.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../common_shapes/containers/product_text/product_text_price.dart';
import '../icons/icon_widget.dart';

class EProductCardVertical extends StatelessWidget {
  const EProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(const ProductDetails()),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            boxShadow: [EShadowStyle.verticalProductShadow],
            borderRadius: BorderRadius.circular(ESizes.productImageRadius),
            color: dark ? EColors.darkGrey : EColors.white),
        child: Column(
          children: [
            //thumbnail
            ERoundedContainer(
              height: 100,
              padding: const EdgeInsets.all(ESizes.sm),
              backgroundColor: dark ? EColors.dark : EColors.light,
              child: Stack(
                children: [
                  //image thumbnail
                  const ERoundedImage(
                    imageUrl: EImages.icBeddings,
                    applyImageRadius: true,
                  ),

                  //sale tag
                  Positioned(
                    top: 10,
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
                      )),
                ],
              ),
            ),

            const SizedBox(
              height: ESizes.spaceBtnItems / 2,
            ),
            //Details
            Padding(
              padding: const EdgeInsets.only(left: ESizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const EProductTitleText(
                    title: '6 x 6 Bedsize',
                    smallSize: true,
                  ),
                  const SizedBox(
                    height: ESizes.spaceBtnItems / 2,
                  ),
                  Row(
                    children: [
                      Text(
                        'EuroFoam',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(
                        width: ESizes.sm,
                      ),
                      const Icon(
                        Iconsax.verify5,
                        color: EColors.primaryColor,
                        size: ESizes.iconXs,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Price
                const Padding(
                  padding: EdgeInsets.only(left: ESizes.sm),
                  child: EProductPriceText(
                    price: '400k',
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: EColors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        ESizes.cardRadiusMd,
                      ),
                      bottomRight: Radius.circular(ESizes.productImageRadius),
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
    );
  }
}
