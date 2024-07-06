import 'package:flutter/widgets.dart';

class ECustomCurvedEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    final firstPoint = Offset(0, size.height - 20);
    final lastPoint = Offset(30, size.height - 20);

    path.quadraticBezierTo(
        firstPoint.dx, firstPoint.dy, lastPoint.dx, lastPoint.dy);

    final secondfirstPoint = Offset(0, size.height - 20);
    final secondlastPoint = Offset(size.width - 30, size.height - 20);

    path.quadraticBezierTo(secondfirstPoint.dx, secondfirstPoint.dy,
        secondlastPoint.dx, secondlastPoint.dy);

    final thirdfirstPoint = Offset(size.width, size.height - 20);
    final thirdlastPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(thirdfirstPoint.dx, thirdfirstPoint.dy,
        thirdlastPoint.dx, thirdlastPoint.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
