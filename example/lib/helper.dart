import 'package:flutter/material.dart';

class HelperExample {
  static const SCORE_HEIGHT = 64.0;
  static const SCORE_STROKE = 8.0;

  static void drawScore(Canvas canvas, int score) {
    switch (score) {
      case 0:
        drawZero(canvas);
        break;
      case 1:
        drawOne(canvas);
        break;
      case 2:
        drawTwo(canvas);
        break;
      case 3:
        drawThree(canvas);
        break;
      case 4:
        drawFour(canvas);
        break;
      case 5:
        drawFive(canvas);
        break;
      case 6:
        drawSix(canvas);
        break;
      case 7:
        drawSeven(canvas);
        break;
      case 8:
        drawEight(canvas);
        break;
      case 9:
        drawNine(canvas);
        break;
      default:
        throw Exception('Invalid score, only 0-9 is valid');
    }
  }

  static void drawZero(Canvas canvas) {
    drawTopCenter(canvas);
    drawTopRight(canvas);
    drawBottomRight(canvas);
    drawBottomCenter(canvas);
    drawBottomLeft(canvas);
    drawTopLeft(canvas);
  }

  static void drawOne(Canvas canvas) {
    drawTopRight(canvas);
    drawBottomRight(canvas);
  }

  static void drawTwo(Canvas canvas) {
    drawTopCenter(canvas);
    drawTopRight(canvas);
    drawCenter(canvas);
    drawBottomCenter(canvas);
    drawBottomLeft(canvas);
  }

  static void drawThree(Canvas canvas) {
    drawTopCenter(canvas);
    drawTopRight(canvas);
    drawBottomRight(canvas);
    drawCenter(canvas);
    drawBottomCenter(canvas);
  }

  static void drawFour(Canvas canvas) {
    drawTopRight(canvas);
    drawBottomRight(canvas);
    drawCenter(canvas);
    drawTopLeft(canvas);
  }

  static void drawFive(Canvas canvas) {
    drawTopCenter(canvas);
    drawBottomRight(canvas);
    drawCenter(canvas);
    drawBottomCenter(canvas);
    drawTopLeft(canvas);
  }

  static void drawSix(Canvas canvas) {
    drawTopCenter(canvas);
    drawBottomRight(canvas);
    drawCenter(canvas);
    drawBottomCenter(canvas);
    drawBottomLeft(canvas);
    drawTopLeft(canvas);
  }

  static void drawSeven(Canvas canvas) {
    drawTopCenter(canvas);
    drawTopRight(canvas);
    drawBottomRight(canvas);
  }

  static void drawEight(Canvas canvas) {
    drawTopCenter(canvas);
    drawTopRight(canvas);
    drawBottomRight(canvas);
    drawCenter(canvas);
    drawBottomCenter(canvas);
    drawBottomLeft(canvas);
    drawTopLeft(canvas);
  }

  static void drawNine(Canvas canvas) {
    drawTopCenter(canvas);
    drawTopRight(canvas);
    drawBottomRight(canvas);
    drawCenter(canvas);
    drawBottomCenter(canvas);
    drawTopLeft(canvas);
  }

  static void drawTopCenter(Canvas canvas) => drawLine(canvas, Offset.zero, const Offset(1, 0));
  static void drawTopRight(Canvas canvas) => drawLine(canvas, const Offset(1, 0), const Offset(1, 1));
  static void drawBottomRight(Canvas canvas) => drawLine(canvas, const Offset(1, 1), const Offset(1, 2));
  static void drawCenter(Canvas canvas) => drawLine(canvas, const Offset(0, 1), const Offset(1, 1));
  static void drawBottomCenter(Canvas canvas) => drawLine(canvas, const Offset(0, 2), const Offset(1, 2));
  static void drawBottomLeft(Canvas canvas) => drawLine(canvas, const Offset(0, 1), const Offset(0, 2));
  static void drawTopLeft(Canvas canvas) => drawLine(canvas, Offset.zero, const Offset(0, 1));

  static void drawLine(Canvas canvas, Offset p1, Offset p2) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = SCORE_STROKE;
    Offset stroke;
    if (isHorizontal(p1, p2)) {
      stroke = const Offset(1, 0) * SCORE_STROKE / 2;
    } else {
      stroke = const Offset(0, 1) * SCORE_STROKE / 2;
    }
    canvas.drawLine(p1 * SCORE_HEIGHT / 2 - stroke, p2 * SCORE_HEIGHT / 2 + stroke, paint);
  }

  static bool isHorizontal(Offset p1, Offset p2) {
    return p1.dx < p2.dx;
  }
}
