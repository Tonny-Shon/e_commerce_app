import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/utils/effects/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/common_shapes/containers/circular_container.dart';
import '../../../../../common/common_shapes/slider_images/slider_images.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/banner_contorller.dart';

class ECarouselSlider extends StatelessWidget {
  const ECarouselSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(() {
      if (controller.isLoading.value) {
        return const EShimmerEffect(width: double.infinity, height: 190);
      }
      if (controller.banners.isEmpty) {
        return const Center(
          child: Text('No Data Found'),
        );
      } else {
        return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  viewportFraction: 1.3,
                  onPageChanged: (index, _) =>
                      controller.updatepageIndicator(index)),
              items: controller.banners
                  .map((banner) => ERoundedImage(
                        imageUrl: banner.imageUrl,
                        isNetworkImage: true,
                        onPressed: () => Get.toNamed(banner.targetScreen),
                      ))
                  .toList(),
            ),
            const SizedBox(
              height: ESizes.spaceBtnItems,
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < controller.banners.length; i++)
                    ERoundedContainer(
                      width: 20,
                      height: 4,
                      margin: const EdgeInsets.only(right: 10),
                      backgroundColor:
                          controller.carouselCurrentIndex.value == i
                              ? EColors.primaryColor
                              : EColors.grey,
                    ),
                ],
              ),
            )
          ],
        );
      }
    });
  }
}
