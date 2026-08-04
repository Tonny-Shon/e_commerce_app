import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/colors.dart';

class ImageController extends GetxController {
  static ImageController get instance => Get.find();

  //variables
  RxString selectedProductImage = ''.obs;

  //Get all Images from product and variations
  List<String> getAllProductImages(ProductModel product) {
    Set<String> images = {};

    images.add(product.thumbnail);

    //assign Thumbnail as selected image
    selectedProductImage.value = product.thumbnail;

    //Get all images from the Product Model if not null
    if (product.images != null) {
      images.addAll(product.images!);
    }
    //Get all images from the product variations if not null
    // if (product.productVariations != null ||
    //     product.productVariations!.isNotEmpty) {
    //   images.addAll(
    //       product.productVariations!.map((variation) => variation.image));
    // }
    return images.toList();
  }

  ////Show image popup
  void showLargeImage(String image) {
    final dark = EHelperFunctions.isDarkMode(Get.context!);
    Get.to(
        fullscreenDialog: true,
        () => Dialog.fullscreen(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: ESizes.defaultSpace * 2,
                        horizontal: ESizes.defaultSpace),
                    child: CachedNetworkImage(
                      imageUrl: image,
                    ),
                  ),
                  const SizedBox(
                    height: ESizes.spaceBtnSections,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 150,
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        child:  Text('Close', style: TextStyle(color: dark ? EColors.black : EColors.white),),
                      ),
                    ),
                  )
                ],
              ),
            ));
  }
}
