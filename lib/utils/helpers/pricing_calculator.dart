import 'package:e_commerce_app/features/personalization/controllers/address_controller.dart' show AddressController;

class PricingCalculator {
  static double calculateTotalPrice(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;

    double shippingCost = getShippingCost(location);

    double totalPrice = productPrice +taxAmount + shippingCost;
    return totalPrice;
  }

  static String calculateShiipingCost(double productPrice, String location) {
    double shippingCost = getShippingCost(location);
    return shippingCost.toStringAsFixed(2);
  }

  static String calculateTax(double productPrice, String location) {
    double taxRate = getTaxRateForLocation(location);
    double taxAmount = productPrice * taxRate;
    return taxAmount.toStringAsFixed(2);
  }

  static getTaxRateForLocation(String location) {
    return 0.10;
  }

  static double getShippingCost(String location) {
        return AddressController.instance.selectedAddress.value.shippingAmount;

  }

  // static double calculateCartTotal(CartModel cart) {
  //   return cart.items.map((e) => e.price).fold(0,
  //       (previousPrice, currentPrice) => previousPrice + (currentPrice ?? 0));}
}
