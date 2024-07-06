import 'package:e_commerce_app/features/shop/screens/store/widgets/brand_title_icon.dart';
import 'package:flutter/material.dart';

import '../../../../../common/common_shapes/containers/circular_container.dart';
import '../../../../../common/widgets/cicular_image/circular_image.dart';
import '../../../../../images/images.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/sizes.dart';

class EBrandCard extends StatelessWidget {
  const EBrandCard({
    super.key,
    required this.showBorder,
    this.title = 'Beds',
    this.subTitle = '40 products',
    this.onTap,
  });
  final bool showBorder;
  final String? title, subTitle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ERoundedContainer(
        showBorder: showBorder,
        padding: const EdgeInsets.all(ESizes.sm),
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            //Icon
            const Flexible(
              child: ECircularImage(
                image: EImages.icBeddings,
                isNetworkImage: false,
                backgroundColor: Colors.transparent,
                // overlayColor: EHelperFunctions.isDarkMode(context)
                //     ? EColors.black
                //     : EColors.white,
              ),
            ),
            const SizedBox(
              width: ESizes.spaceBtnItems / 2,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const EBrandTitleVerifiedIcon(
                  title: 'Beds',
                  brandTextSize: TextSizes.large,
                ),
                Text(
                  '40 products',
                  style: Theme.of(context).textTheme.labelMedium,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
