import 'package:e_commerce_app/features/authentication/controller/network_manager/network_manager.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkOverlay extends StatelessWidget {

  const NetworkOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final manager = Get.find<NetworkManager>();
    final dark = EHelperFunctions.isDarkMode(context);

    return //Full screen overlay that blocks interaction
        Container(
      color: Colors.black.withValues(alpha: 0.7),
      child: Center(
        child: Material(
          //Material is needed for ink effects and elevation
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.wifi_off,
                  size: 60,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                 Text(
                  "No internet connection",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: dark ? EColors.black : EColors.black),
                ),
                const SizedBox(height: 8),
                Text(
                  "Please check your connection and try again.",
                  style: TextStyle(fontSize: 16, color: dark ? EColors.black : EColors.black ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                    onPressed: () {
                      manager.checkConnection();
                    }, 
                    style: ElevatedButton.styleFrom(backgroundColor: EColors.primaryColor, side: BorderSide.none),
                    child: const Text("Retry"),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
