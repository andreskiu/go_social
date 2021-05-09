import 'dart:math';
import 'package:flutter/widgets.dart';
import 'responsivity/device_detector_widget.dart';

class SemiCircleLeftClipper extends CustomClipper<Path> {
  final SizingInformation sizeInformation;
  SemiCircleLeftClipper({
    @required this.sizeInformation,
  });
  @override
  Path getClip(Size size) {
    final _verticalUnit = sizeInformation.blockUnit.height;
    final _horizontalUnit = sizeInformation.blockUnit.width;
    num degToRad(num deg) => deg * (pi / 180.0);
    final center = Offset(-_horizontalUnit * 8, _verticalUnit * 50);
    final rect =
        Rect.fromCircle(center: center, radius: _horizontalUnit * 31.5);
    final path = Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(rect, degToRad(-90), degToRad(180), false);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class SemiCircleDownClipper extends CustomClipper<Path> {
  final SizingInformation sizeInformation;

  SemiCircleDownClipper({
    @required this.sizeInformation,
  });

  @override
  Path getClip(Size size) {
    final _verticalUnit = sizeInformation.blockUnit.height;
    final _horizontalUnit = sizeInformation.blockUnit.width;
    num degToRad(num deg) => deg * (pi / 180.0);
    final center = Offset(_horizontalUnit * 50, -_verticalUnit * 8);
    final rect = Rect.fromCircle(center: center, radius: size.height);
    final path = Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(rect, degToRad(0), degToRad(180), false);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
