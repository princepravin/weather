import 'package:flutter/material.dart';

List countries = [
  'London',
  'Paris',
  'India',
  'Pakistan',
  'China',
  'Nepal',
  'Germany',
  'Australia',
  'Bhutan',
  'Vietnam',
  'Thailand'
];

class Semi extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.moveTo(size.width, 0.0);
    var firstControlPoint1 = Offset(size.width * 0.03, size.height * 0.08);
    var firstEndpoint1 = Offset(0.05, size.height / 2);
    path.quadraticBezierTo(firstControlPoint1.dx, firstControlPoint1.dy,
        firstEndpoint1.dx, firstEndpoint1.dy);

    var secondControlPoint = Offset(size.width * 0.03, size.height * 0.92);
    var secondEndpoint = Offset(size.width, size.height);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndpoint.dx, secondEndpoint.dy);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
