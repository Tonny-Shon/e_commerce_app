import 'package:e_commerce_app/features/authentication/controller/login/login_controller.dart';
import 'package:e_commerce_app/features/authentication/screens/password_configuration/forgot_password.dart';
import 'package:e_commerce_app/features/authentication/screens/signup/sign_up.dart';
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
    return Form(
      key: controller.loginformkey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: ESizes.spaceBtnSections,
        ),
        child: Column(
          children: [
            TextFormField(
              controller: controller.email,
              validator: (value) => EValidator.validateEmail(value),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: ETexts.email),
            ),
            const SizedBox(
              height: ESizes.spaceBtnInputFields,
            ),
            Obx(
              () => TextFormField(
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
                    labelText: ETexts.password),
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
                          value: controller.rememberMe.value,
                          onChanged: (value) => controller.rememberMe.value =
                              !controller.rememberMe.value),
                    ),
                    const Text(ETexts.rememberMe),
                  ],
                ),

                //forgot password button
                TextButton(
                    onPressed: () => Get.to(() => const ForgotPassword()),
                    child: const Text(ETexts.forgotPassword))
              ],
            ),

            const SizedBox(
              height: ESizes.spaceBtnItems,
            ),
            //Sign In button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.loginuser(),
                child: const Text(ETexts.signIn),
              ),
            ),

            //Create account button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Get.offAll(() => const SignUpScreen());
                },
                child: const Text(ETexts.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
