
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

import '../revoluate_joint.dart';

class FrictionBody extends BodyComponent with Draggable {
  final Vector2 positiond;

  FrictionBody(this.positiond);

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBox(4, 2.0,Vector2(0, 0),0);
    final fixtureDef = FixtureDef(
      shape,
      density: 1.0,
      restitution: 4,
      friction: 1,
    );
    final bodyDef = BodyDef(type: BodyType.static, position: positiond);//initial position
    bodyDef.gravityOverride=Vector2(0, 0);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void>onLoad()async{
    super.onLoad();
  }
  @override
  bool onDragStart(DragStartInfo info) {
    return true;
  }
  @override
  bool onDragUpdate(DragUpdateInfo info) {

    print(eventPosition(info).xy);
    positiond.xy=eventPosition(info).xy;
    body.setTransform(eventPosition(info).xy,0);

    return true;
  }


  @override
  bool onDragEnd(DragEndInfo info) {
    body.setTransform(positiond,0);
    return true;
  }

}




class Ember<T extends FlameGame> extends SpriteAnimationComponent
    with HasGameRef<T> {
  Ember({super.position, Vector2? size, super.priority})
      : super(
          size: size ?? Vector2.all(50),
          anchor: Anchor.center,
        );
  @override
  Future<void> onLoad() async {
    animation = await gameRef.loadSpriteAnimation(
      'animations/ember.png',
      SpriteAnimationData.sequenced(
        amount: 3,
        textureSize: Vector2.all(16),
        stepTime: 0.15,
      ),
    );
  }
}
