import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/common_shapes/containers/product_text/product_text_price.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/product/cart_controller.dart';
import '../add_remove_button.dart';
import '../cart_item.dart';

class ECartItems extends StatelessWidget {
  const ECartItems({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return Obx(
      () => ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (_, __) => const SizedBox(
                height: ESizes.spaceBtnSections,
              ),
          itemBuilder: (_, index) => Obx(
                () {
                  final cartItem = cartController.cartItems[index];
                  return Column(
                    children: [
                      //cart items
                      ECartItem(
                        cartItem: cartItem,
                      ),
                      if (showAddRemoveButtons)
                        const SizedBox(
                          height: ESizes.spaceBtnItems,
                        ),

                      // Add Remove Button Row with total price
                      if (showAddRemoveButtons)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 70,
                                ),
                                EProductWithAddAndRemoveButton(
                                  quantity: cartItem.quantity,
                                  addButton: () =>
                                      cartController.addItemToCart(cartItem),
                                  removeButton: () => cartController
                                      .removeItemFromCart(cartItem),
                                ),
                              ],
                            ),
                            //Add, Remove buttons

                            //product total price
                            EProductPriceText(
                                price: (cartItem.price * cartItem.quantity)
                                    .toStringAsFixed(2)),
                          ],
                        ),
                      const Divider(),
                    ],
                  );
                },
              ),
          itemCount: cartController.cartItems.length),
    );
  }
}
