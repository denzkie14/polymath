import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:polymath/popme.dart';

class LostView {
  final PopMe game;
  Rect rect;
  Sprite sprite;

  LostView(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize,
      (game.screenSize.height / 2) - (game.tileSize * 5),
      game.tileSize * 7,
      game.tileSize * 5,
    );

 

    sprite = Sprite('bg/failed.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void update(double t) {}
}