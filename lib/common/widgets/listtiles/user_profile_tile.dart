import 'package:e_commerce_app/features/authentication/controller/user_controller.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../cicular_image/circular_image.dart';

class EUserProfileTile extends StatelessWidget {
  const EUserProfileTile({
    super.key,
    required this.onPressed,
  });
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final dark = EHelperFunctions.isDarkMode(context);
    return ListTile(
      leading: ECircularImage(
        image: controller.user.value.profilePicture ,
        isNetworkImage: true,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: Text(
        controller.user.value.fullname,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: dark ? EColors.white : EColors.black),
      ),
      subtitle: Text(
        controller.user.value.email,
        style:
        Theme.of(context).textTheme.bodyMedium!.apply(color: dark ? EColors.white : EColors.black),
      ),
      trailing: IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Icons.edit,
          color: EColors.white,
        ),
      ),
    );
  }
}
