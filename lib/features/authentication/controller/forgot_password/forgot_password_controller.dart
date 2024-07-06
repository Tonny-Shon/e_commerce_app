import 'package:e_commerce_app/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce_app/features/authentication/controller/network_manager/network_manager.dart';
import 'package:e_commerce_app/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get instance => Get.find();

  //variables
  final email = TextEditingController();
  GlobalKey<FormState> forgotPasswordFormkey = GlobalKey<FormState>();

  //send the reset password email
  sendPasswordResetEmail() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      //form validation
      if (!forgotPasswordFormkey.currentState!.validate()) return;

      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      //success screen
      ELoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Email link sent to reset your password.'.tr);

      //redirect
      Get.to(() => ResetPassword(
            email: email.text.trim(),
          ));
    } catch (e) {
      ELoaders.erroSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      //success screen
      ELoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Email link sent to reset your password.'.tr);
    } catch (e) {
      ELoaders.erroSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
