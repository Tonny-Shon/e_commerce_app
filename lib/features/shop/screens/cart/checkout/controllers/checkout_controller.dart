import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/images/images.dart' show EImages;
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../models/payment_method_model.dart';
import '../widgets/payment_tile.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  Rx<PaymentMethodModel> selectedPayemtMethod = PaymentMethodModel.empty().obs;
  @override
  void onInit() {
    super.onInit();
    selectedPayemtMethod.value =
        PaymentMethodModel(name: 'Airtel', image: EImages.airtel, id: 'airtel');
  }

  Future<dynamic> selectPaymentMethods(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return showModalBottomSheet(
      backgroundColor: dark ? EColors.white : EColors.white,
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(ESizes.lg),
          color: dark ? EColors.black : EColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               ESectionHeading(
                title: 'Select Payment Method',
                showActionButton: false,
                textColor: dark ? EColors.white : EColors.black,
              ),
              const SizedBox(
                height: ESizes.spaceBtnItems,
              ),
              PaymentTile(
                paymentMethod:
                    PaymentMethodModel(image: EImages.airtel, name: 'Airtel Money', id: 'airtel'),
              ),
              const SizedBox(
                height: ESizes.spaceBtnItems,
              ),
              PaymentTile(
                paymentMethod:
                    PaymentMethodModel(image: EImages.mtn, name: 'MTN MoMo', id: 'mtn'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
