import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  var isConnected = false.obs;
  var isNetworkAvailable = false.obs;

  late final Connectivity _connectivity;
  late final InternetConnectionChecker _internetChecker;

  @override
  void onInit() {
    super.onInit();
    _connectivity = Connectivity();
    _internetChecker = InternetConnectionChecker.createInstance();

    _initConnectivity();
    _connectivity.onConnectivityChanged.listen(_updateNetworkStatus);
    _internetChecker.onStatusChange.listen(_updateInternetStatus);
  }

  Future<void> _initConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    _updateNetworkStatus(result); // Now passes a List<ConnectivityResult>
    final hasInternet = await _internetChecker.hasConnection;
    _updateInternetStatus(hasInternet 
        ? InternetConnectionStatus.connected 
        : InternetConnectionStatus.disconnected);
  }

  // Updated to accept List<ConnectivityResult>
  void _updateNetworkStatus(List<ConnectivityResult> result) {
    // Check if any connectivity type is available (not none)
    isNetworkAvailable.value = !result.contains(ConnectivityResult.none);
    
    // Optional: Log the connection types for debugging
    // print('Connection types: $result');
  }

  void _updateInternetStatus(InternetConnectionStatus status) {
    isConnected.value = status == InternetConnectionStatus.connected;
  }

  // Call this when retry is pressed
  Future<void> checkConnection() async {
    _updateInternetStatus(await _internetChecker.hasConnection 
        ? InternetConnectionStatus.connected 
        : InternetConnectionStatus.disconnected);
  }

  @override
  void onClose() {
    _connectivity.onConnectivityChanged.drain();
    _internetChecker.onStatusChange.drain();
    super.onClose();
  }
}






//This is the code for the code that defines the network manager class which is responsible for managing the network connectivity status of the application. It uses the connectivity_plus package to check the internet connection status and listen for changes in connectivity. The class also provides a method to check if the device is currently connected to the internet and shows a warning snackbar if there is no internet connection. The network manager is implemented as a GetX controller, allowing it to be easily accessed throughout the application.


// import 'dart:async';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';

// import '../../../../utils/popups/loaders.dart';

// class NetworkManager extends GetxController {
//   static NetworkManager get instance => Get.find();

//   final Connectivity _connectivity = Connectivity();
//   late StreamSubscription<ConnectivityResult> _connectivitySubscription;
//   final Rx<ConnectivityResult> _connectivityStatus =
//       ConnectivityResult.none.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
//             _updateConnectionStatus as void Function(ConnectivityResult event)?);
//     _initializeConnectionStatus();
//   }

//   Future<void> _initializeConnectionStatus() async {
//     ConnectivityResult result =
//         (await _connectivity.checkConnectivity());
//     _updateConnectionStatus(result);
//   }

//   Future<void> _updateConnectionStatus(ConnectivityResult result) async {
//     _connectivityStatus.value = result;
//     if (_connectivityStatus.value == ConnectivityResult.none) {
//       ELoaders.warningSnackBar(title: 'No Internet Connection');
//     }
//   }

//   Future<bool> isConnected() async {
//     try {
//       final result = await _connectivity.checkConnectivity();
//       // ignore: unrelated_type_equality_checks
//       if (result == ConnectivityResult.none) {
//         return false;
//       } else {
//         return true;
//       }
//     } on PlatformException catch (_) {
//       return false;
//     }
//   }

//   @override
//   void onClose() {
//     super.onClose();
//     _connectivitySubscription.cancel();
//   }
// }




// // import 'dart:async';

// // import 'package:connectivity_plus/connectivity_plus.dart';
// // import 'package:flutter/services.dart';
// // import 'package:get/get.dart';

// // import '../../../../utils/popups/loaders.dart';

// // class NetworkManager extends GetxController {
// //   static NetworkManager get instance => Get.find();

// //   final Connectivity _connectivity = Connectivity();
// //   late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
// //   final Rx<ConnectivityResult> _connectivityStatus =
// //       ConnectivityResult.none.obs;

// //   //initialize the network manager and set up a stream to continuously check the connection status
// //   @override
// //   void onInit() {
// //     super.onInit();
// //     _connectivitySubscription =
// //         _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
// //   }

// //   //update the connection status based on changes in connectivity and show a relevant popup for the internet connection
// //   Future<void> _updateConnectionStatus(List<ConnectivityResult> results) async {
// //     if (results.isNotEmpty) {
// //       _connectivityStatus.value = results.first;
// //       if (_connectivityStatus.value == ConnectivityResult.none) {
// //         ELoaders.warningSnackBar(title: 'No Internet Connection');
// //       }
// //     }
// //   }

// //   //check the internet connection status
// //   //return true if connected, false otherwise
// //   Future<bool> isConnected() async {
// //     try {
// //       final result = await _connectivity.checkConnectivity();
// //       if (result == ConnectivityResult.none) {
// //         return false;
// //       } else {
// //         return true;
// //       }
// //     } on PlatformException catch (_) {
// //       return false;
// //     }
// //   }

// //   // dispose or close rhe active connectivity stream
// //   @override
// //   void onClose() {
// //     super.onClose();
// //     _connectivitySubscription.cancel();
// //   }
// // }
