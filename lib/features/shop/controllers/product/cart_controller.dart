import 'package:e_commerce_app/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce_app/features/shop/models/cart_item_model.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/local_storage/storage_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../services/cart_service.dart';
import '../../../../utils/helpers/helper_functions.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  RxInt numberOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  //final variationController = VariationController.instance;

  final _firebaseService = CartFirebaseService();

  @override
  onInit() {
    super.onInit();
    // loadCartItems();

    final authRepo = AuthenticationRepository.instance;
    final isAlreadyLoggedIn = authRepo.isLoggedIn;

    if(isAlreadyLoggedIn){
      _loadFromFirebaseFirst();
    }else{
      loadCartItems();
    }

    ever(AuthenticationRepository.instance.cu, (User? user) async{
      if(user != null && !user.isAnonymous){
        await _syncCartOnLogin();
      }else{
        // clearCart();
      }
    });
  }

  Future<void> _loadFromFirebaseFirst() async {
  try {
    final remoteItems = await _firebaseService.fetchCartFromFirebase();

    if (remoteItems.isNotEmpty) {
      // Cloud has priority when already logged in
      cartItems.assignAll(remoteItems);
      updateCart();
      // Optional: also overwrite local storage so next guest session starts empty/clean
      saveCartItems();
    } else {
      // Cloud empty → fall back to local
      loadCartItems();
    }
  } catch (e) {
    debugPrint("Firebase cart load failed → using local");
    loadCartItems();
  }
}

  Future<void> _syncCartOnLogin() async{
    try{
      final userCartItems = List<CartItemModel>.from(cartItems);

       //Merge with remote (or just upload if you prefer guest -> login)
      await _firebaseService.mergeAndSync(userCartItems);

     //Load the final(merged) cart from Firebase to ensure we have the latest data
      if(userCartItems.isNotEmpty){
        cartItems.assignAll(userCartItems);
        updateCartTotal();
      }
      updateCart();
      // Get.snackbar('Cart synced', 'Your cart is now updated with your account.');
    }catch(e){
      Get.snackbar('Error', 'Failed to sync cart: $e');
    }
  }

  Future<void> syncCartAfterLogin() async {
  try {
    // 1. Grab whatever is currently in the local cart (guest cart)
    final localItems = List<CartItemModel>.from(cartItems);

    // 2. Merge local + remote (or just upload — your choice)
    await _firebaseService.mergeAndSync(localItems);   // ← from earlier code

    // 3. Load the final (merged) version from Firebase
    final mergedItems = await _firebaseService.fetchCartFromFirebase();

    // 4. Update UI / memory
    cartItems.assignAll(mergedItems);
    
    updateCart();  // recalculates totals, saves locally, and syncs again if needed

    // Optional haptic feedback
    await hapticSuccess();
  } catch (e) {
    debugPrint("Cart sync failed after login: $e");
    // Don't block login — just log it
    // Optionally show a soft warning:
    // ELoaders.warningSnackBar(message: "Couldn't sync cart right now");
  }
}

  // Update saveCartItems to also sync to Firebase if logged in
  void saveCartItems() {
    final cartItemJsons = cartItems.map((item) => item.toJson()).toList();
    ELocalStorage().saveData('CartItems', cartItemJsons);

    // Sync to Firebase if user is logged in
    if (_firebaseService.isAuthenticated) {
      _firebaseService.syncLocalCartToFirebase(cartItems);
    }
  }

  CartController() {
    loadCartItems();
  }

  bool isProductInCart(String productId){
    return cartItems.any((item) => item.productId == productId);
  }

  //add items to cart
  void addToCart(ProductModel product, {int? quantity}) {
    final qty = quantity ?? productQuantityInCart.value;
    //quantity check
    if (qty < 1) {
      Get.snackbar('Error', 'Select quantity');
      return;
    } else {
      final selectedCartItem = convertToCartItem(product, qty);
      int index = cartItems.indexWhere(
          (cartItem) => cartItem.productId == selectedCartItem.productId);

      if (index >= 0) {
        //quantity is already added or updated/removed from the assign cart
        cartItems[index].quantity = selectedCartItem.quantity;
      } else {
        cartItems.add(selectedCartItem);
      }
      updateCart();
      Get.snackbar(
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: EColors.primaryColor,
          'Success',
          'Product Added to Cart');
    }
  }

//add item to cart
  void addItemToCart(CartItemModel item) {
    int index = cartItems
        .indexWhere((cartItem) => cartItem.productId == item.productId);
    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }
    updateCart();
  }

//remove the item from the cart
  void removeItemFromCart(CartItemModel item) {
    int index = cartItems
        .indexWhere((cartItem) => cartItem.productId == item.productId);
    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        cartItems[index].quantity == 1
            ? removeItemFromCartDialog(index)
            : cartItems.removeAt(index);
      }
      updateCart();
    }
  }

  void removeItemFromCartDialog(int index) {
    final dark = EHelperFunctions.isDarkMode(Get.context!);
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are you sure you want to remove this product?.',
      titleStyle:  TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: dark ? EColors.black : EColors.white),
      middleTextStyle: TextStyle(fontSize: 16, color: dark ? EColors.white : EColors.black),
      onConfirm: () {
        cartItems.removeAt(index);
        updateCart();
        Get.back();
        Get.snackbar(
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: EColors.primaryColor,
            'Success',
            'Product Removed from Cart');
      },
      onCancel: () => Get.back(),
    );
  }

  //function to convert the product model to a cartItemmodel
  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    return CartItemModel(
      productId: product.id,
      quantity: quantity,
      title: product.title,
      price: product.price,
      image: product.thumbnail,
      brandName: product.brand != null ? product.brand!.name : '',
    );
  }

  //update cart values
  void updateCart() {
    updateCartTotal();
    saveCartItems();
    cartItems.refresh();
  }

  void updateCartTotal() {
    double calculateTotalPrice = 0.0;
    int calculataNumberOfItems = 0;

    for (var item in cartItems) {
      calculateTotalPrice += (item.price) * item.quantity.toDouble();
      calculataNumberOfItems += item.quantity;
    }
    totalCartPrice.value = calculateTotalPrice;
    numberOfCartItems.value = calculataNumberOfItems;
  }

  // void saveCartItems() {
  //   final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
  //   ELocalStorage().saveData('CartItems', cartItemStrings);
  // }

  void loadCartItems() {
    final cartItemStrings =
        ELocalStorage().readData<List<dynamic>>('CartItems');
    if (cartItemStrings != null) {
      cartItems.assignAll(cartItemStrings
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)));
      updateCartTotal();
    }
  }

  int getProductQuantityInCart(String productId) {
    final foundItem = cartItems
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }

  void updateAlreadyAddedProductCount(ProductModel product) {
    productQuantityInCart.value = getProductQuantityInCart(product.id);
  }

  //Haptic feedback
  Future<void> hapticSuccess() async{
    await HapticFeedback.mediumImpact();
    await Future.delayed(const Duration(microseconds: 50));
    await HapticFeedback.lightImpact();
  }

  Future<void> hapticError() async{
    await HapticFeedback.heavyImpact();
  }

  Future<void> hapticAdd() async{
    await HapticFeedback.selectionClick();
  }

  Future<void> hapticRemove() async{
    await HapticFeedback.vibrate();
  }
}
