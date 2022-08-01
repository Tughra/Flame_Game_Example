import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';


class PlayerCustomPainter extends CustomPainter {
  late final facePaint = Paint()..color = Colors.yellow;

  late final eyesPaint = Paint()..color = Colors.black;

  @override
  void paint(Canvas canvas, Size size) {
    final faceRadius = size.height / 2;

    canvas.drawCircle(
      Offset(
        faceRadius,
        faceRadius,
      ),
      faceRadius,
      facePaint,
    );

    final eyeSize = faceRadius * 0.15;

    canvas.drawCircle(
      Offset(
        faceRadius - (eyeSize * 2),
        faceRadius - eyeSize,
      ),
      eyeSize,
      eyesPaint,
    );

    canvas.drawCircle(
      Offset(
        faceRadius + (eyeSize * 2),
        faceRadius - eyeSize,
      ),
      eyeSize,
      eyesPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class Player extends CustomPainterComponent
    with HasGameRef<FlameGame> {
  static const speed = 10;

  int direction = 1;

  @override
  Future<void> onLoad() async {
    painter = PlayerCustomPainter();
    size = Vector2.all(5);
    y = 30;
  }

  @override
  void update(double dt) {
    super.update(dt);

    x += speed * direction * dt;

    if ((x + width >= gameRef.size.x && direction > 0) ||
        (x <= 0 && direction < 0)) {
      direction *= -1;
    }
  }
}