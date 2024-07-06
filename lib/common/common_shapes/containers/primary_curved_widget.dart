import 'package:e_commerce_app/common/common_shapes/containers/curved_edges.dart';
import 'package:e_commerce_app/common/common_shapes/containers/circular_container.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class EPrimaryCurvedWidget extends StatelessWidget {
  const EPrimaryCurvedWidget({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return EClipPathWidget(
      child: Container(
        color: EColors.redColor,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: ERoundedContainer(
                backgroundColor: EColors.textWhite.withOpacity(0.1),
              ),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: ERoundedContainer(
                backgroundColor: EColors.textWhite.withOpacity(0.1),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
