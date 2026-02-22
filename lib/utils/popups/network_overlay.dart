import 'package:e_commerce_app/features/authentication/controller/network_manager/network_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkOverlay extends StatelessWidget {
  final Widget child;
  const NetworkOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final NetworkManager manager = NetworkManager.instance;

    return Obx(() => Stack(
          children: [
            child,
            if (!manager.isConnected.value)
              //Full screen overlay that blocks interaction
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.wifi_off,
                            size: 60,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "No internet connection",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Please check your connection and try again.",
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                              onPressed: () {
                                manager.checkConnection();
                              },
                              child: const Text("Retry"))
                        ],
                      ),
                    ),
                  ),
                ),
              )
          ],
        ));
  }
}
