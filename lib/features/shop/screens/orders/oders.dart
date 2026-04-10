import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import 'widgets/orders_list.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: EAppBar(
        title: Text(
          'My Orders',
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .apply(color: dark ? EColors.white : EColors.black),
        ),
        showBackArrow: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(ESizes.defaultSpace),
        //orders
        child: EOrderListItems(),
      ),
    );
  }
}
