import 'dart:math';
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';

class AnimatedComponent extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef {
  final Vector2 velocity;

  AnimatedComponent(
      this.velocity,
      Vector2 position,
      Vector2 size, {
        double angle = 0,
      }) : super(
    position: position,
    size: size,
    angle: angle,
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {
    animation = await gameRef.loadSpriteAnimation(
      'death.png',
      SpriteAnimationData.sequenced(
        amount: 7,
        stepTime: 0.1,
        textureSize: Vector2.all(250),
      ),
    );
   /*
    final hitboxPaint = BasicPalette.white.paint()
      ..style = PaintingStyle.stroke;
    add(
      PolygonHitbox.relative(
        [
          Vector2(0.0, -1.0),
          Vector2(-1.0, -0.1),
          Vector2(-0.2, 0.4),
          Vector2(0.2, 0.4),
          Vector2(1.0, -0.1),
        ],
        parentSize: size,
      )
        ..paint = hitboxPaint
        ..renderShape = true,
    );
    */
  }

  @override
  void update(double dt) {
    super.update(dt);
  //  position += velocity * dt;
  }

  final Paint hitboxPaint = BasicPalette.green.paint()
    ..style = PaintingStyle.stroke;
  final Paint dotPaint = BasicPalette.red.paint()..style = PaintingStyle.stroke;

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints,
      PositionComponent other,
      ) {
    super.onCollisionStart(intersectionPoints, other);
    velocity.negate();
    flipVertically();
  }
}