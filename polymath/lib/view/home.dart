import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:polymath/popme.dart';

class HomeView {
  final PopMe game;
  Rect titleRect;
  Sprite titleSprite;

  HomeView(this.game) {
    titleRect = Rect.fromLTWH(
  game.tileSize,
  (game.screenSize.height / 2) - (game.tileSize * 5.5),
  game.tileSize * 7,
  game.tileSize * 4,
);
titleSprite = Sprite('branding/title.png');
  }

  void render(Canvas c) {titleSprite.renderRect(c, titleRect);}

  void update(double t) {}
}