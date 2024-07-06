import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/common_shapes/containers/circular_container.dart';
import '../../../../../common/common_shapes/slider_images/slider_images.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/home_controller/home_cotroller.dart';

class ECarouselSlider extends StatelessWidget {
  const ECarouselSlider({
    super.key,
    required this.banners,
  });
  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              viewportFraction: 1.3,
              onPageChanged: (index, _) =>
                  controller.updatePageIndicator(index)),
          items: banners.map((url) => ERoundedImage(imageUrl: url)).toList(),
        ),
        const SizedBox(
          height: ESizes.spaceBtnItems,
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < banners.length; i++)
                ERoundedContainer(
                  width: 20,
                  height: 4,
                  margin: const EdgeInsets.only(right: 10),
                  backgroundColor: controller.carouselCurrentIndex.value == i
                      ? EColors.primaryColor
                      : EColors.grey,
                ),
            ],
          ),
        )
      ],
    );
  }
}
