import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/cicular_image/circular_image.dart';
import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/features/authentication/controller/user_controller.dart';
import 'package:e_commerce_app/features/shop/screens/profile/widgets/profile_menu.dart';
import 'package:e_commerce_app/images/images.dart';
import 'package:e_commerce_app/utils/effects/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/sizes.dart';
import 'change_name.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const EAppBar(
        showBackArrow: true,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image =
                          networkImage.isNotEmpty ? networkImage : EImages.user;
                      return controller.imageLoading.value
                          ? const EShimmerEffect(width: 80, height: 80)
                          : ECircularImage(
                              image: image,
                              width: 80,
                              height: 80,
                              isNetworkImage: networkImage.isNotEmpty,
                            );
                    }),
                    TextButton(
                        onPressed: () => controller.uploadUserProfilePicture(),
                        child: const Text('Change Profile Picture'))
                  ],
                ),
              ),

              //details
              const SizedBox(
                height: ESizes.spaceBtnItems / 2,
              ),
              const Divider(),
              const SizedBox(height: ESizes.spaceBtnItems),

              const ESectionHeading(
                title: 'Profile Information',
                showActionButton: false,
              ),

              const SizedBox(height: ESizes.spaceBtnItems),

              EProfileMenu(
                onPressed: () => Get.to(() => const ChangeName()),
                title: 'Name',
                value: controller.user.value.fullname,
              ),
              EProfileMenu(
                onPressed: () {},
                title: 'Username',
                value: controller.user.value.username,
              ),

              const SizedBox(height: ESizes.spaceBtnItems),
              const Divider(),
              const SizedBox(height: ESizes.spaceBtnItems),

              const ESectionHeading(
                title: 'Personal Information',
                showActionButton: false,
              ),
              const SizedBox(height: ESizes.spaceBtnItems),

              EProfileMenu(
                onPressed: () {},
                title: 'User Id',
                value: controller.user.value.id,
              ),
              EProfileMenu(
                onPressed: () {},
                title: 'E-mail',
                value: controller.user.value.email,
              ),
              EProfileMenu(
                onPressed: () {},
                title: 'Phone Number',
                value: controller.user.value.phoneNumber,
              ),
              EProfileMenu(
                onPressed: () {},
                title: 'Gender',
                value: 'Male',
              ),
              EProfileMenu(
                onPressed: () {},
                title: 'Date of Birth',
                value: '28 Dec, 1998',
              ),

              const SizedBox(height: ESizes.spaceBtnItems),
              const Divider(),
              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text(
                    'Close Account',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
