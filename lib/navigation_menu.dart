import 'package:e_commerce_app/features/shop/screens/home/home_screen.dart';
import 'package:e_commerce_app/features/shop/screens/profile/profile_screen.dart';
import 'package:e_commerce_app/features/shop/screens/store/store_screen.dart';
import 'package:e_commerce_app/features/shop/screens/wishlist/wishlist_screen.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'features/authentication/controller/network_manager/network_manager.dart';
import 'utils/popups/network_overlay.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = EHelperFunctions.isDarkMode(context);
    final manager = Get.find<NetworkManager>();
    
    return Obx((){
      return Stack(
        children: [
          Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          backgroundColor: darkMode ? EColors.black : Colors.white,
          indicatorColor: darkMode
              ? EColors.white.withValues(alpha:0.1)
              : EColors.black.withValues(alpha:0.2),
          height: 60,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
            NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    ),
    if(!manager.isConnected.value)
      const NetworkOverlay(),
        ],
      );
    });
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = const [
    HomeScreen(),
    StoreScreen(),
    WishlistScreen(),
    ProfileScreen()
  ];
}
