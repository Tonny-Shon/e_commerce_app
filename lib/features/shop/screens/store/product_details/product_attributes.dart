import 'package:e_commerce_app/common/common_shapes/containers/circular_container.dart';
import 'package:e_commerce_app/common/common_shapes/containers/product_text/product_text_price.dart';
import 'package:e_commerce_app/common/product_size_text.dart';
import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/features/shop/screens/store/product_details/choice_chip/choice_chip.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        //selected attribute, pricing and description
        ERoundedContainer(
          padding: const EdgeInsets.all(ESizes.md),
          backgroundColor: dark ? EColors.darkerGrey : EColors.grey,
          child: Column(
            children: [
              //title, price and stock
              Row(
                children: [
                  const ESectionHeading(
                    title: 'Variation',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    width: ESizes.spaceBtnItems,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const EProductTitleText(
                            title: 'Price : ',
                            smallSize: true,
                          ),
                          //Actual Price
                          Text(
                            'Ugx 400k',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(
                            width: ESizes.spaceBtnItems,
                          ),
                          //Sale price
                          const EProductPriceText(price: '370k')
                        ],
                      ),
                      Row(
                        children: [
                          const EProductTitleText(
                            title: 'Stock : ',
                            smallSize: true,
                          ),
                          Text(
                            'In Stock',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              //variation description
              const EProductTitleText(
                title:
                    'This is the description of the Product and it can go up to max of 4 lines',
                smallSize: true,
                maxlines: 4,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: ESizes.spaceBtnItems,
        ),

        //attributes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ESectionHeading(
              title: 'Colors',
              showActionButton: false,
            ),
            const SizedBox(
              height: ESizes.spaceBtnItems / 2,
            ),
            Wrap(
              children: [
                EChoiceChip(
                  text: 'Green',
                  selected: false,
                  onSelected: (value) {},
                ),
                EChoiceChip(
                  text: 'Blue',
                  selected: false,
                  onSelected: (value) {},
                ),
                EChoiceChip(
                  text: 'Yellow',
                  selected: true,
                  onSelected: (value) {},
                ),
              ],
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ESectionHeading(
              title: 'Sizes',
              showActionButton: false,
            ),
            const SizedBox(
              height: ESizes.spaceBtnItems / 2,
            ),
            Wrap(
              spacing: 4,
              children: [
                EChoiceChip(
                  text: '5 Inch',
                  selected: false,
                  onSelected: (value) {},
                ),
                EChoiceChip(
                  text: '6 Inch',
                  selected: false,
                  onSelected: (value) {},
                ),
                EChoiceChip(
                  text: '4 Inch',
                  selected: false,
                  onSelected: (value) {},
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
