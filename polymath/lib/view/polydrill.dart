import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:polymath/popme.dart';

class DrillVIew {
  final PopMe game;
  Rect titleRect;
  Sprite titleSprite;

  DrillVIew(this.game) {
    titleRect = Rect.fromLTWH(
  game.tileSize,
  (game.screenSize.height) - (game.tileSize),
  game.tileSize,
  game.tileSize,
);
titleSprite = Sprite('bg/bg-underwater.jpg');
  }

  void render(Canvas c) {titleSprite.renderRect(c, titleRect);}

  void update(double t) {}
}