import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/common/consts/styles.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class EVerticalImage extends StatelessWidget {
  const EVerticalImage({
    super.key,
    required this.image,
    required this.title,
    this.textColor = EColors.white,
    this.backgroundColor = EColors.white,
    this.onTap,
    this.fit = BoxFit.cover
  });
  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: ESizes.spaceBtnItems),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(ESizes.sm),
              decoration: BoxDecoration(
                color:
                    backgroundColor ?? (dark ? EColors.black : EColors.white),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: ClipRRect(
          borderRadius:
            BorderRadius.circular(15),
              
          child: CachedNetworkImage(
            imageUrl: image,
            fit: fit,
            placeholder: (context, url) =>
               
                const Center(
                  child: CircularProgressIndicator(),
                ),
            errorWidget: (context, url, error) =>
                
                const Icon(
                  Icons.broken_image_rounded,
                  color: Colors.grey,
                  size: 50,
                ),
            // Helpful options
            fadeInDuration: const Duration(milliseconds: 200),
            // memCacheHeight: height?.toInt(), // reduce memory usage
            maxHeightDiskCache: 800,         // don't store huge originals
          ),
        ),
              ),
            ),
            //text for the categories
            const SizedBox(
              width: ESizes.spaceBtnItems / 2,
            ),
            SizedBox(
              width: 55,
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: textColor, fontFamily: bold, fontSizeFactor: 1.2),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
