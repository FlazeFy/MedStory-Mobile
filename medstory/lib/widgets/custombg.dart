//Custom bg for forum
import 'package:flutter/material.dart';

class CurvedPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = 15;

    var path = Path();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, size.width, size.height));
    paint.color = const Color(0xFF4183D7);
    canvas.drawPath(mainBackground, paint);

    path.moveTo(0, size.height * 0.2);
    path.quadraticBezierTo(size.width * 0.12, size.height * 0.38,
        size.width * 0.5, size.height * 0.38);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.38,
        size.width * 1.0, size.height * 0.38);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    paint.color = Colors.white;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CurvedPainter3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = 15;

    var path = Path();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, size.width, size.height));
    paint.color = const Color(0xFF4183D7);
    canvas.drawPath(mainBackground, paint);
    //Not finished.

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

//Custom bg for login
class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = 15;

    var path = Path();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, size.width, size.height));
    paint.color = const Color(0xFF4183D7);
    canvas.drawPath(mainBackground, paint);

    path.moveTo(0, size.height * 0.3);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.52,
        size.width * 0.5, size.height * 0.535);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.535,
        size.width * 1.0, size.height * 0.535);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    paint.color = const Color(0xFF22A7F0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class WhitePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.white;
    canvas.drawPath(mainBackground, paint);

    Path ovalPath = Path();
    ovalPath.lineTo(0, 120);

    ovalPath.quadraticBezierTo(
        width *0.55, height*0.37, width *0.7, height*0.36);

    ovalPath.quadraticBezierTo(width *0.8, height*0.36, width*0.88, height*0.34);

    ovalPath.lineTo(width*2, 0);

    ovalPath.close();

    paint.color = const Color(0xFF4183D7);
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}