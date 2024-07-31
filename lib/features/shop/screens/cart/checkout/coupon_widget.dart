import 'package:e_commerce_app/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce_app/features/personalization/models/address_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ELocationSelection extends StatelessWidget {
  const ELocationSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Obx(() {
      if (controller.address.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return DropdownButtonFormField<AddressModel>(
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.location),
            ),
            value: controller.selectedAddress.value,
            items: controller.address
                .map(
                  (option) => DropdownMenuItem<AddressModel>(
                    value: option,
                    child: Text(option.name),
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
