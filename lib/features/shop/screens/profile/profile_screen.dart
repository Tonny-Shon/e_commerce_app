import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce_app/features/shop/screens/cart/cart.dart';
import 'package:e_commerce_app/features/shop/screens/orders/oders.dart';
import 'package:e_commerce_app/features/shop/screens/profile/widgets/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/common_shapes/containers/primary_curved_widget.dart';
import '../../../../common/widgets/listtiles/settings_menu_tile.dart';
import '../../../../common/widgets/listtiles/user_profile_tile.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(AuthenticationRepository());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Header
            EPrimaryCurvedWidget(
              child: Column(
                children: [
                  EAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: EColors.white),
                    ),
                  ),

                  //user profile card
                  EUserProfileTile(
                      onPressed: () => Get.to(
                            const UserProfileScreen(),
                          )),
                  const SizedBox(
                    height: ESizes.spaceBtnSections,
                  ),
                ],
              ),
            ),
            //body part
            Padding(
              padding: const EdgeInsets.all(ESizes.defaultSpace),
              child: Column(
                children: [
                  const ESectionHeading(
                    title: 'Account Setting',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: ESizes.spaceBtnItems,
                  ),
                  // ESettingsTile(
                  //   icon: Iconsax.safe_home,
                  //   title: 'My Address',
                  //   subTitle: 'Set shopping delivery address',
                  //   onTap: () => Get.to(() => const UserAddressScreen()),
                  // ),

                  ESettingsTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subTitle: 'Add, remove products and move to checkout',
                    onTap: () => Get.to(() => const CartScreen()),
                  ),
                  ESettingsTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subTitle: 'In-progress and Completed Orders',
                    onTap: () => Get.to(() => const OrdersScreen()),
                  ),
                  // ESettingsTile(
                  //   icon: Iconsax.bank,
                  //   title: 'Bank Account',
                  //   subTitle: 'Withdraw balance to registered bank account',
                  //   onTap: () {},
                  // ),
                  // ESettingsTile(
                  //   icon: Iconsax.discount_shape,
                  //   title: 'My Coupons',
                  //   subTitle: 'List all the discounted coupons',
                  //   onTap: () {},
                  // ),
                  // ESettingsTile(
                  //   icon: Iconsax.notification,
                  //   title: 'Notifications',
                  //   subTitle: 'Get any kind of notification message',
                  //   onTap: () {},
                  // ),
                  // ESettingsTile(
                  //   icon: Iconsax.security_card,
                  //   title: 'Account Privacy',
                  //   subTitle: 'Manage data usage and connected accounts',
                  //   onTap: () {},
                  // ),

                  //app settings
                  // const SizedBox(
                  //   height: ESizes.spaceBtnSections,
                  // ),
                  // const ESectionHeading(
                  //   title: 'App Settings',
                  //   showActionButton: false,
                  // ),
                  // const SizedBox(
                  //   height: ESizes.spaceBtnItems,
                  // ),
                  // const ESettingsTile(
                  //     icon: Iconsax.document_upload,
                  //     title: 'Load Data',
                  //     subTitle: 'Upload Data to your cloud'),

                  // ESettingsTile(
                  //   icon: Iconsax.location,
                  //   title: 'Geolocation',
                  //   subTitle: 'Get recommendation based on location',
                  //   onTap: () {},
                  //   trailing: Switch(
                  //     value: true,
                  //     onChanged: (value) {},
                  //   ),
                  // ),
                  // ESettingsTile(
                  //   icon: Iconsax.security_user,
                  //   title: 'Safe mode',
                  //   subTitle: 'Search result for all ages',
                  //   onTap: () {},
                  //   trailing: Switch(
                  //     value: false,
                  //     onChanged: (value) {},
                  //   ),
                  // ),
                  // ESettingsTile(
                  //   icon: Iconsax.image,
                  //   title: 'No Image quality',
                  //   subTitle: 'Set Image Quality to be seen',
                  //   onTap: () {},
                  //   trailing: Switch(
                  //     value: true,
                  //     onChanged: (value) {},
                  //   ),
                  // ),

                  //logout button
                  const SizedBox(
                    height: ESizes.spaceBtnSections,
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () =>
                          AuthenticationRepository.instance.logout(),
                      child: const Text('Logout'),
                    ),
                  ),
                  const SizedBox(
                    height: ESizes.spaceBtnSections * 2.5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
