import 'package:e_commerce_app/common/common_shapes/containers/circular_container.dart';
import 'package:e_commerce_app/common/common_shapes/containers/product_text/product_text_price.dart';
import 'package:e_commerce_app/common/common_shapes/slider_images/slider_images.dart';
import 'package:e_commerce_app/common/product_size_text.dart';
import 'package:e_commerce_app/common/products_cart/favorite_icon.dart';
import 'package:e_commerce_app/features/shop/controllers/product/product_controller.dart';
import 'package:e_commerce_app/features/shop/screens/store/product_details/product_details.dart';
import 'package:e_commerce_app/features/shop/screens/store/widgets/brand_title_icon.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../features/shop/models/product_model.dart';

class EProductCardHorizontal extends StatelessWidget {
  const EProductCardHorizontal({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salesPercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = EHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetails(product: product)),
      child: Container(
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
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ERoundedImage(
                      imageUrl: product.thumbnail,
                      isNetworkImage: true,
                      applyImageRadius: true,
                    ),
                  ),

                  /// -- Sale tag
                  if (salesPercentage != null)
                    Positioned(
                      top: 12,
                      child: ERoundedContainer(
                        radius: ESizes.sm,
                        backgroundColor:
                            EColors.secondaryColor.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: ESizes.md, vertical: ESizes.md),
                        child: Center(
                          child: Text(
                            salesPercentage,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .apply(color: EColors.black),
                          ),
                        ),
                      ),
                    ),
                  //favorite icon button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: EFavoriteIcon(
                      productId: product.id,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EProductTitleText(
                          title: product.title,
                          smallSize: true,
                        ),
                        const SizedBox(
                          height: ESizes.spaceBtnItems / 2,
                        ),
                        EBrandTitleVerifiedIcon(title: product.brand!.name)
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //price
                        Flexible(
                            child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: ESizes.sm),
                              child:
                                  EProductPriceText(price: '${product.price}'),
                            ),
                          ],
                        )),
                        //add to cart
                        Container(
                          decoration: const BoxDecoration(
                            color: EColors.redColor,
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
      ),
    );
  }
}
