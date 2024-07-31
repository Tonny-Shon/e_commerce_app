import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/images/images.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/payment_method_model.dart';
import '../widgets/payment_tile.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  Rx<PaymentMethodModel> selectedPayemtMethod = PaymentMethodModel.empty().obs;
  @override
  void onInit() {
    super.onInit();
    selectedPayemtMethod.value =
        PaymentMethodModel(name: 'Airtel', image: EImages.airtel);
  }

  Future<dynamic> selectPaymentMethods(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(ESizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ESectionHeading(
                title: 'Select Payment Method',
                showActionButton: false,
              ),
              const SizedBox(
                height: ESizes.spaceBtnItems,
              ),
              PaymentTile(
                paymentMethod:
                    PaymentMethodModel(image: EImages.airtel, name: 'Airtel'),
              ),
              const SizedBox(
                height: ESizes.spaceBtnItems,
              ),
              PaymentTile(
                paymentMethod:
                    PaymentMethodModel(image: EImages.mtn, name: 'MTN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
