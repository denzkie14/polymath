import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/painting.dart';
import 'package:polymath/popme.dart';
import 'package:flutter/material.dart';

class QuestionDisplay {
  final PopMe game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;
  Sprite questionSprite;
  Rect  questionRect;

  Expanded expanded; 

  String answer;
  QuestionDisplay(this.game) {
    answer='';
    painter = TextPainter(
     
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textStyle = TextStyle(
      
    //  backgroundColor: Colors.pink.withOpacity(0.3),
      fontWeight: FontWeight.bold,
      color: Color(0xffffffff),
      fontSize: 30,
      shadows: <Shadow>[
        Shadow(
          blurRadius: 7,
          color: Color(0xff000000),
          offset: Offset(3, 3),
        ),
      ],
    );

    position = Offset.zero;

  questionRect = Rect.fromLTWH(
  game.tileSize -38,
  (game.screenSize.height) - (game.tileSize * 1.6),
  game.tileSize * 9,
  game.tileSize*1.5,
);
     questionSprite = Sprite('ui/question.png');
  }

  void render(Canvas c) {
    questionSprite.renderRect(c, questionRect);
    painter.paint(c, position);
  }

  void update(double t) {
    if ((painter.text?.text ?? '') != game.question) {
      painter.text = TextSpan(
        text: game.question,
        style: textStyle,
        
      );

      painter.layout();

      position = Offset(
       (game.screenSize.width / 2) - (painter.width / 2),
        ((game.screenSize.height) - (painter.height))-20,
      );
    }
  }
}