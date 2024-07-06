import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/common_shapes/containers/primary_curved_widget.dart';
import '../../../../../common/common_shapes/slider_images/slider_images.dart';
import '../../../../../common/icons/icon_widget.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../images/images.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class EProductImageSlider extends StatelessWidget {
  const EProductImageSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return EPrimaryCurvedWidget(
        child: Container(
      color: dark ? EColors.darkerGrey : EColors.light,
      child: Stack(
        children: [
          //Main Image
          const SizedBox(
            height: 400,
            child: Padding(
              padding: EdgeInsets.all(ESizes.productImageRadius * 2),
              child: Center(
                child: Image(
                  image: AssetImage(EImages.icBeddings),
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
                itemCount: 4,
                separatorBuilder: (_, imdex) => const SizedBox(
                  width: ESizes.spaceBtnItems,
                ),
                itemBuilder: (_, index) => ERoundedImage(
                    width: 80,
                    backgroundColor: dark ? EColors.dark : EColors.white,
                    border: Border.all(color: EColors.primaryColor),
                    padding: const EdgeInsets.all(ESizes.sm),
                    imageUrl: EImages.icElectronics),
              ),
            ),
          ),

          //App bar
          const EAppBar(
            showBackArrow: true,
            actions: [
              ECircularIcon(
                icon: Iconsax.heart5,
                color: Colors.red,
              )
            ],
          )
        ],
      ),
    ));
  }
}
