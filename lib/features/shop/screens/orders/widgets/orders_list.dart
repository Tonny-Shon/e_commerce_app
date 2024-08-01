import 'package:e_commerce_app/common/common_shapes/containers/circular_container.dart';
import 'package:e_commerce_app/features/shop/screens/cart/checkout/controllers/order_controller.dart';
import 'package:e_commerce_app/features/shop/screens/orders/widgets/order_details.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/cloud_helper_functions.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EOrderListItems extends StatelessWidget {
  const EOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    final dark = EHelperFunctions.isDarkMode(context);
    return FutureBuilder(
        future: controller.fetchUserOrders(),
        builder: (context, snapshot) {
          const emptyWidget = Center(
            child: Text('No Orders yet'),
          );
          final response = ECloudHelperFunctions.checkMultiRecordState(
              snapshot: snapshot, nothingFound: emptyWidget);
          if (response != null) return response;

          final orders = snapshot.data!;
          return ListView.separated(
              shrinkWrap: true,
              itemCount: orders.length,
              separatorBuilder: (_, __) => const SizedBox(
                    height: ESizes.spaceBtnItems,
                  ),
              itemBuilder: (_, index) {
                final order = orders[index];
                return ERoundedContainer(
                  padding: const EdgeInsets.all(ESizes.md),
                  showBorder: true,
                  backgroundColor: dark ? EColors.dark : EColors.light,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //Row 1
                      Row(
                        children: [
                          const Icon(Iconsax.ship),
                          const SizedBox(
                            width: ESizes.spaceBtnItems / 2,
                          ),

                          //status and Date
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.orderStatusText,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .apply(
                                          color: EColors.primaryColor,
                                          fontWeightDelta: 3),
                                ),
                                Text(
                                  order.formattedOrderDate,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () => Get.to(() => OrderDetailsScreen(
                                    order: order,
                                  )),
                              icon: const Icon(Iconsax.arrow_right_34,
                                  size: ESizes.iconSm))
                        ],
                      ),
                      const SizedBox(
                        height: ESizes.spaceBtnItems,
                      ),

                      //Row 2
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(Iconsax.tag),
                                const SizedBox(
                                  width: ESizes.spaceBtnItems / 2,
                                ),

                                //status and Date
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Order',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                      Text(
                                        order.id,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(Iconsax.calendar),
                                const SizedBox(
                                  width: ESizes.spaceBtnItems / 2,
                                ),

                                //status and Date
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Shipping Date',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                      Text(
                                        order.formattedDeliveryDate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
