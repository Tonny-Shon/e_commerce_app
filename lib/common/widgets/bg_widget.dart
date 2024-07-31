import 'package:flutter/material.dart';
import '../../images/images.dart';

Widget bgWidget({required Widget child}) {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
          image: AssetImage(EImages.bgImage), fit: BoxFit.cover),
    ),
    child: child,
  );
}
