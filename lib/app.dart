import 'package:e_commerce_app/bindings/general_bindings.dart';
import 'package:e_commerce_app/routes/app_routes.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.pages.toList(),
      themeMode: ThemeMode.system,
      theme: EAppTheme.lightTheme,
      darkTheme: EAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      home: const RefreshScreen(),
    );
  }
}

class RefreshScreen extends StatelessWidget {
  const RefreshScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: EColors.redColor),
        child: const Center(
          child: Image(
            image: AssetImage(
              EImagesLogos.applogo,
            ),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
