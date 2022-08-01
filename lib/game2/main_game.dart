import 'dart:math';
import 'package:flame/effects.dart';
import 'package:flame/experimental.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:game_example/game2/components/rotate_ring.dart';
import 'package:game_example/game2/components/shapes.dart';
import 'package:game_example/game2/components/stick.dart';
import 'package:game_example/main_examp/revoluate_examp/body_components/draggable_body.dart';
import 'package:game_example/main_examp/revoluate_examp/uitls/balls.dart';
import 'package:game_example/main_examp/revoluate_examp/uitls/boundaries.dart';
import 'package:game_example/main_examp/revoluate_examp/uitls/rectangle.dart';
import 'package:game_example/main_examp/revoluate_examp/zoom_slider.dart';


class StabbingGame<T extends FlameGame> extends Forge2DGame with HasDraggables,HasTappables {
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
    final shapes = [

      RoundedRectangle.fromLTRBR(0.4, 3, 1.2, 5.5, 0.3),
    ];
    const colors = [
      Color(0xFFFFFF88),
    ];
    final boundaries = createBoundaries(this);
    boundaries.forEach(add);
    final center = screenToWorld(camera.viewport.effectiveSize/2);
    final vector1=Vector2(39.27272727272728/2,70);
    final vector2=Vector2(39.27272727272728/2,-10);
    //add(CircleShuffler(vector2));
    add(Player());
    add(StickComp(vector1));
  }

  @override
  void update(double dt) {
    print(camera.gameSize);
    super.update(dt);
    camera.zoom = zoomValue;
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
