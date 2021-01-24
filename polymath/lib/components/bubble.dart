import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flutter/painting.dart';
import 'package:polymath/controllers/spawner.dart';
import 'package:polymath/popme.dart';
import 'package:flame/sprite.dart';

import '../view.dart';

class Bubble {
  Rect flyRect;
  bool isDead = false;
  final PopMe game;
  Paint flyPaint;
  bool isOffScreen = false;

  BubbleSpawner spawner;
  List<Sprite> flyingSprite;
  List<Sprite> deadSprite;
  double flyingSpriteIndex = 0;
  double deadSpriteIndex = 0;
  double get speed => game.tileSize * 3;
  Offset targetLocation;

  TextPainter tp;
  TextStyle textStyle;
  Offset textOffset;
  String value;

  Bubble(this.game) {
    // value = 'Hello World';
    tp = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      maxLines: 5,
      
    );
    
    textStyle = TextStyle(
      color: Color(0xffffffff),
      fontSize: 18,
      
    );
    setTargetLocation();
  }

  void render(Canvas c) {
    // c.drawRect(flyRect, flyPaint);

    if (isDead) {
      deadSprite[deadSpriteIndex.toInt()]
          .renderRect(c, flyRect.inflate(flyRect.width / 2));
      //   deadSprite.renderRect(c, flyRect.inflate(2));
    } else {
      flyingSprite[flyingSpriteIndex.toInt()]
       //   .renderRect(c, flyRect.inflate(flyRect.width / 2));
        .renderRect(c, flyRect.inflate( tp.width/2));
    }
    tp.paint(c, textOffset);
  }

  void update(double t) {
    tp.text = TextSpan(
      text: value,
      style: textStyle,
    );
    tp.layout();
    textOffset = Offset(
      flyRect.center.dx - (tp.width / 2),
      flyRect.top + (flyRect.height * .4) - ((tp.height / 2) - 13),
    );

    //pop the bubble
    if (isDead) {
      deadSpriteIndex += 15 * t;
      if (deadSpriteIndex >= 6) {
        deadSpriteIndex -= 6;
      }
      flyRect = flyRect.translate(0, game.tileSize * 12 * t);
      if (flyRect.top > game.screenSize.height) {
        isOffScreen = true;
      }
      //Change color bubble
    } else {
      flyingSpriteIndex += 30 * t;
      while (flyingSpriteIndex >= 2) {
        flyingSpriteIndex -= 2;
      }
    }

//move bubble
    double stepDistance = speed * t;
    Offset toTarget = targetLocation - Offset(flyRect.left, flyRect.top);
    if (stepDistance < toTarget.distance) {
      Offset stepToTarget =
          Offset.fromDirection(toTarget.direction, stepDistance);
      flyRect = flyRect.shift(stepToTarget);
    } else {
      flyRect = flyRect.shift(toTarget);
      setTargetLocation();
    }
  }

  void setTargetLocation() {
    // double x = game.rnd.nextDouble() *
    //     (game.screenSize.width - (game.tileSize * 2.025));
    // double y = game.rnd.nextDouble() *
    //     (game.screenSize.height - (game.tileSize * 2.025));
    double x = game.rnd.nextDouble() *
        (game.screenSize.width - (game.tileSize * 1.35));
    double y = (game.rnd.nextDouble() *
            (game.screenSize.height - (game.tileSize * 2.85))) +
        (game.tileSize * 1.5);

    targetLocation = Offset(x, y);
  }

  void onTapDown() {
    if (!isDead) {
      isDead = true;
      if (game.soundButton.isEnabled) {
        Flame.audio.play('sfx/pop.mp3');
      }
      if (game.activeView == View.playing) {
          game.currentQuestion++;
        if (game.checkAnswer(value)) game.score += (1* game.level);
        
        if (game.score > (game.storage.getInt('highscore') ?? 0)) {
          game.storage.setInt('highscore', game.score);
          game.highscoreDisplay.updateHighscore();
        }

        if(game.currentQuestion  < 10) { 
        
        game.setQuestion();
        
        }
       else{
          if ( (game.score) < (5*game.level)) {

           if (game.soundButton.isEnabled) {
          Flame.audio.play('sfx/failed.mp3');
        }
         game.activeView = View.lost;
          game.currentQuestion = 0;
          game.questionIndex = 0;
             game.setQuestion();
       }else{
         if(game.level == 10){
   if (game.soundButton.isEnabled) { //Max level reached!!!
          Flame.audio.play('sfx/levelup.mp3');
        }
           game.questionIndex = 0;
      game.currentQuestion = 0;
      game.score = 0;
      game.setQuestion();
         }else{
  game.level++;
      if (game.level > (game.storage.getInt('level') ?? 1)) { // Level Up!!!
        if (game.soundButton.isEnabled) {
          Flame.audio.play('sfx/levelup.mp3');
        }
        game.storage.setInt('level', game.level);
        game.levelDisplay.updateLevel();

      game.questionIndex = 0;
      game.currentQuestion = 0;
      game.score = 0;
      game.setQuestion();
      }
         }
    
       
        }
        }

        //game.setQuestion();
      }
    }
    //isDead = true;
    //game.spawnFly();
  }
}
