import 'package:flutter/material.dart';

import '../../images/images.dart';

Widget bgWidget({Widget? child}) {
  return Container(
    decoration: const BoxDecoration(
      image:
          DecorationImage(image: AssetImage(EImages.bgImage), fit: BoxFit.fill),
    ),
    child: child,
  );
}
