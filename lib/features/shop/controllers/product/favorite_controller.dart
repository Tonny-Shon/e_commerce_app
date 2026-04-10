import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce_app/data/repositories/product_repository/product_repository.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/local_storage/storage_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  static FavoriteController get instance => Get.find();

  //variables
  final favorites = <String, bool>{}.obs;

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;
  bool get isAuthenticated => _userId != null;

  DocumentReference get _favDoc =>
      _firestore.collection('favorites').doc(_userId);

  @override
  onInit() {
    super.onInit();
    // 1. Load local first
    initFavorites();

    // 2. React to auth changes
    ever(AuthenticationRepository.instance.cu, (User? user) async {
      if (user != null && !user.isAnonymous) {
        // Sync local to cloud on login
        await _syncFavoritesOnLogin();
      } else {
        // Clear local favorites on logout/anonymous
        // favorites.clear();
      }
    });
    // If already logged in on app start
    if (AuthenticationRepository.instance.isLoggedIn) {
      _syncFavoritesOnLogin();
    }
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   initFavorites();
  // }

  //Method to intialize favorites by reading from storage
  Future<void> initFavorites() async {
    final jsonStr = ELocalStorage().readData('favorites');

    if (jsonStr != null && jsonStr.isNotEmpty) {
      try {
        final storedFavorites = jsonDecode(jsonStr) as Map<String, dynamic>;
        favorites.assignAll(
            storedFavorites.map((key, value) => MapEntry(key, value as bool)));
      } catch (e) {
        debugPrint("Favorites local decode error: $e");
      }
    }
  }

  bool isFavorites(String productId) {
    return favorites[productId] ?? false;
  }

  Future<void> toggleFavoriteProducts(String productId) async {
    final wasFavorite = isFavorites(productId);

    if (wasFavorite) {
      favorites.remove(productId);
      Get.snackbar('Success', 'Removed from wishlist',
          backgroundColor: EColors.primaryColor, colorText: Colors.white);
    } else {
      favorites[productId] = true;
      Get.snackbar('Success', 'Added to wishlist',
          backgroundColor: EColors.primaryColor, colorText: Colors.white);
    }

    favorites.refresh();
    await saveFavoritesToStorage();

    if (isAuthenticated) {
      await _syncFavoritesToCloud();
    }

    // if (!favorites.containsKey(productId)) {
    //   favorites[productId] = true;
    //   saveFavoritesToStorage();
    //   Get.snackbar(
    //       colorText: Colors.white,
    //       snackPosition: SnackPosition.BOTTOM,
    //       backgroundColor: EColors.primaryColor,
    //       'Success',
    //       'Product added to wishlist.');
    // } else {
    //   ELocalStorage().removeData(productId);
    //   favorites.remove(productId);
    //   saveFavoritesToStorage();
    //   favorites.refresh();
    //   Get.snackbar(
    //       colorText: Colors.white,
    //       snackPosition: SnackPosition.BOTTOM,
    //       backgroundColor: EColors.primaryColor,
    //       'Success',
    //       'Product Removed to wishlist.');
    // }
  }

  Future<void> saveFavoritesToStorage() async {
    final encodedFavorites = json.encode(favorites);
    await ELocalStorage().saveData('favorites', encodedFavorites);
  }

  Future<void> _syncFavoritesToCloud() async {
    if (!isAuthenticated) return;

    final productIds =
        favorites.keys.where((id) => favorites[id] == true).toList();
    try {
      await _favDoc.set({
        'productIds': productIds,
        'lastUpdated': FieldValue.serverTimestamp()
      });
    } catch (e) {
      debugPrint("Error syncing favorites to cloud: $e");
    }
  }

  Future<void> _syncFavoritesOnLogin() async {
    try {
      // Get current local favorites
      final localIds =
          favorites.keys.where((id) => favorites[id] == true).toSet();

      // Fetch from firebase
      final snap = await _favDoc.get();
      Set<String> cloudIds = {};

      if (snap.exists) {
        final data = snap.data() as Map<String, dynamic>;
        final List<dynamic>? productIds = data['productIds'];
        // cloudIds = productIds.map((id) => id.toString()).toSet();
        if (productIds != null) {
          cloudIds = productIds.map((id) => id.toString()).toSet();
        }
      }
      //Merge union of both sets
      final mergedIds = localIds.union(cloudIds);

      final newMap = {for (var id in mergedIds) id: true};
      favorites.assignAll(newMap);
      favorites.refresh();

      await saveFavoritesToStorage();
      await _syncFavoritesToCloud();

      if (mergedIds.isNotEmpty) {
        // Get.snackbar(
        //     'Wishlist synced', '${mergedIds.length} items in your wishlist',
        //     backgroundColor: EColors.primaryColor, colorText: Colors.white);
      }
    } catch (e) {
      debugPrint("Error syncing favorites on login: $e");
    }
  }

  Future<List<ProductModel>> favoriteProducts() async {
    if (favorites.isEmpty) return [];

    final favIds = favorites.keys.where((k) => favorites[k] == true).toList();
    if (favIds.isEmpty) return [];

    try {
      return await ProductRepository.instance.getFavoriteProducts(favIds);
    } catch (e) {
      debugPrint("Load favorite products error: $e");
      return [];
    }
  }

  Future<void> clearRemoteFavorites() async {
    if (isAuthenticated) {
      await _favDoc.delete();
    }
  }
}
