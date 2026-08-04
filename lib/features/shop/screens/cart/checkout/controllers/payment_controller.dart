import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../../../images/images.dart';
import '../../../../../../utils/popups/loaders.dart';
import '../../../../../authentication/controller/user_controller.dart';

import '../../../../models/payment_method_model.dart';
import '../controllers/order_controller.dart';
import '../widgets/payment_web_view.dart';

class PaymentController extends GetxController {
  // final PesapalService pesapal = PesapalService();
  final OrderController orderController = Get.put(OrderController());
  final UserController userController = Get.put(UserController()); // ← Use this

  final RxBool isProcessing = false.obs;
  // final RxString phoneNumber = ''.obs;
  var network =
      PaymentMethodModel(id: 'mtn', name: 'MTN MoMo', image: EImages.mtn).obs;
  final RxString phoneError = ''.obs;
  var errorMessage = ''.obs;

  final phoneController = TextEditingController();

  String? orderTrackingId;

  @override
  void onInit() {
    super.onInit();
    // Pre-fill from logged-in user's saved phone (with fallback)
    phoneController.text = userController.user.value.phoneNumber;
  }

  bool validatePhone() {
    String phone =
        phoneController.text.trim().replaceAll(RegExp(r'[^0-9]'), '');

    if (phone.isEmpty) {
      phoneError.value = 'Phone number is required';
      return false;
    }

    if (phone.startsWith('0')) phone = phone.substring(1);
    if (phone.startsWith('256')) phone = phone.substring(3);

    if (phone.length != 9) {
      phoneError.value =
          'Invalid Ugandan number (should be 9 digits after 256)';
      return false;
    }

    // Reconstruct full international format
    phoneController.text = '256$phone'; // store full 256...
    phoneError.value = '';
    return true;
  }

  Future<void> startPayment(double totalAmount) async {
    if (isProcessing.value) return;

    isProcessing.value = true;
    errorMessage.value = '';

    try {
      final response = await http.post(
        Uri.parse('https://pesapal-service-meww.onrender.com/api/pay'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "amount": totalAmount,
          "phone": userController.user.value.phoneNumber,
          "email": userController.user.value.email,
          "username": userController.user.value.username,
          "description":
              "Order Payment - ${totalAmount.toStringAsFixed(0)} UGX",
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final redirectUrl = data['redirect_url'] as String?;
        final trackingId = data['order_tracking_id'] as String?;


        if (redirectUrl != null && redirectUrl.isNotEmpty) {
          Get.to(() => PaymentWebViewScreen(
                redirectUrl: redirectUrl,
                trackingId: trackingId,
                totalAmount: totalAmount,
              ));
        } else {
          throw Exception(
              "No redirect_url received. Full response: ${response.body}");
        }
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['error']?['message'] ?? "Unknown error");
      }
    } catch (e) {
      errorMessage.value = e.toString();
      ELoaders.erroSnackBar(title: 'Payment Failed', message: e.toString());
    } finally {
      isProcessing.value = false;
    }
  }
}
