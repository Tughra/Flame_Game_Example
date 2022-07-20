import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class Mage extends BodyComponent {
  final Vector2 position;
  final Vector2 size;

  Mage(
      this.position, {
        Vector2? size,
      }) : size = size ?? Vector2(2, 3);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final animation = await gameRef.loadSpriteAnimation(
      'death.png',
      SpriteAnimationData.sequenced(
        amount: 7,
        stepTime: 0.1,
        amountPerRow: 7,loop: false,
        textureSize: Vector2.all(250),
      ),
    );
    add(
      SpriteAnimationComponent(
        animation: animation,
        size: size,
        anchor: const Anchor(0.5,0.55),
      ),
    );
  }

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBoxXY(size.y/20,size.x/10);
    paint=Paint()..color=Colors.transparent;
   /*
    final vertices = [
      Vector2(-size.x / 20, size.y / 20),
      Vector2(size.x / 20, size.y / 20),
      Vector2(20, -size.y / 20),
    ];
    shape.set(vertices);
    */

    final fixtureDef = FixtureDef(
      shape,
      userData: this, // To be able to determine object in collision
      restitution: 0.4,
      density: 1.0,
      friction: 0.5,
    );

    final bodyDef = BodyDef(
      position: position,
      angle: (position.x + position.y) / 2 * pi,
      type: BodyType.dynamic,
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}