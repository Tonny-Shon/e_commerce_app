import 'package:e_commerce_app/common/products_cart/product_card_vertical.dart';
import 'package:e_commerce_app/features/shop/screens/store/widgets/bran_show_case.dart';
import 'package:e_commerce_app/images/images.dart';
import 'package:flutter/material.dart';

import '../../../../../common/common_shapes/layouts/grid_layout.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';

class ECategoryTab extends StatelessWidget {
  const ECategoryTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(ESizes.defaultSpace),
            child: Column(children: [
              //Images
              const EShowBrandCase(
                images: [
                  EImages.icBabyProdducts,
                  EImages.icBeddings,
                  EImages.icFashion
                ],
              ),
              const SizedBox(
                height: ESizes.spaceBtnItems,
              ),
              ////Products
              ESectionHeading(
                title: 'You might like',
                showActionButton: true,
                onPressed: () {},
              ),
              const SizedBox(
                height: ESizes.spaceBtnItems,
              ),
              EGridLayout(
                  itemCount: 4,
                  itemBuilder: (_, index) => const EProductCardVertical())
            ]),
          ),
        ]);
  }
}
