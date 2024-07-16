import 'package:e_commerce_app/utils/effects/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/products_cart/cart_menu_icon.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/texts.dart';
import '../../../../authentication/controller/user_controller.dart';

class EHomeAppBar extends StatelessWidget {
  const EHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return EAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ETexts.homeAppbarTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: EColors.grey),
          ),
          Obx(() {
            if (controller.profileLoading.value) {
              return const EShimmerEffect(width: 80, height: 15);
            } else {
              return Text(
                controller.user.value.fullname,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: EColors.white),
              );
            }
          }),
        ],
      ),
      actions: const [
        ECartControlIcon(
          iconColor: EColors.white,
        )
      ],
    );
  }
}
