import 'package:flame/sprite.dart';
import 'package:polymath/components/bubble.dart';
import 'package:polymath/popme.dart';
import 'dart:ui';

class BubblePop extends Bubble {
  double get speed => game.tileSize * 3;

  BubblePop(PopMe game, double x, double y, String answer) : super(game) {
 //bubbleRect = Rect.fromLTWH(x, y, game.tileSize * 2.025, game.tileSize * 2.025);
     //coinRect = Rect.fromLTWH(x, y, game.tileSize * 2.025, game.tileSize * 2.025);

 //   flyRect = Rect.fromLTWH(x, y, game.tileSize* 2.025, game.tileSize* 2.025);
 flyRect = Rect.fromLTWH(x, y, game.tileSize * 1, game.tileSize * 1);
    flyingSprite = List<Sprite>();
    deadSprite = List<Sprite>();
    flyingSprite.add(Sprite('popme/bubble-red.png'));
    flyingSprite.add(Sprite('popme/bubble-white.png'));
    deadSprite.add(Sprite('popme/coin1.png'));
    deadSprite.add(Sprite('popme/coin2.png'));
    deadSprite.add(Sprite('popme/coin3.png'));
    deadSprite.add(Sprite('popme/coin4.png'));
    deadSprite.add(Sprite('popme/coin5.png'));
    deadSprite.add(Sprite('popme/coin6.png'));
    value = answer;
    //deadSprite = Sprite('popme/popcoin.png');
  }
}
