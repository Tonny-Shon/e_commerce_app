import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class DialogService {
  static Future<void> showAlreadyInCartDialog({
    required String productName,
    required VoidCallback onViewCart,
  }) async {
    await Get.dialog(AlertDialog(
      backgroundColor: EColors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ESizes.cardRadiusLg)),
      title: Row(
        children: [
          const Icon(
            Iconsax.shopping_bag,
            color: EColors.primaryColor,
          ),
          const SizedBox(
            width: ESizes.spaceBtnItems,
          ),
          Text(
            'Already in Cart',
            style: Theme.of(Get.context!).textTheme.headlineSmall,
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productName,
            style: Theme.of(Get.context!)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w600, color: EColors.dark),
          ),
          const SizedBox(
            height: ESizes.spaceBtnItems / 2,
          ),
          Text(
            'This item is already in your shopping cart.',
            style: Theme.of(Get.context!)
                .textTheme
                .bodyMedium
                ?.copyWith(color: EColors.darkGrey),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            'Continue shopping',
            style: Theme.of(Get.context!)
                .textTheme
                .bodyMedium
                ?.copyWith(color: EColors.darkGrey),
          ),
        ),
        ElevatedButton(onPressed: (){
          Get.back();
          onViewCart();
        },style: ElevatedButton.styleFrom(
          backgroundColor: EColors.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ESizes.borderRadiusMd))
        ), child: const Text('Cart ->'),),
      ],
    ), barrierDismissible: true);
  }

  static Future<bool> showRemoveConfirmationDialog({
    required String productName,
  }) async{
    bool? result = await Get.dialog<bool>(
      AlertDialog(backgroundColor: EColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(ESizes.cardRadiusLg),
      ),title: Row(
        children: [
          const Icon(Iconsax.trash, color: EColors.error,),
          const SizedBox(width: ESizes.spaceBtnItems,),
          Text('Remove Item',
          style: Theme.of(Get.context!).textTheme.headlineSmall?.copyWith(color: EColors.error),)
        ],
      ),
      content: Text(
        'Remove "$productName" from your cart?',
        style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(color: EColors.darkGrey),
      ),actions: [
        TextButton(onPressed: () => Get.back(result: false),
         child: const Text('Cancel'),),
         ElevatedButton(onPressed: () => Get.back(result: true),style: ElevatedButton.styleFrom(
          backgroundColor: EColors.error
         ),
          child: const Text('Remove'))
      ],)
    );
    return result ?? false;
  }
}
