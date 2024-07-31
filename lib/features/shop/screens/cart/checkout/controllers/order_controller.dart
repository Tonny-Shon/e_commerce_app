import 'package:e_commerce_app/common/widgets/success_screen/success_screen.dart';
import 'package:e_commerce_app/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce_app/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce_app/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce_app/features/shop/screens/cart/checkout/controllers/checkout_controller.dart';
import 'package:e_commerce_app/images/images.dart';
import 'package:e_commerce_app/navigation_menu.dart';
import 'package:e_commerce_app/utils/constants/enums.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../data/repositories/order_repository/order_repository.dart';
import '../../../../models/order_model.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  //Fetch User's orders
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      ELoaders.erroSnackBar(title: 'Ooops', message: e.toString());
      return [];
    }
  }

  //Methods for order processing
  void processOrder(double totalAmout) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        return;
      }
      final order = OrderModel(
          id: UniqueKey().toString(),
          userId: userId,
          status: OrderStatus.processing,
          paymentMethod: checkoutController.selectedPayemtMethod.value.name,
          address: addressController.selectedAddress.value,
          deliveryDate: DateTime.now(),
          items: cartController.cartItems.toList(),
          totalAmout: totalAmout,
          orderDate: DateTime.now());

      //save the order
      await orderRepository.saveOrder(order);

      //update the cart
      cartController.clearCart();

      Get.off(
        () => SuccessScreen(
            onPressed: () => Get.offAll(() => const NavigationMenu()),
            image: EImages.icJewelry,
            title: 'Payment successful',
            subTitle: 'Your products will be delivered soon'),
      );
    } catch (e) {
      ELoaders.erroSnackBar(title: 'Oooooops', message: e.toString());
    }
  }
}
