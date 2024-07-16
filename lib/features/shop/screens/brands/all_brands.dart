import 'package:e_commerce_app/common/common_shapes/layouts/grid_layout.dart';
import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/features/shop/controllers/product/brand_controller.dart';
import 'package:e_commerce_app/features/shop/screens/brands/brand_products.dart';
import 'package:e_commerce_app/features/shop/screens/store/widgets/brand_card.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return Scaffold(
      appBar: const EAppBar(
        title: Text('Brands'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              const ESectionHeading(
                title: 'Brands',
                showActionButton: false,
              ),
              const SizedBox(
                height: ESizes.spaceBtnItems,
              ),
              Obx(() {
                if (brandController.isLoading.value) {
                  return const CircularProgressIndicator();
                  //EBrandShimmer();
                }

                if (brandController.allBrands.isEmpty) {
                  return Center(
                    child: Text(
                      'No Data Found.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: Colors.white),
                    ),
                  );
                }
                return EGridLayout(
                  mainAxisExtent: 55,
                  itemCount: brandController.allBrands.length,
                  itemBuilder: (_, index) {
                    final brand = brandController.allBrands[index];

                    return EBrandCard(
                      showBorder: true,
                      onTap: () => Get.to(() => BrandProducts(
                            brand: brand,
                          )),
                      brand: brand,
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
