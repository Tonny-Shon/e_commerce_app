import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/data/repositories/product_repository/product_repository.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:get/get.dart';

class AllProductsController extends GetxController {
  static AllProductsController get instance => Get.find();

  final repository = ProductRepository.instance;
  final RxString selectedSortOption = 'Name'.obs;
  //final RxList<ProductModel> products = <ProductModel>[].obs;
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  Future<List<ProductModel>> fetchProductsByQuery(Query? query) async {
    try {
      if (query == null) return [];
      final products = await repository.featuredProductsByQuery(query);
      return products;
    } catch (e) {
      ELoaders.erroSnackBar(title: 'Ooops!', message: e.toString());
      return [];
    }
  }

  void sortProducts(String sortOption) {
    selectedSortOption.value = sortOption;

    switch (sortOption) {
      case 'Name':
        featuredProducts.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Higher Price':
        featuredProducts.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Lower Price':
        featuredProducts.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Sale':
        featuredProducts.sort((a, b) {
          if (b.salePrice > 0) {
            return b.salePrice.compareTo(a.salePrice);
          } else if (a.salePrice > 0) {
            return -1;
          } else {
            return 1;
          }
        });
        break;
      case 'Newest':
        featuredProducts.sort((a, b) => a.date!.compareTo(b.date!));
        break;
      default:
        featuredProducts.sort((a, b) => a.title.compareTo(b.title));
    }
  }

  void assignProducts(List<ProductModel> products) {
    featuredProducts.assignAll(products);
    sortProducts('Name');
  }
}
