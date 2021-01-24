import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:polymath/components/credits-button.dart';
import 'package:polymath/components/drill.dart';
import 'package:polymath/components/help-button.dart';
import 'package:polymath/components/level-display.dart';
import 'package:polymath/components/music-button.dart';
import 'package:polymath/components/sound-button.dart';
import 'package:polymath/components/tutorial.dart';
import 'package:polymath/main.dart';
import 'package:polymath/view/credits-view.dart';
import 'package:polymath/view/drillme.dart';
import 'package:polymath/view/help-view.dart';
import 'package:polymath/view/lost-view.dart';

import 'components/background.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'components/bubble.dart';
import 'package:polymath/view.dart';
import 'package:flame/flame.dart';
import 'dart:math';
import 'package:polymath/components/bubblepop.dart';
import 'package:polymath/view/home.dart';
import 'components/highscore-display.dart';
import 'components/question-display.dart';
import 'components/score-display.dart';
import 'components/start-button.dart';
import 'controllers/spawner.dart';
import 'package:shared_preferences/shared_preferences.dart';



class PopMe extends Game {
  final SharedPreferences storage;
  HighscoreDisplay highscoreDisplay;
  View activeView = View.home;
  HomeView homeView;
  LostView lostView;
  StartButton startButton;
  BubbleSpawner spawner;


  DrillButton drillButton;
  TutorialButton tutorialButton;
  Size screenSize;
  Background background;
  bool hasWon = false;
  double tileSize;
  List<Bubble> flies;
  Random rnd;
  ScoreDisplay scoreDisplay;
  QuestionDisplay questionDisplay;
  LevelDisplay levelDisplay;
  int score;

  int questionIndex;
  int currentQuestion;
  int level;
  var questions;
  String question;
  String answer;

  HelpButton helpButton;
  CreditsButton creditsButton;

  HelpView helpView;
  CreditsView creditsView;

  MusicButton musicButton;
  SoundButton soundButton;



  PopMe(this.storage, this.questions) {
    initialize();
  }


  void initialize() async {
  
  

    level = storage.getInt('level') ?? 1;
    score = 0;
    questionIndex = 0;
    currentQuestion = 0;

    flies = List<Bubble>();
    rnd = Random();
    resize(await Flame.util.initialDimensions());
    scoreDisplay = ScoreDisplay(this);
    highscoreDisplay = HighscoreDisplay(this);
    levelDisplay = LevelDisplay(this);
    questionDisplay = QuestionDisplay(this);

    background = Background(this);

    helpButton = HelpButton(this);
    creditsButton = CreditsButton(this);
    helpView = HelpView(this);
    creditsView = CreditsView(this);

    musicButton = MusicButton(this);
    soundButton = SoundButton(this);

    homeView = HomeView(this);

    startButton = StartButton(this);
   drillButton = DrillButton(this);
   tutorialButton = TutorialButton(this);


    lostView = LostView(this);
    spawner = BubbleSpawner(this);
    setQuestion();
  }

  void render(Canvas canvas) {
    background.render(canvas);
    highscoreDisplay.render(canvas);
    if (activeView == View.playing) {
      scoreDisplay.render(canvas);
      levelDisplay.render(canvas);
      questionDisplay.render(canvas);
    }

    flies.forEach((Bubble fly) => fly.render(canvas));
    if (activeView == View.home) homeView.render(canvas);
    if (activeView == View.lost) lostView.render(canvas);

    // if (activeView == View.home || activeView == View.lost) {
    //   startButton.render(canvas);
    //   drillButton.render(canvas);
    //    tutorialButton.render(canvas);
    //   helpButton.render(canvas);
    //   creditsButton.render(canvas);
    // }

 if (activeView == View.home) {
      startButton.render(canvas);
    //  drillButton.render(canvas);
    //   tutorialButton.render(canvas);
      helpButton.render(canvas);
    //  creditsButton.render(canvas);
    }


    if (activeView == View.help) helpView.render(canvas);
    if (activeView == View.credits) creditsView.render(canvas);

   // musicButton.render(canvas);
  //  soundButton.render(canvas);
  }

