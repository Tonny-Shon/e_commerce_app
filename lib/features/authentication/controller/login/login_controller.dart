import 'package:e_commerce_app/features/authentication/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/popups/loaders.dart';
import '../network_manager/network_manager.dart';

class LoginController extends GetxController {
  //variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginformkey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    email.text = localStorage.read("REMEMBER_ME_EMAIL") ?? '';
    password.text = localStorage.read("REMEMBER_ME_PASSWORD") ?? '';
    super.onInit();
  }

  //email and password signin
  Future<void> loginuser() async {
    try {
      // EFullScreenLoader.openLoadingDialog(
      //     "We are processing your informaation", EImages.flutterwave);

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      //form validation
      if (!loginformkey.currentState!.validate()) return;

      //Privacy policy check
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      //Register user in the firebase authentication and save user data in the firebase
      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      ELoaders.erroSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  Future<void> googleSignin() async {
    try {
      //helper function to display the progress of the signin

      //check the internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      //Google authentication
      final userCredentials =
          await AuthenticationRepository.instance.signinWithGoogle();

      //save user record
      userController.saveUserRecord(userCredentials);
    } catch (e) {
      ELoaders.erroSnackBar(
          title: 'Google Signin error',
          message: 'Something went wrong during the signin');
    }
  }
}
