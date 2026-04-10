import 'package:get/get.dart';

import '../widgets/payment_response.dart';

enum PaymentState {idle, laoding, ready, verifying, success, failed}

class PaymentController2 extends GetxController {
  final _payment = Rxn<PaymentResponse>();
  final _state = PaymentState.idle.obs;

  //Getters to access the values
  PaymentResponse? get payment => _payment.value; 
  PaymentState get state => _state.value;

  Future<void> startPayment(double amount) async {
    _state.value = PaymentState.laoding;
    try {
      // Simulate payment processing
      await Future.delayed(const Duration(seconds: 2));
      _payment.value = PaymentResponse(
         redirectUrl: '', orderTrackingId: '',
      );
      _state.value = PaymentState.ready;
    } catch (e) {
      _state.value = PaymentState.failed;
    }
  }
}