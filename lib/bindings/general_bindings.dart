import 'package:e_commerce_app/features/authentication/controller/network_manager/network_manager.dart';
import 'package:e_commerce_app/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce_app/features/shop/screens/cart/checkout/controllers/checkout_controller.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(AddressController());
    Get.put(CheckoutController());
  }
}
