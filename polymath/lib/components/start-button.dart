import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:polymath/popme.dart';

import '../view.dart';


class StartButton {
  final PopMe game;
  Rect rect;
  Sprite sprite;

  StartButton(this.game) {
    rect = Rect.fromLTWH(
  game.tileSize * 3.5,
  (game.screenSize.height * .75) - (game.tileSize * 6.5),
  game.tileSize * 2,
  game.tileSize * 2,
);
sprite = Sprite('ui/start.png');
}

  void render(Canvas c) {sprite.renderRect(c, rect);}

  void update(double t) {

  }

  void onTapDown() {
  //  game.playPlayingBGM();
    game.activeView = View.playing;
    game.spawner.start();
    game.score = 0;

  }
}