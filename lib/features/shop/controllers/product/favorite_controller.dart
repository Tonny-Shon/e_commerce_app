import 'dart:convert';

import 'package:e_commerce_app/data/repositories/product_repository/product_repository.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/utils/local_storage/storage_utility.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  static FavoriteController get instance => Get.find();

  //variables
  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavorites();
  }

  //Method to intialize favorites by reading from storage
  Future<void> initFavorites() async {
    final json = ELocalStorage.instance().readData('favorites');

    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(
          storedFavorites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavorites(String productId) {
    return favorites[productId] ?? false;
  }

  void toggleFavoriteProducts(String productId) {
    if (!favorites.containsKey(productId)) {
      favorites[productId] = true;
      saveFavoritesToStorage();
      ELoaders.customToast(message: 'Product added to wishlist.');
    } else {
      ELocalStorage.instance().removeData(productId);
      favorites.remove(productId);
      saveFavoritesToStorage();
      favorites.refresh();
      ELoaders.customToast(message: 'Product removed from wishlist.');
    }
  }

  void saveFavoritesToStorage() {
    final encodedFavorites = json.encode(favorites);
    ELocalStorage.instance().saveData('favorites', encodedFavorites);
  }

  Future<List<ProductModel>> favoriteProducts() async {
    try {
      final favoriteProducts = favorites.keys.toList();
      if (favoriteProducts.isNotEmpty) {
        return await ProductRepository.instance
            .getFavoriteProducts(favorites.keys.toList());
      }
      return [];
    } catch (e) {
      //ELoaders.warningSnackBar(title: 'All items have been removed!.');
      return [];
    }
  }
}
