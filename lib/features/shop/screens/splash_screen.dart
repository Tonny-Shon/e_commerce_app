import 'package:e_commerce_app/images/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../navigation_menu.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'Splash Screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(Get.context!,
          MaterialPageRoute(builder: (context) => const NavigationMenu()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background Image
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              EImages.icSplashBg,
              fit: BoxFit.cover,
            ),
          ),

          /// Bottom Loading Section
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Loading Indicator
                const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.blue,
                ),

                12.heightBox,

                /// Loading text
                "Loading...".text.color(Colors.grey.shade700).size(14).make(),

                20.heightBox,

                /// Developer Name
                "Shontian Developers"
                    .text
                    .color(Colors.grey.shade600)
                    .size(12)
                    .make(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
