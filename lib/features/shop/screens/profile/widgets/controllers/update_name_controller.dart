import 'package:e_commerce_app/data/repositories/user/user_repository.dart';
import 'package:e_commerce_app/features/authentication/controller/network_manager/network_manager.dart';
import 'package:e_commerce_app/features/authentication/controller/user_controller.dart';
import 'package:e_commerce_app/features/shop/screens/profile/widgets/user_profile.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUsernameFormkey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    initializeNames();
  }

  //fetch user record
  Future<void> initializeNames() async {
    firstname.text = userController.user.value.firstname;
    lastname.text = userController.user.value.lastname;
  }

  Future<void> updateUsername() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) return;

      //form validation
      if (!updateUsernameFormkey.currentState!.validate()) return;

      //update the firstname and lastname in the firestore
      Map<String, dynamic> name = {
        'FirstName': firstname.text.trim(),
        'LastName': lastname.text.trim()
      };
      await userRepository.updateSingleField(name);

      //update the Rx user value
      userController.user.value.firstname = firstname.text.trim();
      userController.user.value.lastname = lastname.text.trim();

      ELoaders.successSnackBar(
          title: 'Congratulations', message: 'Update succesful');

      //Move to the previous page
      Get.off(() => const UserProfileScreen());
    } catch (e) {
      ELoaders.erroSnackBar(title: 'Opps', message: e.toString());
    }
  }
}
