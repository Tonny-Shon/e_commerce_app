import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/common/products_cart/favorite_icon.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/common_shapes/containers/primary_curved_widget.dart';
import '../../../../../common/common_shapes/slider_images/slider_images.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/product/image_controller.dart';

class EProductImageSlider extends StatelessWidget {
  const EProductImageSlider({
    super.key,
    required this.product,
  });
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImageController());
    final images = controller.getAllProductImages(product);
    final dark = EHelperFunctions.isDarkMode(context);
    //final favoriteController = Get.put(FavoriteController());

    return EPrimaryCurvedWidget(
        child: Container(
      color: dark ? EColors.darkerGrey : EColors.light,
      child: Stack(
        children: [
          //Main Image
          SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(ESizes.productImageRadius * 2),
              child: Center(
                child: Obx(
                  () {
                    final image = controller.selectedProductImage.value;
                    return GestureDetector(
                      onTap: () => controller.showLargeImage(image),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        progressIndicatorBuilder: (_, __, downloadProgress) =>
                            CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: EColors.primaryColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          //Slider Images
          Positioned(
            right: 0,
            bottom: 30,
            left: ESizes.defaultSpace,
            child: SizedBox(
              height: 80,
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                separatorBuilder: (_, imdex) => const SizedBox(
                  width: ESizes.spaceBtnItems,
                ),
                itemBuilder: (_, index) => Obx(() {
                  final imageSelected =
                      controller.selectedProductImage.value == images[index];
                  return ERoundedImage(
                      isNetworkImage: true,
                      width: 80,
                      backgroundColor: dark ? EColors.dark : EColors.white,
                      onPressed: () =>
                          controller.selectedProductImage.value = images[index],
                      border: Border.all(
                          color: imageSelected
                              ? EColors.primaryColor
                              : Colors.transparent),
                      padding: const EdgeInsets.all(ESizes.sm),
                      imageUrl: images[index]);
                }),
              ),
            ),
          ),

          //App bar
          EAppBar(
            showBackArrow: true,
            actions: [EFavoriteIcon(productId: product.id)],
          )
        ],
      ),
    ));
  }
}
