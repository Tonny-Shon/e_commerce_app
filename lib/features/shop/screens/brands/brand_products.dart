import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/features/shop/controllers/product/brand_controller.dart';
import 'package:e_commerce_app/features/shop/models/brand_model.dart';
import 'package:e_commerce_app/features/shop/screens/all_products/sortable.dart';
import 'package:e_commerce_app/features/shop/screens/store/widgets/brand_card.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    final dark = EHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: EAppBar(
        title: Text(brand.name, style: Theme.of(context).textTheme.headlineMedium!.apply(color: dark ? EColors.white : EColors.black),),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              EBrandCard(
                showBorder: true,
                brand: brand,
              ),
              const SizedBox(
                height: ESizes.spaceBtnSections,
              ),
              FutureBuilder(
                  future: controller.getBrandProducts(brandId: brand.id),
                  builder: (context, snapshot) {
                    //const loader = EVerticalShimmerEffect();
                    final widget = ECloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot,
                        loader: const CircularProgressIndicator());
                    if (widget != null) return widget;

                    //Record found
                    final brandProducts = snapshot.data!;
                    return ESortableProducts(
                      products: brandProducts,
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
