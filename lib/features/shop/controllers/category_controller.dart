import 'package:e_commerce_app/data/repositories/category_repository/category_repository.dart';
import 'package:e_commerce_app/data/repositories/product_repository/product_repository.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../models/category_model.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  final RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  final RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  //Load category data
  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;

      //Fetch Categories from data source (Firestore or API)
      final categories = await _categoryRepository.getAllCategories();

      //update the categories list
      allCategories.assignAll(categories);

      //filter featured categories
      featuredCategories.assignAll(allCategories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .take(8)
          .toList());
    } catch (e) {
      ELoaders.erroSnackBar(title: 'Ooops', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //load selected category data
  Future<List<CategoryModel>> getSubCategories({
    required categoryId,
  }) async {
    try {
      final subCategories =
          await _categoryRepository.getSubCategories(categoryId);
      return subCategories;
    } catch (e) {
      ELoaders.erroSnackBar(title: 'Ooops', message: e.toString());
      return [];
    }
  }

  //Get category or sub category products
  Future<List<ProductModel>> getCategoryProducts(
      {required categoryId, int limit = 4}) async {
    try {
      //fetch limited products against each subcategory;
      final products = await ProductRepository.instance
          .getProductsForCategory(categoryId: categoryId, limit: limit);
      return products;
    } catch (e) {
      ELoaders.erroSnackBar(title: 'Ooops', message: e.toString());
      return [];
    }
  }
}
