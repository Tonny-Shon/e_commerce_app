import 'package:e_commerce_app/common/common_shapes/containers/circular_container.dart';
import 'package:e_commerce_app/common/common_shapes/containers/shadow.dart';
import 'package:e_commerce_app/common/common_shapes/slider_images/slider_images.dart';
import 'package:e_commerce_app/common/product_size_text.dart';
import 'package:e_commerce_app/common/products_cart/favorite_icon.dart';
import 'package:e_commerce_app/features/shop/controllers/product/product_controller.dart';
import 'package:e_commerce_app/features/shop/screens/store/product_details/product_details.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../features/shop/models/product_model.dart';
import '../common_shapes/containers/product_text/product_text_price.dart';
import 'add_to_cart_button.dart';

class EProductCardVertical extends StatelessWidget {
  const EProductCardVertical({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(ProductDetails(
        product: product,
      )),
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
              width: 180,
              height: 100,
              padding: const EdgeInsets.all(ESizes.sm),
              backgroundColor: dark ? EColors.dark : EColors.light,
              child: Stack(
                children: [
                  //image thumbnail
                  Center(
                    child: ERoundedImage(
                      width: MediaQuery.of(context).size.width,
                      imageUrl: product.thumbnail,
                      applyImageRadius: true,
                      isNetworkImage: true,
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

            const SizedBox(
              height: ESizes.spaceBtnItems / 2,
            ),
            //Details
            Padding(
              padding: const EdgeInsets.only(left: ESizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EProductTitleText(
                    title: product.title,
                    smallSize: true,
                  ),
                  const SizedBox(
                    height: ESizes.spaceBtnItems / 2,
                  ),
                  Row(
                    children: [
                      Text(
                        product.brand != null
                            ? product.brand!.name
                            : 'No Brand',
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
                Flexible(
                  child: Column(
                    children: [
                      if (product.productType ==
                              ProductType.single.toString() &&
                          product.salePrice > 0)
                        Padding(
                          //Price, show sale price as main price if sale exists.
                          padding: const EdgeInsets.only(left: ESizes.sm),
                          child: Text(
                            product.price.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                        ),
                      Padding(
                        //Price, show sale price as main price if sale exists.
                        padding: const EdgeInsets.only(left: ESizes.sm),
                        child: EProductPriceText(price: product.price.toString()
                            //controller.getProductPrice(product),
                            ),
                      ),
                    ],
                  ),
                ),

                //add to cart button
                ProductCardAddToCartButton(
                  product: product,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
