// import 'package:e_commerce_app/features/shop/controllers/product/image_controller.dart';
// import 'package:e_commerce_app/features/shop/models/product_model.dart';
// import 'package:e_commerce_app/features/shop/models/prooduct_variations.dart';
// import 'package:get/get.dart';

// class VariationController extends GetxController {
//   static VariationController get instance => Get.find();

//   //variables
//   RxMap selectedAttributes = {}.obs;
//   RxString variationStockStatus = ''.obs;
//   Rx<ProductVariationModel> selectedVariation =
//       ProductVariationModel.empty().obs;

//   //select Attribute, and variation
//   void onAttributeSelected(
//       ProductModel product, attributeName, attributeValue) {
//     final selectedAttribute = Map<String, dynamic>.from(selectedAttributes);
//     selectedAttribute[attributeName] = attributeValue;
//     selectedAttributes[attributeName] = attributeValue;

//     final selectedVariation = product.productVariations!.firstWhere(
//       (variation) =>
//           _isSameAttributeVlaue(variation.attributeValues, selectedAttribute),
//       orElse: () => ProductVariationModel.empty(),
//     );

//     /// show the selected variation image as main image
//     if (selectedVariation.image.isNotEmpty) {
//       ImageController.instance.selectedProductImage.value =
//           selectedVariation.image;
//     }

//     //assign the selected variation
//     this.selectedVariation.value = selectedVariation;

//     //update selected product variation status
//     getProductVariationStockStatus();
//   }

//   bool _isSameAttributeVlaue(Map<String, dynamic> variationAtrributes,
//       Map<String, dynamic> selectedAttributes) {
//     //if seletedAttribute contains 3 attributes and current variation contains 2 the return
//     if (variationAtrributes.length != selectedAttributes.length) return false;

//     //if any od the attributes is different then return eg {Green, Large} or {Green, Small}
//     for (final key in variationAtrributes.keys) {
//       //Attributes[key] = value which could be [Green, Small, Cotton] etc
//       if (variationAtrributes[key] != selectedAttributes[key]) return false;
//     }
//     return true;
//   }

//   ///// Check Product availability / Stock in Variation
//   Set<String?> getAttributeAvailabilityInVariation(
//       List<ProductVariationModel> variations, String attributeName) {
//     final availableVariations = variations
//         .where((variation) =>
//             variation.attributeValues[attributeName] != null &&
//             variation.attributeValues[attributeName]!.isNotEmpty &&
//             variation.stock > 0)
//         .map((variation) => variation.attributeValues[attributeName])
//         .toSet();

//     return availableVariations;
//   }

//   String getVariationPrice() {
//     return (selectedVariation.value.price > 0
//             ? selectedVariation.value.salePrice
//             : selectedVariation.value.price)
//         .toString();
//   }

//   //check product variation stock status
//   void getProductVariationStockStatus() {
//     variationStockStatus.value =
//         selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
//   }

//   //Reset selected attributes when switching products
//   void resetSelectedAttributes() {
//     selectedAttributes.clear();
//     variationStockStatus.value = '';
//     selectedVariation.value = ProductVariationModel.empty();
//   }
// }
