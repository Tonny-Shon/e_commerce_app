import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/styles.dart';

Widget customTextField(
    {String title = '',
    String? hint,
    controller,
    double? size,
    isObsecure = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title.text.color(EColors.redColor).fontFamily(semibold).size(size).make(),
      5.heightBox,
      TextFormField(
        obscureText: isObsecure,
        controller: controller,
        decoration: InputDecoration(
            hintStyle: const TextStyle(
                fontFamily: semibold, color: EColors.textfieldGrey),
            hintText: hint,
            isDense: true,
            fillColor: EColors.lightGrey,
            filled: true,
            border: InputBorder.none,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: EColors.redColor))),
      ),
      8.heightBox,
    ],
  );
}
