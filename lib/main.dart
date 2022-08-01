import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_example/game2/main_game.dart';
import 'package:game_example/main_examp/revoluate_examp/zoom_slider.dart';

import 'main_examp/revoluate_examp/revoluate_joint.dart';

void main() {
  var game =StabbingGame();
  runApp(
MaterialApp(home:
    // /CollidableAnimationExample
Scaffold(
  body:GameWidget<StabbingGame>(

        game:game,

      /*
        overlayBuilderMap: {

  'zoomWidget': (ctx, game) {

    return ZoomSliderWidget(game);

  },

        },
       */

      ),
),)
  );
}