import 'package:e_commerce_app/common/common_shapes/layouts/grid_layout.dart';
import 'package:e_commerce_app/features/shop/controllers/product/product_controller.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/products_cart/product_card_vertical.dart';
import '../../../../utils/helpers/helper_functions.dart';

class ESearchScreen extends StatelessWidget {
  const ESearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>(); 
   

    return Scaffold(
      // No default AppBar – we create custom one
      body: SafeArea(
        child: Column(
          children: [
            // ── Custom AppBar ───────────────────────────────
            _buildSearchAppBar(context, productController),

            // ── Results ─────────────────────────────────────
            Expanded(
              child: Obx(() {
                if (productController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (productController.searchResults.isEmpty &&
                    productController.searchController.text.trim().isNotEmpty) {
                  return _buildEmptyState();
                }

                // Show hint when search is empty
                if (productController.searchController.text.trim().isEmpty) {
                  return _buildInitialSearchState();
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: ESizes.defaultSpace,
                      vertical: ESizes.sm,
                    ),
                  child: EGridLayout(
                    
                    itemCount: productController.searchResults.length,
                    itemBuilder: (_, index) => EProductCardVertical(
                      product: productController.searchResults[index],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAppBar(BuildContext context, ProductController controller) {
     final dark = EHelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 12, 16, 12),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Back button
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            iconSize: 28,
            color: EColors.primaryColor,
            tooltip: 'Back',
            onPressed: () => Get.back(),
          ),

          const SizedBox(width: 8),

          // Search field – takes remaining space
          Expanded(
            child: TextField(
              controller: controller.searchController,
              autofocus: true, // nice touch for search screen
              textInputAction: TextInputAction.search,
              style: TextStyle(color: dark ? EColors.white : EColors.black),
              decoration: InputDecoration(
                hintText: 'Search products...',
                hintStyle: const TextStyle(
                  color: EColors.textfieldGrey,
                  fontFamily: semibold,
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: EColors.primaryColor,
                ),
                filled: true,
                fillColor: dark ? EColors.white.withValues(alpha: 0.05) : EColors.black.withValues(alpha: 0.05),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: EColors.primaryColor,
                    width: 1.5,
                  ),
                ),
              ),
              onChanged: controller.filterProducts,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No products found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try different keywords or check spelling',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialSearchState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_rounded,
            size: 72,
            color: EColors.primaryColor.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 16),
          Text(
            'Start typing to search products',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}