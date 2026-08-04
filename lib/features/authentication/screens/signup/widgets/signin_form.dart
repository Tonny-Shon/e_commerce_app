import 'package:e_commerce_app/features/authentication/controller/signup/signup_controller.dart';
import 'package:e_commerce_app/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class ESignInForm extends StatelessWidget {
  const ESignInForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final dark = EHelperFunctions.isDarkMode(context);
    return Form(
      key: controller.signupFormkey,
      child: Column(
        children: [
       
          TextFormField(
            style: const TextStyle(color: Colors.black),
            validator: (value) =>
                EValidator.validateEmptyText('User Name', value),
            controller: controller.username,
            decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.user), labelText: ETexts.username,
                labelStyle: TextStyle(color: dark ? EColors.white : EColors.black),
                      floatingLabelStyle: TextStyle(color: dark ? EColors.white : EColors.black), 
                      focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: EColors.primaryColor),
                  borderRadius: BorderRadius.circular(ESizes.inputFieldRadius),
                ),
                ),
          ),
          const SizedBox(
            height: ESizes.spaceBtnInputFields,
          ),
          TextFormField(
            style: const TextStyle(color: Colors.black),
            validator: (value) => EValidator.validateEmail(value),
            controller: controller.email,
            decoration:  InputDecoration(
                prefixIcon: const Icon(Iconsax.direct_right),
                labelText: ETexts.email,
                labelStyle: TextStyle(color: dark ? EColors.white : EColors.black),
                      floatingLabelStyle: TextStyle(color: dark ? EColors.white : EColors.black), 
                      focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: EColors.primaryColor),
                  borderRadius: BorderRadius.circular(ESizes.inputFieldRadius),
                ),
                ),
          ),
          const SizedBox(
            height: ESizes.spaceBtnInputFields,
          ),
          TextFormField(
            style: const TextStyle(color: Colors.black),
            validator: (value) => EValidator.validatePhoneNumber(value),
            controller: controller.phoneNumber,
            decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.call), labelText: ETexts.phoneNumber,
                labelStyle: TextStyle(color: dark ? EColors.white : EColors.black),
                      floatingLabelStyle: TextStyle(color: dark ? EColors.white : EColors.black), 
                      focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: EColors.primaryColor),
                  borderRadius: BorderRadius.circular(ESizes.inputFieldRadius),
                ),
                ),
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
                  labelText: ETexts.password,
                  labelStyle: TextStyle(color: dark ? EColors.white : EColors.black),
                      floatingLabelStyle: TextStyle(color: dark ? EColors.white : EColors.black), 
                    focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: EColors.primaryColor),
                  borderRadius: BorderRadius.circular(ESizes.inputFieldRadius),
                ),  
                  ),
                  
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
