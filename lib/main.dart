import 'package:e_commerce_app/app.dart';
import 'package:e_commerce_app/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce_app/features/authentication/controller/network_manager/network_manager.dart';
import 'package:e_commerce_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {

  //Initialize network 
  Get.put(NetworkManager(), permanent: true);
  //Todo: Add Widgets Binding
  // final WidgetsBinding widgetsBinding = 
  WidgetsFlutterBinding.ensureInitialized();

  //Todo: Init Local Storage
  await GetStorage.init();

  //Todo: Init Payment Methods

  //Todo: Initialize Firebase
  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,

  ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));
  //Todo: Initialize Authentication

  runApp(
    const MyApp(),
  );
}