  void update(double t) {
    spawner.update(t);
    flies.forEach((Bubble fly) => fly.update(t));
    flies.removeWhere((Bubble fly) => fly.isOffScreen);
    if (activeView == View.playing) {
      scoreDisplay.update(t);
      questionDisplay.update(t);
    }
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  void spawnFly() {
    // double x = rnd.nextDouble() * (screenSize.width - tileSize);
    // double y = rnd.nextDouble() * (screenSize.height - tileSize);
    double x = rnd.nextDouble() * (screenSize.width - (tileSize * 1.35));
    double y = (rnd.nextDouble() * (screenSize.height - (tileSize * 2.85))) +
        (tileSize * 1.5);
    if (questionIndex <= 10) {
      if (soundButton.isEnabled) {
        Flame.audio.play('sfx/bubble.mp3').whenComplete(() {
          flies.add(BubblePop(
              this, x, y, questions['$level'][questionIndex - 1]['answerKey']));
        });
      } else {
        flies.add(BubblePop(
            this, x, y, questions['$level'][questionIndex - 1]['answerKey']));
      }
    }
    //questionIndex++;
  }

  void setQuestion() {
    print('Current Question: $currentQuestion');
   // if (currentQuestion < 10) {
      answer = questions['$level'][currentQuestion]['answerKey'];
      question = questions['$level'][currentQuestion]['questionText'];
  //  } 
    
  //  else {
      //   if (activeView == View.playing && score<5) {
      //      if (soundButton.isEnabled) {
      //     Flame.audio.play('sfx/failed.mp3');
      //   }
      //    activeView = View.lost;
      //     currentQuestion = 0;
      //     questionIndex = 0;
      //  }else{
      // level++;
      // if (level > (storage.getInt('level') ?? 1)) {
      //   if (soundButton.isEnabled) {
      //     Flame.audio.play('sfx/levelup.mp3');
      //   }
      //   storage.setInt('level', level);
      //   levelDisplay.updateLevel();
      // }
      // currentQuestion = 0;
      // questionIndex = 0;
      // setQuestion();
   //   }
   // }
  }

  bool checkAnswer(String ans) {
    print(ans + ' ? ' + answer);
    if (answer == ans) {
      return true;
    } else {
      return false;
    }
  }

  void onTapDown(TapDownDetails d) {
    bool isHandled = false;
    if (!isHandled && startButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        startButton.onTapDown();
        isHandled = true;
      }
    }

    if (!isHandled) {
      bool didHitAFly = false;
      flies.forEach((Bubble fly) {
        if (fly.flyRect.contains(d.globalPosition)) {
          fly.onTapDown();
          isHandled = true;

          didHitAFly = true;
        }
      });

      if (!isHandled) {
        if (activeView == View.help || activeView == View.credits || activeView == View.lost ) {
          activeView = View.home;
          isHandled = true;
        }
      }
      if (!isHandled) {
        if (activeView == View.lost ) {
          activeView = View.home;
          isHandled = true;
        }
      }

      // if (activeView == View.playing && !didHitAFly) {
      //   activeView = View.lost;
      //   questionIndex=0;
      // }
    }

// help button
    if (!isHandled && helpButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        helpButton.onTapDown();
        isHandled = true;
      }
    }

// credits button
    if (!isHandled && creditsButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        creditsButton.onTapDown();
        isHandled = true;
      }
    }

    // music button
    if (!isHandled && musicButton.rect.contains(d.globalPosition)) {
      musicButton.onTapDown();
      isHandled = true;
    }

// sound button
    if (!isHandled && soundButton.rect.contains(d.globalPosition)) {
      soundButton.onTapDown();
      isHandled = true;
    }
    // sound button
    if (!isHandled && drillButton.rect.contains(d.globalPosition)) {
   //   drillButton.onTapDown();
      isHandled = true;

      //  Navigator.push(
      //                     ,
      //                     MaterialPageRoute(
      //                         builder: (context) =>  Drill()));
    }

  }

 
}

   