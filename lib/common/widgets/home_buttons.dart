import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/styles.dart';

Widget homeButtons({width, height, icon, String? title, onPress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icon,
        width: 26,
      ),
      10.heightBox,
      title!.text.fontFamily(semibold).color(EColors.darkFontGrey).make(),
    ],
  ).box.rounded.white.size(width, height).shadowSm.make();
}
