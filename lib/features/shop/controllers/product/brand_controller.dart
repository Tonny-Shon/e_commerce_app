import 'package:e_commerce_app/data/repositories/product_repository/product_repository.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/brand_repository/brand_repository.dart';
import '../../models/brand_model.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  RxBool isLoading = true.obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final brandRepository = Get.put(BrandRepository());

  @override
  void onInit() {
    super.onInit();
    getFeaturedBrands();
  }

  //load Brands
  Future<void> getFeaturedBrands() async {
    try {
      isLoading.value = true;

      final brands = await brandRepository.getAllBrands();

      allBrands.assignAll(brands);

      featuredBrands
          .assignAll(allBrands.where((brand) => brand.isFeatured ?? false));
    } catch (e) {
      ELoaders.erroSnackBar(title: 'Ooops', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //Get Brands for category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      final brands = await brandRepository.getBrandsForCategory(categoryId);
      return brands;
    } catch (e) {
      ELoaders.erroSnackBar(title: 'Oooops', message: e.toString());
      return [];
    }
  }

  //get Brand Specific products from your data source
  Future<List<ProductModel>> getBrandProducts(
      {required String brandId, int limit = -1}) async {
    try {
      final products = await ProductRepository.instance
          .getProductsForBrand(brandId: brandId, limit: limit);
      return products;
    } catch (e) {
      ELoaders.erroSnackBar(title: 'Oooops', message: e.toString());
      return [];
    }
  }
}
