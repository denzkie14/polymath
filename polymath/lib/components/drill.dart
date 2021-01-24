import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:polymath/popme.dart';
import 'package:polymath/view/drillme.dart';

import '../view.dart';


class DrillButton {
  final PopMe game;

  
  Rect rect;
  Sprite sprite;

  DrillButton(this.game) {
    rect = Rect.fromLTWH(
  game.tileSize * 2,
  (game.screenSize.height * .75) - (game.tileSize * 3.5),
  game.tileSize * 5,
  game.tileSize * 1.5,
);
sprite = Sprite('ui/btn-drill.png');
}

  void render(Canvas c) {sprite.renderRect(c, rect);}

  void update(double t) {

  }

  void onTapDown() {
    // game.playPlayingBGM();
    // game.activeView = View.playing;
    // game.spawner.start();
    // game.score = 0;
  
  

  }
}