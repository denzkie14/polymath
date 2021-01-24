import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/painting.dart';
import 'package:polymath/components/bubble.dart';

class Callout {
  final Bubble bubble;
  Rect rect;
  Sprite sprite;
  double value;

  TextPainter tp;
  TextStyle textStyle;
  Offset textOffset;

  Callout(this.bubble) {
 // sprite = Sprite('ui/callout.png');
  value = 1;
  tp = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );
  textStyle = TextStyle(
    color: Color(0xff000000),
    fontSize: 15,
  );
}

  void render(Canvas c) {}

  void update(double t) {}
}