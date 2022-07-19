import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

/*
MaterialApp(
      home: Scaffold(
        body: CustomPaint(
          painter: PathPainter(),
        ),
      )
 */

/*
GameWidget(
      game: MyGame(),
    ),
 */

/// This example simply adds a rotating white square on the screen.
/// If you press on a square, it will be removed.
/// If you press anywhere else, another square will be added.
class MyGame extends FlameGame with HasTappables {


  @override
  Color backgroundColor(){
    return Colors.red;
  }
  @override
  Future<void> onLoad() async {
    print(size);
  }
  final path2 = Path()..addOval(const Rect.fromLTRB(40, 115, 160, 235));
  @override
  void onTapUp(int pointerId, TapUpInfo info) {
    super.onTapUp(pointerId, info);
    if (!info.handled) {
      final touchPoint = info.eventPosition.game;
      debugPrint(touchPoint.toString());
      add(SquareCircleRotate());
    }
  }

}

class Square extends PositionComponent with Tappable {
  static const speed = 1;
  static const squareSize = 128.0;

  static Paint white = BasicPalette.white.paint();
  static Paint red = BasicPalette.red.paint();
  static Paint blue = BasicPalette.blue.paint();

  Square(Vector2 position) : super(position: position);

  @override
  void render(Canvas c) {
    c.drawRect(size.toRect(), white);
    c.drawRect(const Rect.fromLTWH(0, 0, 20, 128), red);
    c.drawRect(Rect.fromLTWH(width / 2, height / 2, 3, 3), blue);
  }

  @override
  void update(double dt) {
    super.update(dt);
    angle += speed * dt;
    angle %= 2 * math.pi;
  }

  @override
  Future<void> onLoad() async {

    size.setValues(squareSize, squareSize);
    anchor = Anchor.center;
  }

  @override
  bool onTapUp(TapUpInfo info) {
    removeFromParent();
    info.handled = true;
    return true;
  }
}

class SquareCircleRotate extends PositionComponent {
  final countdown = Timer(20);
  @override
  void update(double dt) {
    countdown.update(dt);
    if (countdown.finished) {
      countdown.pause();
      // Prefer the timer callback, but this is better in some cases
    }
  }
  @override
  void onMount() {

    final paint1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..color = Colors.greenAccent;
    final paint3 = Paint()..color = const Color(0xffb372dc);

    // Red square, moving back and forth

    final path2 = Path()..addOval(const Rect.fromLTRB(5, 27, 405, 675));

    add(
        CircleComponent(
            position: path2.getBounds().toVector2().clone(),
            radius: path2.getBounds().left
        ));
    for (var i = 0; i < 16; i++) {
      add(
        RectangleComponent.fromRect(Rect.fromLTRB(10, 20, -10, -20))
          ..paint = (Paint()..color = Colors.tealAccent)
          ..add(
            MoveAlongPathEffect(
              path2,
              EffectController(
                duration: 7,
                startDelay: i * 0.9,
                infinite: true,
              ),
              oriented: true,
            ),
          ),
      );
    }
  }
}
class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;
    Path path = Path()..addOval(const Rect.fromLTRB(5, 27, 405, 675));
    // TODO: do operations here
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}