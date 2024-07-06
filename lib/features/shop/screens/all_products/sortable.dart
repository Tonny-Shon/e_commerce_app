import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/common_shapes/layouts/grid_layout.dart';
import '../../../../common/products_cart/product_card_vertical.dart';
import '../../../../utils/constants/sizes.dart';

class ESortableProducts extends StatelessWidget {
  const ESortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //drop down
        DropdownButtonFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.sort),
            ),
            items: [
              'Name',
              'Higher Price',
              'Lower Price',
              'Sale',
              'Newest',
              'Popularity'
            ]
                .map(
                  (option) => DropdownMenuItem(
                    value: option,
                    child: Text(option),
                  ),
                )
                .toList(),
            onChanged: (value) {}),
        const SizedBox(
          height: ESizes.spaceBtnSections,
        ),

        //Products
        EGridLayout(
            itemCount: 8,
            itemBuilder: (_, index) => const EProductCardVertical()),
      ],
    );
  }
}
