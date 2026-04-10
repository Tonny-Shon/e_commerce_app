import 'package:e_commerce_app/features/authentication/controller/login/login_controller.dart';
import 'package:e_commerce_app/features/authentication/screens/password_configuration/forgot_password.dart';
import 'package:e_commerce_app/features/authentication/screens/signup/sign_up.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:e_commerce_app/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';

class ELoginForm extends StatelessWidget {
  const ELoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final dark = EHelperFunctions.isDarkMode(context);
    return Form(
      key: controller.loginformkey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: ESizes.spaceBtnSections,
        ),
        child: Column(
          children: [
            TextFormField(
              style:  TextStyle(color: dark ? EColors.white : EColors.black),
              controller: controller.email,
              validator: (value) => EValidator.validateEmail(value),
              decoration:  InputDecoration(
                
                prefixIcon: const Icon(Iconsax.direct_right),
                labelText: ETexts.email,
                labelStyle: TextStyle(color: dark ? EColors.white : EColors.black),
                focusColor: dark ? EColors.white : EColors.black,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: dark ? EColors.white : EColors.black),
                  borderRadius: BorderRadius.circular(ESizes.inputFieldRadius),
                ),
                floatingLabelStyle: TextStyle(color: dark ? EColors.white : EColors.black),
              ),
            ),
            const SizedBox(
              height: ESizes.spaceBtnInputFields,
            ),
            Obx(
              () => TextFormField(
                style:  TextStyle(color: dark ? EColors.black : EColors.black),
                validator: (value) =>
                    EValidator.validateEmptyText('Password', value),
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
                    floatingLabelStyle: TextStyle(color: dark ? EColors.white : EColors.black),
                    focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: EColors.primaryColor),
                  borderRadius: BorderRadius.circular(ESizes.inputFieldRadius),
                ),
                    
                    labelText: ETexts.password, labelStyle: TextStyle(color: dark ? EColors.white : EColors.black)),
              ),
            ),
            const SizedBox(
              height: ESizes.spaceBtnInputFields / 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                          activeColor: EColors.primaryColor,
                          value: controller.rememberMe.value,
                          onChanged: (value) => controller.rememberMe.value =
                              !controller.rememberMe.value),
                    ),
                     Text(ETexts.rememberMe, style: TextStyle(color: dark ? EColors.white : EColors.black),),
                  ],
                ),

                //forgot password button
                TextButton(
                    onPressed: () => Get.to(() => const ForgotPassword()),
                    child: const Text(
                      ETexts.forgotPassword,
                    ))
              ],
            ),

            const SizedBox(
              height: ESizes.spaceBtnItems,
            ),
            //Sign In button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: EColors.primaryColor,
                    side: const BorderSide(color: Colors.transparent)),
                onPressed: () => controller.loginuser(),
                child: const Text(ETexts.signIn),
              ),
            ),

            //Create account button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: EColors.primaryColor)),
                onPressed: () {
                  Get.offAll(() => const SignUpScreen());
                },
                child: Text(ETexts.createAccount, style: TextStyle(color: dark ? EColors.white : EColors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
