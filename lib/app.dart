import 'package:e_commerce_app/features/shop/screens/splash_screen.dart';
import 'package:e_commerce_app/routes/app_routes.dart';
import 'package:e_commerce_app/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/general_bindings.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: SplashScreen.id,
      routes: const {},
      getPages: AppRoutes.pages.toList(),
      initialBinding: GeneralBindings(),
      themeMode: ThemeMode.system,
      theme: EAppTheme.lightTheme,
      darkTheme: EAppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}
