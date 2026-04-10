import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/common_shapes/containers/primary_curved_widget.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/listtiles/settings_menu_tile.dart';
import '../../../../common/widgets/listtiles/user_profile_tile.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../authentication/screens/login/login.dart';
import '../cart/cart.dart';
import '../orders/oders.dart';
import 'widgets/user_profile.dart'; // assuming you're using this

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final bool isLoggedIn = AuthenticationRepository.instance.authUser != null; // ← adapt this line
    final dark = EHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header (always shown - but content changes)
            EPrimaryCurvedWidget(
              child: Column(
                children: [
                  EAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: dark ? EColors.black : EColors.white),
                    ),
                  ),
                  // const SizedBox(height: ESizes.spaceBtnSections),

                  // Different content based on login state
                  if (isLoggedIn)
                    EUserProfileTile(
                      onPressed: () => Get.to(() => const UserProfileScreen()),
                    )
                  else
                    _buildGuestHeader(context),

                  const SizedBox(height: ESizes.spaceBtnSections),
                ],
              ),
            ),

            // Main content area
            Padding(
              padding: const EdgeInsets.all(ESizes.defaultSpace),
              child: isLoggedIn
                  ? _buildAuthenticatedContent(context, dark)
                  : _buildGuestContent(context, dark),
            ),
          ],
        ),
      ),
    );
  }

  // ── Guest header (not logged in) ────────────────────────────────
  Widget _buildGuestHeader(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha : 0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(
            Iconsax.user,
            size: 64,
            color: Colors.white70,
          ),
          const SizedBox(height: 16),
          Text(
            "Welcome!",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: dark ? EColors.black : EColors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            "Sign in to view your profile, orders, cart and more",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Iconsax.login, size: 20),
              label: const Text("Sign In / Create Account"),
              style: ElevatedButton.styleFrom(
                side: BorderSide.none,
                backgroundColor: EColors.white,
                foregroundColor: EColors.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                // Go to login / signup screen
                Get.to(() => const LoginScreen()); // ← change to your route
              },
            ),
          ),
        ],
      ),
    );
  }

  // ── Authenticated options list ────────────────────────────────
  Widget _buildAuthenticatedContent(BuildContext context, bool dark) {
    return Column(
      children: [
        ESectionHeading(
          title: 'Account Settings',
          showActionButton: false,
          textColor: dark ? EColors.white : EColors.black,
        ),
        const SizedBox(height: ESizes.spaceBtnItems),

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

        // Add more authenticated-only tiles here if needed (address, wishlist, etc.)

        const SizedBox(height: ESizes.spaceBtnSections * 1.5),

        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: EColors.primaryColor),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: () => AuthenticationRepository.instance.logout(),
            child: const Text(
              'Logout',
              style: TextStyle(
                color: EColors.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        const SizedBox(height: ESizes.spaceBtnSections * 2.5),
      ],
    );
  }

  // ── Guest content (not logged in) ────────────────────────────────
  Widget _buildGuestContent(BuildContext context, bool dark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ESectionHeading(
          title: 'Quick Access',
          showActionButton: false,
          textColor: dark ? EColors.white : EColors.black,
        ),
        const SizedBox(height: ESizes.spaceBtnItems),

        // Optional: show some general / public options
        ESettingsTile(
          icon: Iconsax.category,
          title: 'Browse Categories',
          subTitle: 'Discover products',
          onTap: () => Get.toNamed('/categories'), // ← adapt route
        ),
        ESettingsTile(
          icon: Iconsax.shop,
          title: 'Start Shopping',
          subTitle: 'See latest products and offers',
          onTap: () => Get.offAllNamed('/home'), // or your shop route
        ),
        // ESettingsTile(
        //   icon: Iconsax.info_circle,
        //   title: 'About Us',
        //   subTitle: 'Learn more about our store',
        //   onTap: () => Get.to(() => const AboutScreen()),
        // ),

        // const SizedBox(height: 40),

        Center(
          child: Text(
            "Sign in to unlock full features",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
        ),
      ],
    );
  }
}