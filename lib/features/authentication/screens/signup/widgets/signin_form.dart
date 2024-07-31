import 'package:e_commerce_app/features/authentication/controller/signup/signup_controller.dart';
import 'package:e_commerce_app/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';

class ESignInForm extends StatelessWidget {
  const ESignInForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormkey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller: controller.firstname,
                  validator: (value) =>
                      EValidator.validateEmptyText('First Name', value),
                  expands: false,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user),
                      labelText: ETexts.firstName),
                ),
              ),
              const SizedBox(
                width: ESizes.spaceBtnItems,
              ),
              Expanded(
                child: TextFormField(
                  style: const TextStyle(color: Colors.black),
                  validator: (value) =>
                      EValidator.validateEmptyText('Last Name', value),
                  controller: controller.lastname,
                  expands: false,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user),
                      labelText: ETexts.lastName),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: ESizes.spaceBtnInputFields,
          ),
          TextFormField(
            style: const TextStyle(color: Colors.black),
            validator: (value) =>
                EValidator.validateEmptyText('User Name', value),
            controller: controller.username,
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.user), labelText: ETexts.username),
          ),
          const SizedBox(
            height: ESizes.spaceBtnInputFields,
          ),
          TextFormField(
            style: const TextStyle(color: Colors.black),
            validator: (value) => EValidator.validateEmail(value),
            controller: controller.email,
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: ETexts.email),
          ),
          const SizedBox(
            height: ESizes.spaceBtnInputFields,
          ),
          TextFormField(
            style: const TextStyle(color: Colors.black),
            validator: (value) => EValidator.validatePhoneNumber(value),
            controller: controller.phoneNumber,
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.call), labelText: ETexts.phoneNumber),
          ),
          const SizedBox(
            height: ESizes.spaceBtnInputFields,
          ),
          Obx(
            () => TextFormField(
              style: const TextStyle(color: Colors.black),
              validator: (value) => EValidator.validatePassword(value),
              controller: controller.password,
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye),
                  ),
                  labelText: ETexts.password),
            ),
          ),
          const SizedBox(
            height: ESizes.spaceBtnInputFields / 2,
          ),
          const SizedBox(
            height: ESizes.spaceBtnItems,
          ),
        ],
      ),
    );
  }
}
