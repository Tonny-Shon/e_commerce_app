import 'package:flutter/material.dart';

import '../../../../common/common_shapes/slider_images/slider_images.dart';
import '../../../../common/product_size_text.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../models/cart_item_model.dart';
import '../store/widgets/brand_title_icon.dart';

class ECartItem extends StatelessWidget {
  const ECartItem({
    super.key,
    required this.cartItem,
    this.quantity,
  });
  final CartItemModel cartItem;
  final String? quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //image
        ERoundedImage(
          imageUrl: cartItem.image ?? '',
          width: 60,
          height: 60,
          isNetworkImage: true,
          padding: const EdgeInsets.all(ESizes.sm),
          backgroundColor: EHelperFunctions.isDarkMode(context)
              ? EColors.darkerGrey
              : EColors.light,
        ),

        const SizedBox(
          width: ESizes.spaceBtnItems,
        ),

        //Title, Price and Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EBrandTitleVerifiedIcon(title: cartItem.brandName ?? ''),
              Flexible(
                child: EProductTitleText(
                  title: cartItem.title,
                  maxlines: 1,
                ),
              ),
              Flexible(
                  child: Row(
                children: [
                  const Text('Qty: '),
                  const SizedBox(
                    width: 5,
                  ),
                  Text('${cartItem.quantity}')
                ],
              ))
            ],
          ),
        ),
      ],
    );
  }
}
