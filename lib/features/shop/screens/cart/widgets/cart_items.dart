import 'package:flutter/material.dart';

import '../../../../../common/common_shapes/containers/product_text/product_text_price.dart';
import '../../../../../utils/constants/sizes.dart';
import '../add_remove_button.dart';
import '../cart_item.dart';

class ECartItems extends StatelessWidget {
  const ECartItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (_, __) => const SizedBox(
              height: ESizes.spaceBtnSections,
            ),
        itemBuilder: (_, index) => Column(
              children: [
                //cart items
                const ECartItem(),
                if (showAddRemoveButtons)
                  const SizedBox(
                    height: ESizes.spaceBtnItems,
                  ),

                // Add Remove Button Row with total price
                if (showAddRemoveButtons)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 70,
                          ),
                          EProductWithAddAndRemoveButton(),
                        ],
                      ),
                      //Add, Remove buttons

                      EProductPriceText(price: '370k')
                    ],
                  )
              ],
            ),
        itemCount: 3);
  }
}
