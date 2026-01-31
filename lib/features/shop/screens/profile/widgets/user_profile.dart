import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/cicular_image/circular_image.dart';
import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/features/shop/screens/profile/widgets/profile_menu.dart';
import 'package:e_commerce_app/images/images.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    const ECircularImage(
                      image: EImages.user,
                      width: 80,
                      height: 80,
                    ),
                    TextButton(
                        onPressed: () {},
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
                onPressed: () {},
                title: 'Name',
                value: 'Shontian',
              ),
              EProfileMenu(
                onPressed: () {},
                title: 'Username',
                value: '@shon',
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
                value: '2344325',
              ),
              EProfileMenu(
                onPressed: () {},
                title: 'E-mail',
                value: 'shontian143@gmail.com',
              ),
              EProfileMenu(
                onPressed: () {},
                title: 'Phone Number',
                value: '+256-756505146',
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
                  onPressed: () {},
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
