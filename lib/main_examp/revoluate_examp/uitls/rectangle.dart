

import 'package:flame_forge2d/flame_forge2d.dart';

class DominoBrick extends BodyComponent {
  final Vector2 position;

  DominoBrick(this.position);

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBoxXY(0.125, 2.0);
    final fixtureDef = FixtureDef(
      shape,
      density: 25.0,
      restitution: 0.4,
      friction: 0.5,
    );

    final bodyDef = BodyDef(type: BodyType.dynamic, position: position);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}