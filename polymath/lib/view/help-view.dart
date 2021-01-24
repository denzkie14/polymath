import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:polymath/popme.dart';

class HelpView {
  final PopMe game;
  Rect rect;
  Sprite sprite;

  HelpView(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize * .5,
      (game.screenSize.height / 2) - (game.tileSize * 6),
      game.tileSize * 8,
      game.tileSize * 12,
    );
    sprite = Sprite('ui/help.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }
}