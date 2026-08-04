import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/data/repositories/product_repository/product_repository.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../category_controller.dart';

class AllProductsController extends GetxController {
  static AllProductsController get instance => Get.find();

  final repository = ProductRepository.instance;
  final RxString selectedSortOption = 'Name'.obs;
  //final RxList<ProductModel> products = <ProductModel>[].obs;
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  RxList<ProductModel> products = <ProductModel>[].obs;
  final categoryController = Get.put(CategoryController());

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

  Future<List<ProductModel>> getAllProductsByQuery(Query? query) async {
    try {
      if (query == null) return [];
      final productList = await repository.getAllProductsByQuery(query);
      products.assignAll(productList);
      return productList;
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

      case 'Newest':
        featuredProducts.sort((a, b) => a.date!.compareTo(b.date!));
        break;
      default:
        featuredProducts.sort((a, b) => a.title.compareTo(b.title));
    }
  }

  void assignProducts(List<ProductModel> products) {
    featuredProducts.assignAll(products);
    this.products.assignAll(products);
    sortProducts('Name');
  }
}
