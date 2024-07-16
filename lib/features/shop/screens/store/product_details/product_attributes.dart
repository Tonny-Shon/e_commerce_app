// import 'package:e_commerce_app/common/common_shapes/containers/circular_container.dart';
// import 'package:e_commerce_app/common/common_shapes/containers/product_text/product_text_price.dart';
// import 'package:e_commerce_app/common/product_size_text.dart';
// import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
// import 'package:e_commerce_app/features/shop/controllers/product/variation_controller.dart';
// import 'package:e_commerce_app/features/shop/models/product_model.dart';
// import 'package:e_commerce_app/features/shop/screens/store/product_details/choice_chip/choice_chip.dart';
// import 'package:e_commerce_app/utils/constants/sizes.dart';
// import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../../../utils/constants/colors.dart';

// class ProductAttributes extends StatelessWidget {
//   const ProductAttributes({super.key, required this.product});

//   final ProductModel product;

//   @override
//   Widget build(BuildContext context) {
//     final dark = EHelperFunctions.isDarkMode(context);
//     //final controller = Get.put(VariationController());
//     return Obx(
//       () => Column(
//         children: [
//           //if (controller.selectedVariation.value.id.isNotEmpty)
//             //selected attribute, pricing and description
//             ERoundedContainer(
//               padding: const EdgeInsets.all(ESizes.md),
//               backgroundColor: dark ? EColors.darkerGrey : EColors.grey,
//               child: Column(
//                 children: [
//                   //title, price and stock
//                   Row(
//                     children: [
//                       const ESectionHeading(
//                         title: 'Variation',
//                         showActionButton: false,
//                       ),
//                       const SizedBox(
//                         width: ESizes.spaceBtnItems,
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               const EProductTitleText(
//                                 title: 'Price : ',
//                                 smallSize: true,
//                               ),
//                               //Actual Price
//                               if (controller.selectedVariation.value.salePrice >
//                                   0)
//                                 Text(
//                                   'Ugx ${controller.getVariationPrice()}',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .titleSmall!
//                                       .apply(
//                                           decoration:
//                                               TextDecoration.lineThrough),
//                                 ),
//                               const SizedBox(
//                                 width: ESizes.spaceBtnItems,
//                               ),
//                               //Sale price
//                               EProductPriceText(
//                                   price: controller.getVariationPrice())
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               const EProductTitleText(
//                                 title: 'Stock : ',
//                                 smallSize: true,
//                               ),
//                               Text(
//                                 controller.variationStockStatus.value,
//                                 style: Theme.of(context).textTheme.titleMedium,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   //variation description
//                   EProductTitleText(
//                     title: controller.selectedVariation.value.description ?? '',
//                     smallSize: true,
//                     maxlines: 4,
//                   ),
//                 ],
//               ),
//             ),
//           const SizedBox(
//             height: ESizes.spaceBtnItems,
//           ),

//           //attributes
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: product.productAttributes!
//                 .map((attribute) => Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ESectionHeading(
//                           title: attribute.name ?? '',
//                           showActionButton: false,
//                         ),
//                         const SizedBox(
//                           height: ESizes.spaceBtnItems / 2,
//                         ),
//                         Obx(
//                           () => Wrap(
//                             spacing: 5,
//                             children: attribute.values!.map((value) {
//                               final isSelected = controller
//                                       .selectedAttributes[attribute.name] ==
//                                   value;
//                               final available = controller
//                                   .getAttributeAvailabilityInVariation(
//                                       product.productVariations!,
//                                       attribute.name!)
//                                   .contains(value);
//                               return EChoiceChip(
//                                 text: value,
//                                 selected: isSelected,
//                                 onSelected: available
//                                     ? (selected) {
//                                         if (selected && available) {
//                                           controller.onAttributeSelected(
//                                               product,
//                                               attribute.name ?? '',
//                                               value);
//                                         }
//                                       }
//                                     : null,
//                               );
//                             }).toList(),
//                           ),
//                         )
//                       ],
//                     ))
//                 .toList(),
//           )
//         ],
//       ),
//     );
//   }
// }
