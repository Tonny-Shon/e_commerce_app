import 'package:e_commerce_app/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce_app/features/personalization/models/address_model.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../utils/constants/colors.dart';

class ELocationSelection extends StatelessWidget {
  const ELocationSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    final dark = EHelperFunctions.isDarkMode(context);
    return Obx(() {
      if (controller.address.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return DropdownButtonFormField<AddressModel>(
            decoration:  const InputDecoration(
              prefixIcon: Icon(Iconsax.location),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: EColors.primaryColor),
              ),
            ),
            initialValue: controller.selectedAddress.value,
            
            items: controller.address
                .map(
                  (option) => DropdownMenuItem<AddressModel>(
                value: option,
                child: Text(option.name, style: TextStyle(color: dark ? EColors.white : EColors.black)),
              ),
            )
                .toList(),
            onChanged: (value) {
              controller.selectedAddress(value!);
            });
      }
    });
  }
}
