import 'dart:math';
import 'package:flame/effects.dart';
import 'package:flame/experimental.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:game_example/main_examp/revoluate_examp/uitls/balls.dart';
import 'package:game_example/main_examp/revoluate_examp/uitls/boundaries.dart';
import 'package:game_example/main_examp/revoluate_examp/uitls/rectangle.dart';
import 'package:game_example/main_examp/revoluate_examp/zoom_slider.dart';

import 'body_components/draggable_body.dart';

class RevoluteJointExample<T extends FlameGame> extends Forge2DGame with TapDetector, HasDraggables {
  final pauseOverlayIdentifier = 'zoomWidget';
  double zoomValue=10.0;
  static const String description = '''
    This example showcases a revolute joint, which is the spinning balls in the
    center.
    
    If you tap the screen some colourful balls are added and will
    interact with the bodies tied to the revolute joint once they have fallen
    down the funnel.
  ''';
  @override
  Color backgroundColor() =>  Colors.teal;
  @override
  Future<void> onLoad() async {
    final boundaries = createBoundaries(this);
    boundaries.forEach(add);
    final center = screenToWorld(camera.viewport.effectiveSize/2);
    final vector1=Vector2(22,63);
    final vector2=Vector2(21,5);
   // add(CircleShuffler(center));
    add(FrictionBody(vector1));
    add(FrictionBody(vector2));
    /*
      await  add(FrictionBody(Vector2(22,63)));
  await  add(FrictionBody(Vector2(21,5)));
     */
    add(RectangleRamp(center, isMirrored: true));
    add(RectangleRamp(center));
   // add(SquareCircleRotate(center));
  //  overlays.add(pauseOverlayIdentifier);
    List.generate(1, (i) {
      final randomVector = (Vector2.random() - Vector2.all(-0.5)).normalized();
      add(Ball(center, radius: 1.4));
    });
  }

  @override
  void update(double dt) {
    super.update(dt);
    camera.zoom = zoomValue;
  }
  @override
  void onTapDown(TapDownInfo details) {
    super.onTapDown(details);
    final tapPosition = details.eventPosition.game;
    //final random = Random(); random.nextDouble;

    /*
    List.generate(1, (i) {
      final randomVector = (Vector2.random() - Vector2.all(-0.5)).normalized();
      add(Ball(tapPosition + randomVector, radius: 1.4));
    });
     */

  }
}

class CircleShuffler extends BodyComponent {
  CircleShuffler(this._center);

  final Vector2 _center;

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      type: BodyType.dynamic,
      position: _center + Vector2(0.0,0.0),
    );
    const numPieces = 4;
    const radius = 10.0;
    final body = world.createBody(bodyDef);

    /*
       final shape = PolygonShape()..setAsBoxXY(0.125, 2.0);
    final fixtureDef = FixtureDef(
      shape,
      density: 25.0,
      restitution: 0.4,
      friction: 0.5,
    );

    final bodyDef = BodyDef(type: BodyType.dynamic, position: position);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
     */
    for (var i = 0; i < numPieces; i++) {
      final xPos = radius * cos(2 * pi * (i / numPieces));
      final yPos = radius * sin(2 * pi * (i / numPieces));
      debugPrint("$xPos---$yPos");

      final shape2 = PolygonShape()..setAsBox(0.5, 2.0, Vector2(10, 14),0);



      final shape = CircleShape()
        ..radius = 1.2
        ..position.setValues(xPos, yPos);


      final fixtureDef = FixtureDef(
        shape2,
        density: 50.0,
        friction: .1,
        restitution: .9,
      );
      final fixtureDef2 = FixtureDef(
        shape,
        density: 50.0,
        friction: .1,
        restitution: .9,
      );

      body.createFixture(fixtureDef);
      body.createFixture(fixtureDef2);
    }
    // Create an empty ground body.
    final groundBody = world.createBody(BodyDef());
    debugPrint(body.position.toString());
    final revoluteJointDef = RevoluteJointDef()
      ..initialize(body, groundBody, body.position)
      ..motorSpeed = pi
      ..maxMotorTorque = 1000000.0
      ..enableMotor = true;


    world.createJoint(RevoluteJoint(revoluteJointDef));
    return body;
  }
}

class CornerRamp extends BodyComponent {
  CornerRamp(this._center, {this.isMirrored = false});

  final bool isMirrored;
  final Vector2 _center;

  @override
  Body createBody() {
    final shape = ChainShape();
    final mirrorFactor = isMirrored ? -1 : 1;
    final diff = 3.0 * mirrorFactor;
    final vertices = [
Vector2(-1, 4),
Vector2(1, 4),
Vector2(1, -4),
Vector2(-1, -4),
    ];
    shape.createLoop(vertices);

    final fixtureDef = FixtureDef(shape, friction: 0.1);
    final bodyDef = BodyDef()
      ..position = _center
      ..type = BodyType.static;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
class RectangleRamp extends BodyComponent {
  RectangleRamp(this._center, {this.isMirrored = false});

  final bool isMirrored;
  final Vector2 _center;

  @override
  Body createBody() {
    final shape = ChainShape();
    final mirrorFactor = isMirrored ? -1 : 1;
    final diff = 2.0 * mirrorFactor;
    final vertices = [
      Vector2(diff, 0),
      Vector2(diff + 10.0 * mirrorFactor, -10.0),
      Vector2(diff + 15.0 * mirrorFactor, -10.0),
    ];
    shape.createLoop(vertices);

    final fixtureDef = FixtureDef(shape, friction: 0.1);
    final bodyDef = BodyDef()
      ..position = _center
      ..type = BodyType.static;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

  class SquareCircleRotate extends BodyComponent {
  SquareCircleRotate(this._center);
  final Vector2 _center;

  @override
  Body createBody() {


    final groundBody = world.createBody(BodyDef());

    final revoluteJointDef = RevoluteJointDef()
      ..initialize(body, groundBody, body.position)
      ..motorSpeed = pi
      ..maxMotorTorque = 1000000.0
      ..enableMotor = true;

    world.createJoint(RevoluteJoint(revoluteJointDef));
    final path2 = Path()..addOval(Rect.fromCenter(center: _center.toOffset(), width: 30, height: 30));
    for (var i = 0; i < 6; i++) {
      add(
        DominoBrick(_center)
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
    return body;
  }
}
