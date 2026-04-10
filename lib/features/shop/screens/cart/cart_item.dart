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
    this.showQuantity = false,
  });
  final CartItemModel cartItem;
  final String? quantity;
  final bool? showQuantity;

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Row(
                    children: [
                      if (showQuantity!)
                        Text('Qty: ', style: Theme.of(context).textTheme.labelLarge!.apply(color: EHelperFunctions.isDarkMode(context) ? EColors.white : EColors.black)),
                    //  Text('Qty: ', style: Theme.of(context).textTheme.labelLarge!.apply(color: EHelperFunctions.isDarkMode(context) ? EColors.white : EColors.black)),
                      const SizedBox(
                        width: 5,
                      ),
                      if(showQuantity!)
                        Text('${cartItem.quantity}', style: Theme.of(context).textTheme.labelLarge!.apply(color: EHelperFunctions.isDarkMode(context) ? EColors.white : EColors.black)),
                      // Text('${cartItem.quantity}', style: Theme.of(context).textTheme.labelLarge!.apply(color: EHelperFunctions.isDarkMode(context) ? EColors.white : EColors.black))
                    ],
                  )),
                  Text('${cartItem.price * cartItem.quantity}')
                ],
              ),
              // const SizedBox(
              //   height: ESizes.spaceBtnItems / 2,
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
