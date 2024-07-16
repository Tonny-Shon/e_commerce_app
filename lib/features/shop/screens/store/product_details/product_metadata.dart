import 'package:e_commerce_app/common/common_shapes/containers/circular_container.dart';
import 'package:e_commerce_app/features/shop/controllers/product/product_controller.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../common/common_shapes/containers/product_text/product_text_price.dart';
import '../../../../../common/product_size_text.dart';
import '../../../../../common/widgets/cicular_image/circular_image.dart';
import '../../../../../utils/constants/enums.dart';
import '../widgets/brand_text.dart';

class EProductMetaData extends StatelessWidget {
  const EProductMetaData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    //final darkMode = EHelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePricePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            //size tag
            ERoundedContainer(
              radius: ESizes.sm,
              backgroundColor: EColors.secondaryColor.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: ESizes.sm, vertical: ESizes.xs),
              child: Text(
                '$salePricePercentage',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: EColors.black),
              ),
            ),
            const SizedBox(
              width: ESizes.spaceBtnItems,
            ),

            //price
            if (product.productType == ProductType.single.toString() &&
                product.salePrice > 0)
              Text(
                'Ugx ${product.price}',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(decoration: TextDecoration.lineThrough),
              ),
            const SizedBox(
              width: ESizes.spaceBtnItems,
            ),
            if (product.productType == ProductType.single.toString() &&
                product.salePrice > 0)
              const SizedBox(
                width: ESizes.spaceBtnItems,
              ),
            EProductPriceText(
              price: product.price.toString(),
              //controller.getProductPrice(product),
              isLarge: true,
            )
          ],
        ),
        const SizedBox(
          height: ESizes.spaceBtnItems / 1.5,
        ),
        //title
        EProductTitleText(
          title: product.title,
        ),
        const SizedBox(
          height: ESizes.spaceBtnItems / 1.5,
        ),

        // Stock status
        Row(
          children: [
            const EProductTitleText(title: 'Status'),
            const SizedBox(
              width: 8,
            ),
            Text(
              controller.getProductStockStatus(product.stock),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(
          height: ESizes.spaceBtnItems / 2,
        ),

        //Brand
        Row(
          children: [
            ECircularImage(
              image: product.brand != null ? product.brand!.image : '',
              isNetworkImage: true,
              width: 40,
              height: 40,
              //overlayColor: darkMode ? EColors.white : EColors.black,
            ),
            EBrandTitleText(
              title: product.brand != null ? product.brand!.name : '',
              brandTextSize: TextSizes.medium,
            ),
          ],
        ),
      ],
    );
  }
}
