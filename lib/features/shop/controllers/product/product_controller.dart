import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/product_repository/product_repository.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  RxList<ProductModel> searchResults = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFeaturedProducts();
  }

  void fetchFeaturedProducts() async {
    try {
      isLoading.value = true;

      //fetch products
      final products = await productRepository.getFeaturedProducts();

      //assign products
      featuredProducts.assignAll(products);
    } catch (e) {
      ELoaders.erroSnackBar(title: 'Ooops', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      //fetch products
      final products = await productRepository.getFeaturedProducts();
      featuredProducts.assignAll(products);
      return featuredProducts;
    } catch (e) {
      ELoaders.erroSnackBar(title: 'Ooops', message: e.toString());
      return [];
    }
  }
//searching for products in the search box

  // Future<List<ProductModel>> fetchSearchResults() async {
  //   try {
  //     //fetch products
  //     final products = await productRepository.searchResults();
  //     searchResults.assignAll(products);
  //     return featuredProducts;
  //   } catch (e) {
  //     ELoaders.erroSnackBar(title: 'Ooops', message: e.toString());
  //     return [];
  //   }
  // }

  // calculate Discount percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  //check percentage stock status
  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In stock' : 'Out of stock';
  }
}

enum ProductType { single, variable }
