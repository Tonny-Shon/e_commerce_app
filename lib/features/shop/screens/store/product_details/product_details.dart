import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/features/shop/screens/store/product_details/bottom_add_to_cart.dart';
import 'package:e_commerce_app/features/shop/screens/store/product_details/product_attributes.dart';
import 'package:e_commerce_app/features/shop/screens/store/product_details/product_image_slider.dart';
import 'package:e_commerce_app/features/shop/screens/store/product_details/product_metadata.dart';
import 'package:e_commerce_app/features/shop/screens/store/product_details/product_reviews.dart';
import 'package:e_commerce_app/features/shop/screens/store/product_details/ratings_and_share.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product image Slider
            const EProductImageSlider(),

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

                  const EProductMetaData(),

                  //Attributes
                  const ProductAttributes(),

                  const SizedBox(
                    height: ESizes.spaceBtnSections,
                  ),
                  //Checkout button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('CheckOut'),
                    ),
                  ),
                  const SizedBox(
                    height: ESizes.spaceBtnItems,
                  ),

                  //Description
                  const ESectionHeading(
                    title: 'Description',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: ESizes.spaceBtnItems,
                  ),
                  const ReadMoreText(
                    'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable.',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'show more',
                    trimExpandedText: ' show less',
                    moreStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    lessStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  //Reviews
                  const Divider(),

                  // const SizedBox(
                  //   height: ESizes.spaceBtnItems,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ESectionHeading(
                        title: 'Reviews(34)',
                        onPressed: () {},
                        showActionButton: false,
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () => Get.to(() => const ProductReviews()),
                          icon: const Icon(
                            Iconsax.arrow_right3,
                            color: Colors.black,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),

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
