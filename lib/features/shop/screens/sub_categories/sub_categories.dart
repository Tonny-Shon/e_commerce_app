import 'package:e_commerce_app/common/common_shapes/slider_images/slider_images.dart';
import 'package:e_commerce_app/common/products_cart/product_card_horizontal.dart';
import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/images/images.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EAppBar(
        title: Text(
          'Beddings',
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              //Banner
              const ERoundedImage(
                imageUrl: EImages.icBeddings,
                width: double.infinity,
                height: null,
                applyImageRadius: true,
              ),
              const SizedBox(
                height: ESizes.spaceBtnItems,
              ),

              //subCategorie
              Column(
                children: [
                  ESectionHeading(
                    title: 'Beddings',
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: ESizes.spaceBtnItems / 2,
                  ),
                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => const SizedBox(
                        width: ESizes.spaceBtnItems,
                      ),
                      itemBuilder: (context, index) => const EProductCardHorizontal(),
                      itemCount: 4,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
