import 'package:e_commerce_app/features/shop/screens/sub_categories/sub_categories.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/category_controller.dart';
import '../all_products/all_products.dart';
import 'category_grid_tile.dart'; // we'll create this

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    final CategoryController categoryController = Get.find();

    // Ensure all categories are loaded (if not already)
    // You might need to call a method like fetchAllCategories() if your controller separates featured vs all.
    // For simplicity, we'll assume categoryController.allCategories is an RxList.
    // If you don't have that, modify your CategoryController to load all categories.

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: dark ? EColors.secondaryColor : EColors.black,
            )),
        title: Text(
          'All Categories',
          style: TextStyle(color: dark ? EColors.white : EColors.black),
        ),
      ),
      body: Obx(() {
        if (categoryController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (categoryController.allCategories.isEmpty) {
          return const Center(child: Text('No categories found.'));
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // four in a row
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8, // adjust to your liking (width/height)
            ),
            itemCount: categoryController.allCategories.length,
            itemBuilder: (context, index) {
              final category = categoryController.allCategories[index];
              return CategoryGridTile(
                category: category,
                onTap: () =>
                  // Navigate to products of this category
                  Get.to(() => AllProducts(
                title: category.name,
                futureMethod:
                    categoryController.getCategoryProducts(categoryId: category.id),
              )),
                
              );
            },
          ),
        );
      }),
    );
  }
}
