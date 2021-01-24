import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:polymath/popme.dart';

class LevelDisplay {
  final PopMe game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;

LevelDisplay(this.game) {
  painter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  Shadow shadow = Shadow(
    blurRadius: 3,
    color: Color(0xff000000),
    offset: Offset.zero,
  );

  textStyle = TextStyle(
    color: Color(0xffffffff),
    fontSize: 30,
    shadows: [shadow, shadow, shadow, shadow],
  );

  position = Offset.zero;

  updateLevel();
}

  void render(Canvas c) {
    painter.paint(c, position);
  }

  void updateLevel() {
  int level = game.storage.getInt('level') ?? 1;

  painter.text = TextSpan(
    text: 'Level: ' + level.toString(),
    style: textStyle,
  );

  painter.layout();

  position = Offset(
    game.screenSize.width - (game.tileSize * .25) - painter.width,
    game.tileSize,
  );
}
}