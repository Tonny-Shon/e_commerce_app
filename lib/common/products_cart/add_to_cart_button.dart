import 'package:e_commerce_app/features/shop/controllers/animation_controller.dart';
import 'package:e_commerce_app/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/features/shop/screens/cart/cart.dart';
import 'package:e_commerce_app/services/dialog_service.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';

class ProductCardAddToCartButton extends StatelessWidget {
  const ProductCardAddToCartButton({
    super.key,
    required this.product,
  });
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final animationController = Get.put(CartAnimationController());

    return GestureDetector(
      onTap: () => _handleTap(cartController, animationController),
      onLongPress: () => _handleLongPress(cartController),
      child: Obx((){
        final isInCart = cartController.isProductInCart(product.id);

        return AnimatedBuilder(animation: animationController.scaleAnimation,
         builder: (context, child){
          return Transform.scale(scale: animationController.scaleAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              color: isInCart ? EColors.success : EColors.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(ESizes.cardRadiusMd),
                bottomRight: Radius.circular(ESizes.productImageRadius),
              ),
              boxShadow: [
                if(isInCart)
                BoxShadow(color: EColors.success.withValues(alpha: 0.3),
                blurRadius: 8,
                spreadRadius: 2),
              ],
            ),
            child: SizedBox(width: ESizes.iconLg * 1.2,
            height: ESizes.iconLg * 1.2,
            child: Center(
              child: AnimatedBuilder(animation: animationController.rotationAnimation,
               builder: (context, child){
                return Transform.rotate(angle: animationController.rotationAnimation.value * 2 * 3.14159, child: Icon(isInCart ? Iconsax.shopping_bag : Iconsax.add, color: EColors.white, size: ESizes.iconMd,),);
               }),
            ),),
          ),
          );
         });
      }),
    );

    // return GestureDetector(
    //   onTap: () {
    //     // final cartItem = cartController.convertToCartItem(product, 1);
    //     // cartController.addItemToCart(cartItem);
    //     if (cartController.isProductInCart(product.id)) {
    //       Get.snackbar('Already in Cart', '${product.title} is already in cart',
    //           snackPosition: SnackPosition.BOTTOM,
    //           backgroundColor: EColors.primaryColor,
    //           colorText: EColors.white,
    //           duration: const Duration(seconds: 2));
    //     } else {
    //       final cartItem = cartController.convertToCartItem(product, 1);
    //       cartController.addItemToCart(cartItem);

    //       Get.snackbar(
    //         'Added to cart',
    //         '${product.title} addde to cart',
    //         snackPosition: SnackPosition.BOTTOM,
    //         backgroundColor: Colors.green,
    //         colorText: EColors.white,
    //         duration: const Duration(seconds: 2),
    //       );
    //     }
    //   },
    //   child: Obx(() {
    //     // final productQuantityInCart =
    //     //     cartController.getProductQuantityInCart(product.id);
    //     final isInCart = cartController.isProductInCart(product.id);
    //     return Container(
    //       decoration: BoxDecoration(
    //         color: isInCart ? EColors.secondaryColor : EColors.primaryColor,
    //         borderRadius: const BorderRadius.only(
    //           topLeft: Radius.circular(
    //             ESizes.cardRadiusMd,
    //           ),
    //           bottomRight: Radius.circular(ESizes.productImageRadius),
    //         ),
    //       ),
    //       child: SizedBox(
    //         width: ESizes.iconLg * 1.2,
    //         height: ESizes.iconLg * 1.2,
    //         child: Center(
    //           child: isInCart
    //               ? const Icon(
    //                   Iconsax.tick_circle,
    //                   color: EColors.white,
    //                   size: ESizes.iconMd,
    //                 )
    //               // Text(
    //               //     productQuantityInCart.toString(),
    //               //     style: Theme.of(context)
    //               //         .textTheme
    //               //         .bodyLarge!
    //               //         .apply(color: EColors.white),
    //               //   )
    //               : const Icon(
    //                   Iconsax.add,
    //                   color: EColors.white,
    //                 ),
    //         ),
    //       ),
    //     );
    //   }),
    // );
  }

  Future<void> _handleTap(
    CartController cartController,
    CartAnimationController animationController,
  ) async {
    if (cartController.isProductInCart(product.id)) {
      await cartController.hapticError();
      await DialogService.showAlreadyInCartDialog(
        productName: product.title,
        onViewCart: () { Get.offAll(
          () => const CartScreen(),
        );},
      );
    }else{
      //Add Product to cart with animation
      await cartController.hapticAdd();
      await animationController.playAddAnimation();

      final cartItem = cartController.convertToCartItem(product, 1);
      cartController.addItemToCart(cartItem);

      ELoaders.showSuccessSnackBar(title: 'Added to cart', message: '${product.title} added to your cart');
    }
  }

  Future<void> _handleLongPress(CartController cartController) async{
    if(!cartController.isProductInCart(product.id)) return;

    final shouldRemove = await DialogService.showRemoveConfirmationDialog(productName: product.title);

    if(shouldRemove){
      await cartController.hapticRemove();
      final currentQuantity = cartController.getProductQuantityInCart(product.id);
      final cartItem = cartController.convertToCartItem(product, currentQuantity);
      cartController.removeItemFromCart(cartItem);   
      
      ELoaders.showUndoSnackbar(message: '${product.title} removed from your cart',
       onUndo: (){
        cartController.addItemToCart(cartItem);
        cartController.hapticSuccess();
       });
       }
  }
}
