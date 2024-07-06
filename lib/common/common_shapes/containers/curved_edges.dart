import 'package:e_commerce_app/common/common_shapes/containers/curved_container.dart';
import 'package:flutter/material.dart';

class EClipPathWidget extends StatelessWidget {
  const EClipPathWidget({
    super.key,
    this.child,
  });
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ECustomCurvedEdges(),
      child: child,
    );
  }
}
