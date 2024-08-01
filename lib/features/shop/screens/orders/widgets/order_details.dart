import 'package:e_commerce_app/common/common_shapes/containers/circular_container.dart';
import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/features/shop/models/order_model.dart';
import 'package:e_commerce_app/features/shop/screens/cart/cart_item.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.order});
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: EAppBar(
        showBackArrow: true,
        title: Text(
          'Order Details',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Order Id: ${order.id}'),
              const SizedBox(
                height: ESizes.spaceBtnItems,
              ),
              //item in cart
              Column(
                children: order.items
                    .map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: ECartItem(cartItem: item)))
                    .toList(),
              ),

              const SizedBox(
                height: ESizes.spaceBtnItems,
              ),

              //Billing section
              ERoundedContainer(
                padding: const EdgeInsets.all(ESizes.md),
                showBorder: true,
                backgroundColor: dark ? EColors.black : EColors.white,
                child: Column(
                  children: [
                    Column(
                      children: [
                        const ESectionHeading(
                          title: 'More Details',
                          showActionButton: false,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total'),
                            Text(order.totalAmout.toString())
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Payment Method'),
                            Text(order.paymentMethod),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: ESizes.spaceBtnItems,
                    ),

                    //Divider
                    const Divider(),
                    const SizedBox(
                      height: ESizes.spaceBtnItems,
                    ),

                    //Addresses
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Order Date'),
                        Text(order.formattedOrderDate),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Order Status'),
                        Text(order.status.toString()),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              ERoundedContainer(
                padding: const EdgeInsets.all(ESizes.md),
                showBorder: true,
                backgroundColor: dark ? EColors.black : EColors.white,
                child: Column(
                  children: [
                    Column(
                      children: [
                        const ESectionHeading(
                          title: 'Address',
                          showActionButton: false,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Location'),
                            Text(order.address!.name)
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Shipping Amount'),
                            Text(order.address!.shippingAmount.toString()),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
