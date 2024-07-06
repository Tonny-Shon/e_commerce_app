import 'package:e_commerce_app/common/widgets/applogo_widget.dart';
import 'package:e_commerce_app/images/images.dart';
import 'package:e_commerce_app/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'Splash Screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //creating a method to change the screen
  @override
  void initState() {
    super.initState();
    // Timer(
    //   const Duration(seconds: 3),
    //   () => Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) {},
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Image(
                image: AssetImage(
              EImages.icSplashBg,
            )),
          ),
          20.heightBox,
          applogoWidget(),
          10.heightBox,
          ETexts.appname.text
              .fontFamily('${FontWeight.bold}')
              .size(22)
              .white
              .make(),
          5.heightBox,
          ETexts.appname1.text
              .fontFamily('${FontWeight.bold}')
              .size(30)
              .white
              .make(),
          const Spacer(),
          ETexts.credits.text.white.fontFamily('${FontWeight.w500}').make(),
          30.heightBox,
        ]),
      ),
    );
  }
}
