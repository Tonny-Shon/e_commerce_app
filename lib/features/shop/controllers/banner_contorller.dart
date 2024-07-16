import 'package:e_commerce_app/data/repositories/banner/banner_repository.dart';
import 'package:e_commerce_app/features/shop/models/banner_model.dart';
import 'package:get/get.dart';

import '../../../utils/popups/loaders.dart';

class BannerController extends GetxController {
  //variables
  final carouselCurrentIndex = 0.obs;
  final isLoading = false.obs;
  RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBanners();
  }

  //update page navigation dots
  void updatepageIndicator(index) {
    carouselCurrentIndex.value = index;
  }

  //fetch banners
  Future<void> fetchBanners() async {
    try {
      isLoading.value = true;

      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners();

      //assing banners
      this.banners.assignAll(banners);
    } catch (e) {
      ELoaders.erroSnackBar(title: 'Ooops', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
