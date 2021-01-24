import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:polymath/popme.dart';

class MusicButton {
  final PopMe game;
  Rect rect;
  Sprite enabledSprite;
  Sprite disabledSprite;
  bool isEnabled = true;

  MusicButton(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize * .25,
      game.tileSize * .25,
      game.tileSize,
      game.tileSize,
    );
    enabledSprite = Sprite('ui/music-on.png');
    disabledSprite = Sprite('ui/music-off.png');
  }

  void render(Canvas c) {
    if (isEnabled) {
      enabledSprite.renderRect(c, rect);
    } else {
      disabledSprite.renderRect(c, rect);
    }
  }

  void onTapDown() {
    // if (isEnabled) {
    //   isEnabled = false;
    //   game.homeBGM.setVolume(0);
    //   game.playingBGM.setVolume(0);
    // } else {
    //   isEnabled = true;
    //   game.homeBGM.setVolume(.25);
    //   game.playingBGM.setVolume(.25);
    // }
  }
}