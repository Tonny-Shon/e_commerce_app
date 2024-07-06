import 'package:e_commerce_app/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce_app/data/repositories/user/user_repository.dart';
import 'package:e_commerce_app/features/authentication/controller/network_manager/network_manager.dart';
import 'package:e_commerce_app/features/authentication/screens/signup/verify_email.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/user_model/user_model.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  //variables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> signupFormkey = GlobalKey<FormState>();

  //Signup function
  Future<void> signupuser() async {
    try {
      // EFullScreenLoader.openLoadingDialog(
      //     "We are processing your informaation", EImages.flutterwave);

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      //form validation
      if (!signupFormkey.currentState!.validate()) return;

      //Privacy policy check
      if (!privacyPolicy.value) {
        ELoaders.warningSnackBar(
            title: "Accept Privacy Policy",
            message:
                "In order to create an account, you must have to read and accept the privacy policy and terms of use.");
        return;
      }

      //Register user in the firebase authentication and save user data in the firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      //Save Authenticationuser data in the Firebase Firestore
      final newUser = UserModel(
          id: userCredential.user!.uid,
          firstname: firstname.text.trim(),
          lastname: lastname.text.trim(),
          username: username.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: '');

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      //success message
      ELoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your account has been created! verify email to continue.');

      //move to verify email screen
      Get.to(() => VerifyEmailScreen(
            email: email.text.trim(),
          ));
    } catch (e) {
      ELoaders.erroSnackBar(title: "Oh Snap", message: e.toString());
    }
  }
}
