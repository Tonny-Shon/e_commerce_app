import 'package:e_commerce_app/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce_app/data/repositories/user/user_repository.dart';
import 'package:e_commerce_app/features/authentication/controller/network_manager/network_manager.dart';
import 'package:e_commerce_app/features/authentication/models/user_model/user_model.dart';
import 'package:e_commerce_app/features/authentication/screens/login/login.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../shop/screens/profile/widgets/re_authenticate_user_login_form.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());

  final imageLoading = false.obs;
  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormkey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // first update Rx user and then check if user is already stored. if not store new data
      await fetchUserRecord();

      //if no record stored
      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          //Convert name to first and last name
          final nameParts =
              UserModel.nameParts(userCredentials.user!.displayName ?? '');

          final username = UserModel.generateUsername(
              userCredentials.user!.displayName ?? '');

          //Map Data
          final user = UserModel(
              id: userCredentials.user!.uid,
              firstname: nameParts[0],
              lastname:
                  nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
              username: username,
              email: userCredentials.user!.email ?? '',
              phoneNumber: userCredentials.user!.phoneNumber ?? '',
              profilePicture: userCredentials.user!.photoURL ?? '');

          //save user data
          await UserRepository.instance.saveUserRecord(user);
        }
      }
    } catch (e) {
      ELoaders.warningSnackBar(
          title: 'Data not saved',
          message:
              'Something went wrong while saving your data, You can resave your data in your profile.');
    }
  }

  //delete account warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(ESizes.md),
        title: 'Delete Account',
        middleText:
            'Are you sure you want to delete your account?. This action is irreversible and all all data will be removed permanently.',
        confirm: ElevatedButton(
          onPressed: () async => deleteUserAccount(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            side: const BorderSide(color: Colors.red),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: ESizes.lg),
            child: Text('Delete'),
          ),
        ),
        cancel: OutlinedButton(
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: const Text('Cancel')));
  }

  void deleteUserAccount() async {
    try {
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        //reverify auth email
        if (provider == 'google.com') {
          await auth.signinWithGoogle();
          await auth.deleteAccount();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          Get.to(() => const ReAuthLogInForm());
        }
      }
    } catch (e) {
      ELoaders.warningSnackBar(title: "Opps", message: e.toString());
    }
  }

  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;
      if (!reAuthFormkey.currentState!.validate()) return;

      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
              verifyEmail.text.trim(), verifyPassword.text.trim());
      Get.offAll(() => const LoginScreen());
      await AuthenticationRepository.instance.deleteAccount();
    } catch (e) {
      ELoaders.warningSnackBar(title: 'Ooops', message: e.toString());
    }
  }

  uploadUserProfilePicture() async {
    try {
      imageLoading.value = true;
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);

      if (image != null) {
        final imageUrl =
            await userRepository.uploadImage('Users/Images/Profile', image);

        //update user image
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();

        ELoaders.successSnackBar(
            title: "Congs", message: 'Profile Picture has been updated!.');
      }
    } catch (e) {
      ELoaders.erroSnackBar(title: "Oops", message: 'Something went wrong.');
    } finally {
      imageLoading.value = false;
    }
  }
}
