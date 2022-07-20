import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'animated_components/animated_body.dart';
import 'animated_components/animated_component_one.dart';

class CollidableAnimationExample extends FlameGame with HasCollisionDetection {
  static const description = '''
    In this example you can see four animated birds which are flying straight
    along the same route until they hit either another bird or the wall, which
    makes them turn. The birds have PolygonHitboxes which are marked with the
    white lines.
  ''';

  @override
  Future<void> onLoad() async {
    add(ScreenHitbox());
    final componentSize = Vector2(600, 600);
    // Top left component
    add(
      AnimatedComponent(Vector2.all(200), camera.gameSize/2, componentSize),
    );

    // Bottom right component

  }
}
