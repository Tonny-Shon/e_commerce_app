// payment_screen.dart
import 'package:e_commerce_app/images/images.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/payment_method_model.dart';
import 'controllers/payment_controller.dart';

class PaymentScreen extends StatelessWidget {
  final double totalAmount;
  // final String? selectedNetwork;

  const PaymentScreen({
    super.key,
    required this.totalAmount,
    // this.selectedNetwork,
  });
  

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentController());
    final dark = EHelperFunctions.isDarkMode(context);


    final methods = [
      PaymentMethodModel(
        id: 'mtn',
        name: 'MTN MoMo',
        image: EImages.mtn,
      ),
      PaymentMethodModel(
        id: 'airtel',
        name: 'Airtel Money',
        image: EImages.airtel,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: dark ? EColors.whiteColor : EColors.black,
            )),
        title: Text(
          'Complete Payment',
          style: TextStyle(color: dark ? EColors.white : EColors.black),
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TITLE
              Text(
                "Payment Details",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: dark ? EColors.whiteColor : EColors.black),
              ),

              const SizedBox(height: 20),

              /// AMOUNT
              TextFormField(
                initialValue: totalAmount.toStringAsFixed(0),
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Amount (UGX)',
                  floatingLabelStyle: TextStyle(
                      color: dark ? EColors.whiteColor : EColors.black),
                  labelStyle: TextStyle(
                      color: dark ? EColors.whiteColor : EColors.black),
                  border: const OutlineInputBorder(),
                ),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: dark ? EColors.whiteColor : EColors.black),
              ),

              const SizedBox(height: 24),

              /// PAYMENT METHOD
              Text(
                "Select Payment Method",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: dark ? EColors.whiteColor : EColors.black),
              ),

              const SizedBox(height: 12),

              Row(
                children: methods.map((method) {
                  final isSelected = controller.network.value == method;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () => controller.network.value = method,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                          color: isSelected
                              ? Theme.of(context)
                                  .primaryColor
                                  .withValues(alpha: 0.08)
                              : Colors.white,
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withValues(alpha: 0.2),
                                    blurRadius: 10,
                                  )
                                ]
                              : [],
                        ),
                        child: Column(
                          children: [
                            AnimatedScale(
                              duration: const Duration(milliseconds: 200),
                              scale: isSelected ? 1.1 : 1.0,
                              child: Image.asset(
                                method.image,
                                height: 40,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              method.name,
                              style: TextStyle(
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: dark
                                      ? EColors.whiteColor
                                      : EColors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              /// PHONE NUMBER
              TextField(
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
                style:
                    TextStyle(color: dark ? EColors.whiteColor : EColors.black),
                onChanged: (val) {
                  String number = val.trim();

                  if (number.startsWith('0')) number = number.substring(1);
                  if (number.startsWith('256')) number = number.substring(3);

                  // controller.phoneController.text = val;

                  // ONLY update the network observable, DON'T update phoneController.text
                  if (number.startsWith('77') ||
                      number.startsWith('78') ||
                      number.startsWith('76')) {
                    controller.network.value = methods[0]; // MTN
                  } else if (number.startsWith('75') ||
                      number.startsWith('70') ||
                      number.startsWith('74')) {
                    controller.network.value = methods[1]; // Airtel
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  fillColor: EColors.black,
                  focusColor: EColors.black,
                  floatingLabelStyle: TextStyle(
                      color: dark ? EColors.whiteColor : EColors.black),
                  labelStyle: TextStyle(
                      color: dark ? EColors.whiteColor : EColors.black),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: EColors.primaryColor)),
                  // prefixIcon: Container(
                  //   alignment: Alignment.center,
                  //   width: 80,
                  //   child: Text(
                  //     '+256',
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         color: dark ? EColors.whiteColor : EColors.black),
                  //   ),
                  // ),
                ),
              ),

              const SizedBox(height: 16),

              /// PAY BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: controller.isProcessing.value
                      ? null
                      : () => controller.startPayment(totalAmount),
                  style: ElevatedButton.styleFrom(
                    side: BorderSide.none,
                    backgroundColor: EColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: controller.isProcessing.value
                      ? SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: dark ? Colors.white : EColors.black,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.lock),
                            const SizedBox(width: 10),
                            Text(
                              'Pay UGX ${totalAmount.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                ),
              ),

              /// ERROR MESSAGE
              if (controller.errorMessage.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  controller.errorMessage.value,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
