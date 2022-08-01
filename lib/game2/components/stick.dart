import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class StickComp extends BodyComponent with Tappable{
  final Vector2 positiond;

  StickComp(this.positiond);

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBox(1, 4.0,Vector2(0, 0),0);
    final fixtureDef = FixtureDef(
      shape,
      density: 1.0,
      restitution: 0.2,
      friction: 0,
    );
    final bodyDef = BodyDef(type: BodyType.dynamic, position: positiond);//initial position
    bodyDef.gravityOverride=Vector2(0, 0);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void>onLoad()async{
    super.onLoad();
  }
  @override
  bool onTapDown(info) {
    body.linearVelocity=Vector2(0,-100);
    body.gravityOverride=Vector2(0, -100);
   // body.gravityOverride=Vector2(0,-100);
  //  body.applyLinearImpulse(Vector2(0,-100));

    return false;
  }
}
