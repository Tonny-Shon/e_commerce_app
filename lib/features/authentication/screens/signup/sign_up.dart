import 'package:e_commerce_app/features/authentication/controller/signup/signup_controller.dart';
import 'package:e_commerce_app/features/authentication/screens/signup/widgets/terms_conditions.dart';
import 'package:e_commerce_app/utils/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../common/widgets/bg_widget.dart';
import '../../../../common/widgets/our_button.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/strings.dart';
import '../../../../utils/constants/texts.dart';
import '../login/login.dart';
import 'widgets/signin_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final controller = Get.put(SignupController());
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Stack(children: [
        Container(
            width: MediaQuery.of(context).size.height / 2,
            decoration: const BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // (context.screenHeight * 0.1).heightBox,
                      //applogoWidget(),

                      "Sign Up to ${ETexts.appname2}"
                          .text
                          .fontFamily('${FontWeight.bold}')
                          .color(EColors.redColor)
                          .size(18)
                          .make(),
                      10.heightBox,
                      Column(
                        children: [
                          const ESignInForm(),
                          const ETermsAndConditionsCheckBox(),
                          8.heightBox,
                          Obx(
                            () => ourButton(
                                    onPress: () => controller.signupuser()
                                    //Get.to(() => const VerifyEmailScreen())
                                    ,
                                    color: !controller.privacyPolicy.value
                                        ? EColors.lightGrey
                                        : EColors.redColor,
                                    textColor: EColors.whiteColor,
                                    title: ETexts.signup,
                                    size: 17)
                                .box
                                .width(context.screenWidth - 50)
                                .make(),
                          ),
                          10.heightBox,
                          InkWell(
                            onTap: () => Get.to(() => const LoginScreen()),
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: alreadyHaveAnAccount,
                                    style: TextStyle(
                                        fontFamily: bold, color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: ETexts.login,
                                    style: TextStyle(
                                        fontFamily: bold,
                                        color: EColors.redColor,
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                          .box
                          .white
                          .rounded
                          .padding(const EdgeInsets.all(16))
                          .width(context.screenWidth - 70)
                          .shadowSm
                          .make(),
                    ],
                  ),
                ),
              ),
            )),
      ]),
    );
  }
}
