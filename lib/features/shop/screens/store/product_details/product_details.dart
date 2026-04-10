import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/features/shop/screens/store/product_details/bottom_add_to_cart.dart';
import 'package:e_commerce_app/features/shop/screens/store/product_details/product_image_slider.dart';
import 'package:e_commerce_app/features/shop/screens/store/product_details/product_metadata.dart';
import 'package:e_commerce_app/features/shop/screens/store/product_details/ratings_and_share.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../../../utils/constants/colors.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final darkMode = EHelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: BottomAddToCart(product: product),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product image Slider
            EProductImageSlider(product: product),

            //product details
            Padding(
              padding: const EdgeInsets.only(
                  right: ESizes.defaultSpace,
                  left: ESizes.defaultSpace,
                  bottom: ESizes.defaultSpace),
              child: Column(
                children: [
                  //Rating and Share

                  const ERatingsAndShare(),
                  //Price, Title, Stack and Brand

                  EProductMetaData(
                    product: product,
                  ),

                  // const SizedBox(
                  //   height: ESizes.spaceBtnSections,
                  // ),
                  //Checkout button
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     onPressed: () {},
                  //     child: const Text('CheckOut'),
                  //   ),
                  // ),
                  const SizedBox(
                    height: ESizes.spaceBtnItems,
                  ),

                  //Description
                  ESectionHeading(
                    title: 'Description',
                    showActionButton: false,
                    textColor: darkMode ? EColors.white : EColors.black,
                  ),
                  const SizedBox(
                    height: ESizes.spaceBtnItems,
                  ),
                  ReadMoreText(
                    product.description ?? '',
                    style: TextStyle(
                        fontSize: 14,
                        color: darkMode ? EColors.white : EColors.black),
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'show more',
                    trimExpandedText: ' show less',
                    moreStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: darkMode ? EColors.white : EColors.black),
                    lessStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: darkMode ? EColors.white : EColors.black),
                  ),
                  //Reviews
                  const Divider(),

                  // const SizedBox(
                  //   height: ESizes.spaceBtnItems,
                  // ),

                  const SizedBox(
                    height: ESizes.spaceBtnSections,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
