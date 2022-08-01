import 'dart:math';
import 'package:flame_forge2d/flame_forge2d.dart';

class CircleShuffler extends BodyComponent {
  CircleShuffler(this._center);

  final Vector2 _center;

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      type: BodyType.dynamic,
      position: _center + Vector2(0.0, 25.0),
    );
    const numPieces = 1;
    const radius = 6.0;
    final body = world.createBody(bodyDef);


      final shape = ChainShape();
      shape.createLoop([Vector2(0, 10),
        Vector2(10, 0),
        Vector2(20, -10),
      ]);
      shape.radius=40;

      final fixtureDef = FixtureDef(
        shape,
        density: 50.0,
        friction: .1,
        restitution: .9,
      );

      body.createFixture(fixtureDef);
    // Create an empty ground body.
    final groundBody = world.createBody(BodyDef());

    final revoluteJointDef = RevoluteJointDef()
      ..initialize(body, groundBody, body.position)
      ..motorSpeed = pi
      ..maxMotorTorque = 1000000.0
      ..enableMotor = true;

    world.createJoint(RevoluteJoint(revoluteJointDef));
    return body;
  }
}
