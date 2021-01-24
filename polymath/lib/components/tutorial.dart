import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:polymath/popme.dart';

import '../view.dart';


class TutorialButton {
  final PopMe game;
  Rect rect;
  Sprite sprite;

  TutorialButton(this.game) {
    rect = Rect.fromLTWH(
  game.tileSize * 2,
  (game.screenSize.height * .75) - (game.tileSize * 1.5),
  game.tileSize * 5,
  game.tileSize * 1.5,
);
sprite = Sprite('ui/btn-tutorial.png');
}

  void render(Canvas c) {sprite.renderRect(c, rect);}

  void update(double t) {

  }

  void onTapDown() {
   // game.playPlayingBGM();
    game.activeView = View.playing;
    game.spawner.start();
    game.score = 0;

  }
}