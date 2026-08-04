import 'package:flutter/material.dart';
import '../../../../common/common_shapes/slider_images/slider_images.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../models/category_model.dart';

class CategoryGridTile extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const CategoryGridTile({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Category image
          Expanded(
            child: ERoundedImage(
              width: 50,
              height: 40,
              isNetworkImage: true,
              imageUrl: category.image,
              fit: BoxFit.contain,
              borderRadius: 12,
            ),
          ),
          const SizedBox(height: 8),
          // Category name below image
          Text(
            category.name,
            
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.w500, color: dark ? EColors.white : EColors.black ),
          ),
        ],
      ),
    );
  }
}