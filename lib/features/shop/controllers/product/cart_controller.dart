import 'package:e_commerce_app/features/shop/models/cart_item_model.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/utils/local_storage/storage_utility.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  RxInt numberOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  //final variationController = VariationController.instance;

  CartController() {
    loadCartItems();
  }

  //add items to cart
  void addToCart(ProductModel product) {
    //quantity check
    if (productQuantityInCart.value < 1) {
      ELoaders.customToast(message: 'Select Quantity');
      return;
    } else {
      // if (product.stock < 1) {
      //   ELoaders.warningSnackBar(
      //       message: 'Selected Product is out of stock.',
      //       title: 'Product out of stock');
      //   return;
      // }
      //convert the productModel to a cartItemModel with the given quantity
      final selectedCartItem =
          convertToCartItem(product, productQuantityInCart.value);
      int index = cartItems.indexWhere(
          (cartItem) => cartItem.productId == selectedCartItem.productId);

      if (index >= 0) {
        //quantity is already added or updated/removed from the assign cart
        cartItems[index].quantity = selectedCartItem.quantity;
      } else {
        cartItems.add(selectedCartItem);
      }
      updateCart();
      ELoaders.customToast(
        message: 'Product added to cart.',
      );
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
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are you sure you want to remove this product?.',
      onConfirm: () {
        cartItems.removeAt(index);
        updateCart();
        ELoaders.customToast(message: 'Product removed from cart');
        Get.back();
      },
      onCancel: () => Get.back(),
    );
  }

  //function to convert the product model to a cartitemmodel
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

  void saveCartItems() {
    final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
    ELocalStorage.instance().saveData('CartItems', cartItemStrings);
  }

  void loadCartItems() {
    final cartItemStrings =
        ELocalStorage.instance().readData<List<dynamic>>('CartItems');
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
}
