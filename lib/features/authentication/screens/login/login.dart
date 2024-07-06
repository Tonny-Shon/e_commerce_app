import 'package:e_commerce_app/features/authentication/screens/login/widgets/form_divider.dart';
import 'package:e_commerce_app/features/authentication/screens/login/widgets/login_form.dart';
import 'package:e_commerce_app/features/authentication/screens/login/widgets/social_buttons.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../common/widgets/applogo_widget.dart';
import '../../../../common/widgets/bg_widget.dart';
import '../../../../utils/constants/texts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    //final dark = EHelperFunctions.isDarkMode(context);
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Log in to ${ETexts.appname2}"
                .text
                .fontFamily('${FontWeight.bold}')
                .black
                .size(17)
                .make(),
            10.heightBox,
            Column(
              children: [
                const ELoginForm(),
                const EFormDivider(dividerText: ETexts.signInWith),
                5.heightBox,
                const ESocialButtons(),
                5.heightBox,
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
    ));
  }
}
