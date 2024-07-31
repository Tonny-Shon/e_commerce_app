import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/effects/shimmer.dart';
import '../../../utils/helpers/helper_functions.dart';

class EVerticalImage extends StatelessWidget {
  const EVerticalImage({
    super.key,
    required this.image,
    this.isNetworkImage = true,
    this.fit = BoxFit.cover,
    this.overlayColor,
    required this.title,
    this.textColor = EColors.white,
    this.backgroundColor = EColors.white,
    this.onTap,
  });
  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;
  final bool isNetworkImage;
  final Color? overlayColor;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: ESizes.spaceBtnItems),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 56,
              height: 56,
              padding: const EdgeInsets.all(ESizes.sm),
              decoration: BoxDecoration(
                color:
                    backgroundColor ?? (dark ? EColors.black : EColors.white),
                borderRadius: BorderRadius.circular(100),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Center(
                  child: isNetworkImage
                      ? CachedNetworkImage(
                          fit: fit,
                          color: overlayColor,
                          imageUrl: image,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  const EShimmerEffect(width: 55, height: 55),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        )
                      : Image(
                          image: AssetImage(image),
                          //color: EColors.white,
                          fit: fit,
                          color: overlayColor,
                        ),
                ),
              ),
            ),
            //text for the categories
            const SizedBox(
              height: ESizes.spaceBtnItems / 2,
            ),
            SizedBox(
              width: 60,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .apply(color: textColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
