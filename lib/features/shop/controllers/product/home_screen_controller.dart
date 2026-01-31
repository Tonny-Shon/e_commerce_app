// import 'package:e_commerce_app/data/repositories/category_repository/category_repository.dart';
// import 'package:e_commerce_app/data/repositories/product_repository/product_repository.dart';
// import 'package:e_commerce_app/features/shop/models/category_model.dart';
// import 'package:e_commerce_app/features/shop/models/product_model.dart';
// import 'package:get/instance_manager.dart';
// import 'package:get/state_manager.dart';

// class HomeScreenController extends GetxController{
//   static HomeScreenController get instance => Get.find();

//   final categoryController = Get.find<CategoryRepository>();
//   final productRepo = Get.find<ProductRepository>();

//   final RxList<CategoryModel> categories = <CategoryModel>[].obs;

//   ///Cache category products
//   final Map<String, List<ProductModel>> categoryProducts = {};

//   final isLoadingCategories = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     // fetchCategories();
//   }

//   Future<void> fetchCategories() async{
//     try{
//       isLoadingCategories.value = true;
//       categories.assignAll(await CategoryRepository.getHomeCategories());
//     }finally{
//       isLoadingCategories.value = false;
//     }
//   }
// }