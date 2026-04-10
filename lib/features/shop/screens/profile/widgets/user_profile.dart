import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/cicular_image/circular_image.dart';
import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/features/shop/screens/profile/widgets/profile_menu.dart';
import 'package:e_commerce_app/images/images.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../authentication/controller/user_controller.dart';
import 'show_field_dialog.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    final controller = UserController.instance;

    return Scaffold(
      appBar: EAppBar(
        showBackArrow: true,
        title: Text(
          'Profile',
          style: TextStyle(color: dark ? EColors.white : EColors.black),
        ),
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
                    const ECircularImage(
                      image: EImages.user,
                      width: 100,
                      height: 100,
                    ),
                    TextButton(
                        onPressed: () =>
                            UserController.instance.uploadUserProfilePicture(),
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

              ESectionHeading(
                title: 'Profile Information',
                showActionButton: false,
                textColor: dark ? EColors.white : EColors.black,
              ),

              const SizedBox(height: ESizes.spaceBtnItems),

              EProfileMenu(
                onPressed: () => showEditFieldDialog(
                    context: context,
                    title: 'Username',
                    initialValue: controller.user.value.username,
                    onSave: (newValue) async {
                      try {
                        await controller.updateUsername(newValue);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Username updated successfully')),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        }
                        rethrow; // so the dialog knows to stay open? Actually you can handle inside.
                      }
                    }),
                title: 'Username',
                value: controller.user.value.username,
              ),

              EProfileMenu(
                onPressed: () {},
                title: 'Email',
                value: controller.user.value.email,
              ),
              EProfileMenu(
                onPressed: () => showEditFieldDialog(
                    context: context,
                    title: 'Phone Number',
                    initialValue: controller.user.value.formattedPhoneNo,
                    onSave: (newValue) async {
                      try {
                        await controller.updatePhone(newValue);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Phone number updated successfully')),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        }
                        rethrow; // so the dialog knows to stay open? Actually you can handle inside.
                      }
                    }),
                title: 'Phone Number',
                value: controller.user.value.formattedPhoneNo,
              ),
              // EProfileMenu(
              //   onPressed: () {},
              //   title: 'Gender',
              //   value: controller.user.value.,
              // ),
              // EProfileMenu(
              //   onPressed: () {},
              //   title: 'Date of Birth',
              //   value: controller.user.value.formattedDob,
              // ),

              const SizedBox(height: ESizes.spaceBtnItems),
              const Divider(),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Close Account',
                    style: TextStyle(color: Colors.red, fontSize: 25),
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
