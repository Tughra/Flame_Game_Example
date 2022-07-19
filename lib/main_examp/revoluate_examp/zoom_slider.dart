import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_example/main_examp/revoluate_examp/revoluate_joint.dart';
import 'package:game_example/main_examp/revoluate_examp/widgets.dart';
class ZoomSliderWidget extends StatefulWidget {
  final RevoluteJointExample game;


  const ZoomSliderWidget(
      this.game,
       {
        super.key,
      });

  @override
  State<StatefulWidget> createState() {
    return _ZoomSliderState();
  }
}

class _ZoomSliderState extends State<ZoomSliderWidget> {
  _ZoomSliderState();

  @override
  Widget build(BuildContext context) {

      final bodyPosition = widget.game.size;
      return Positioned(
      bottom: 10,
        right: 10,
        left: 10,
        child: ConstrainedBox(constraints: BoxConstraints(maxWidth: 200,maxHeight: 20),
          child: ZoomSlider(zoomValue: widget.game.zoomValue,onChanged: (val){
            setState((){
              widget.game.zoomValue=val;
            });
          },),
        ),
      );

  }
}