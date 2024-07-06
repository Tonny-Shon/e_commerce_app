import 'package:e_commerce_app/features/authentication/controller/signup/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../../common/consts/strings.dart';
import '../../../../../common/consts/styles.dart';
import '../../../../../utils/constants/colors.dart';

class ETermsAndConditionsCheckBox extends StatelessWidget {
  const ETermsAndConditionsCheckBox({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    //final dark = EHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        Obx(
          () => Checkbox(
            checkColor: EColors.redColor,
            value: controller.privacyPolicy.value,
            onChanged: (value) => controller.privacyPolicy.value =
                !controller.privacyPolicy.value,
          ),
        ),
        10.widthBox,
        Expanded(
          child: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: "I agree to the ",
                  style: TextStyle(fontFamily: regular, color: Colors.black),
                ),
                TextSpan(
                  text: termsAndConditions,
                  style:
                      TextStyle(fontFamily: regular, color: EColors.redColor),
                ),
                TextSpan(
                  text: " & ",
                  style:
                      TextStyle(fontFamily: regular, color: EColors.fontGrey),
                ),
                TextSpan(
                  text: privacyPolicy,
                  style:
                      TextStyle(fontFamily: regular, color: EColors.redColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
