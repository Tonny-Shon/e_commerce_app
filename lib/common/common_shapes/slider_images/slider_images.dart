import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../utils/constants/sizes.dart';

class ERoundedImage extends StatelessWidget {
  const ERoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.contain,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = ESizes.md,
    this.placeholder,          // ← optional custom placeholder widget
    this.errorWidget,          // ← optional custom error widget
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  // New optional params for better UX
  final Widget? placeholder;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    if (!isNetworkImage) {
      // Keep asset image handling unchanged
      return GestureDetector(
        onTap: onPressed,
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            border: border,
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: ClipRRect(
            borderRadius: applyImageRadius
                ? BorderRadius.circular(borderRadius)
                : BorderRadius.zero,
            child: Image(
              image: AssetImage(imageUrl),
              fit: fit,
            ),
          ),
        ),
      );
    }

    // Network image → use CachedNetworkImage
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: fit,
            placeholder: (context, url) =>
                placeholder ??
                const Center(
                  child: CircularProgressIndicator(),
                ),
            errorWidget: (context, url, error) =>
                errorWidget ??
                const Icon(
                  Icons.broken_image_rounded,
                  color: Colors.grey,
                  size: 50,
                ),
            // Helpful options
            fadeInDuration: const Duration(milliseconds: 200),
            memCacheHeight: height?.toInt(), // reduce memory usage
            maxHeightDiskCache: 800,         // don't store huge originals
          ),
        ),
      ),
    );
  }
}