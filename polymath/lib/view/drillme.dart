import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';
import 'package:polymath/main.dart';
import 'package:audioplayers/audio_cache.dart';
import 'dart:async';
import 'dart:convert';
import 'package:giffy_dialog/giffy_dialog.dart';
// List shuffle(List items) {
//   var random = new Random();

//   // Go through all elements.
//   for (var i = items.length - 1; i > 0; i--) {
//     // Pick a pseudorandom number according to the list length
//     var n = random.nextInt(i + 1);

//     var temp = items[i];
//     items[i] = items[n];
//     items[n] = temp;
//   }

//   return items;
// }

class Drill extends StatefulWidget {
  @override
  _DrillState createState() => _DrillState();
}

var finalScore = 0;
var questionNumber = 0;
List questions;
int _start = 30;
Color defColor = Color(0xFF180191);
Color correctColor = Colors.green;
Color wrongColor = Colors.red;
Color btnA = defColor;
Color btnB = defColor;
Color btnC = defColor;
Color btnD = defColor;
final PolyMath pol = new PolyMath();

class _DrillState extends State<Drill> {
  AudioCache player;
  static const correct = "correct.mp3";
  static const wrong = "wrong.mp3";

  Timer _timer;

  Future<String> loadDrill() async {
    var jsonQuestions = await rootBundle.loadString('assets/json/drill.json');
    setState(() {
      questions = json.decode(jsonQuestions);
      questions.shuffle();
    });
    //print(jsonQuestions);
  }

  @override
  void initState() {
    // player = AudioCache(
    //     fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP));
    // // TODO: implement initState
    // player.load(correct);
    // player.load(wrong);

    this.loadDrill();

    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Stack(
            //fit: StackFit.loose,
            children: <Widget>[
              Center(
                child: new Image.asset(
                  'assets/images/bg/drillbg.jpg',
                  width: size.width,
                  height: size.height,
                  fit: BoxFit.fill,
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Question ${questionNumber + 1} of ${questions.length}',
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Score: $finalScore',
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'Timer: $_start',
                            style: TextStyle(
                              fontSize: 22.0,
                              color: _start <= 5 ? Colors.red : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                  top: 45.0,
                                  bottom: 20.0),
                              child: Container(
                                alignment: Alignment.center,
                                height: 210.0,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/img/questionboard.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    color: Colors.blueGrey.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Text(
                                  questions[questionNumber]['questionText'],
                                  style: new TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30.0,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 25.0,
                                  bottom: 5.0,
                                  left: 60.0,
                                  right: 60.0),
                              child: GestureDetector(
                                onTap: () {
                                  checkAnswer(
                                      questions[questionNumber]['choiceA'],
                                      'a');
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 55.0,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/img/questionbutton.png'),
                                        fit: BoxFit.cover,
                                      ),
                                      //color: btnA, //Color(0xFF180191),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Text(
                                    questions[questionNumber]['choiceA'],
                                    style: new TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 20.0,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 5.0,
                                  left: 60.0,
                                  right: 60.0),
                              child: GestureDetector(
                                onTap: () {
                                  checkAnswer(
                                      questions[questionNumber]['choiceB'],
                                      'b');
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 55.0,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/img/questionbutton.png'),
                                        fit: BoxFit.cover,
                                      ),
                                      // color: btnB,
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Text(
                                    questions[questionNumber]['choiceB'],
                                    style: new TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 20.0,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 5.0,
                                  left: 60.0,
                                  right: 60.0),
                              child: GestureDetector(
                                onTap: () {
                                  checkAnswer(
                                      questions[questionNumber]['choiceC'],
                                      'c');
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 55.0,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/img/questionbutton.png'),
                                        fit: BoxFit.cover,
                                      ),
                                      // color: btnC,
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Text(
                                    questions[questionNumber]['choiceC'],
                                    style: new TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 20.0,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 2.0, left: 60.0, right: 60.0),
                              child: GestureDetector(
                                onTap: () {
                                  checkAnswer(
                                      questions[questionNumber]['choiceD'],
                                      'd');
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 55.0,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/img/questionbutton.png'),
                                        fit: BoxFit.cover,
                                      ),
                                      // color: btnD,
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Text(
                                    questions[questionNumber]['choiceD'],
                                    style: new TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 20.0,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 35.0, bottom: 1.0, left: 240.0),
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) => AssetGiffyDialog(
                                            image: Image.asset(
                                                'assets/img/dialoggif.gif'),
                                            title: Text(
                                              'STOP DRILL',
                                              style: TextStyle(
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            description: Text(
                                              'Quit Polynomial Drill?',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(),
                                            ),
                                            onOkButtonPressed: () {
                                              _start = 30;
                                              _timer.cancel();
                                              finalScore = 0;
                                              questionNumber = 0;
                                              pol.setPlayer(1);
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PolyMath()));
                                            },
                                          ));
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 45.0,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/img/questionbutton.png'),
                                        fit: BoxFit.cover,
                                      ),
                                      color: Color(0xFF180191),
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
                                  child: Icon(
                                    Icons.exit_to_app,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void checkAnswer(String ans, var btn) async {
    _timer.cancel();
    if (ans == questions[questionNumber]['answerKey']) {
      setState(() {
        if (btn == 'a') {
          btnA = correctColor;
        } else if (btn == 'b') {
          btnB = correctColor;
        } else if (btn == 'c') {
          btnC = correctColor;
        } else if (btn == 'd') {
          btnD = correctColor;
        }
      });
      Flame.audio.play('sfx/correct.mp3').then((pl) {
        showDialog(
          context: context,
          builder: (BuildContext context) => CustomDialog(
              title: "CONGRATULATIONS!",
              description: "You chose the correct answer!",
              buttonText:
                  questionNumber != (questions.length - 1) ? "NEXT" : "FINISH",
              animation: "Success",
              image: 'assets/img/correct.png',
              color: Colors.lightGreenAccent,
              btnColor: Colors.green),
        ).then((context) {
          updateQuestion();
        });

        print('CORRECT!');
        finalScore++;
      });
    } else {
      setState(() {
        if (btn == 'a') {
          btnA = wrongColor;
        } else if (btn == 'b') {
          btnB = wrongColor;
        } else if (btn == 'c') {
          btnC = wrongColor;
        } else if (btn == 'd') {
          btnD = wrongColor;
        }
      });
      Flame.audio.play('sfx/wrong.mp3').then((pl) {
        showDialog(
          context: context,
          builder: (BuildContext context) => CustomDialog(
            title: "WRONG!",
            description:
                "The correct answer is ${questions[questionNumber]['answerKey']}.",
            buttonText:
                questionNumber != (questions.length - 1) ? "NEXT" : "FINISH",
            animation: "Error",
            image: 'assets/img/wrong.png',
            color: Colors.redAccent,
            btnColor: Colors.red,
          ),
        ).then((context) {
          updateQuestion();
        });
        print('WRONG!');
      });
    }
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            checkAnswer("", 'x');
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  void pauseTimer() {
    _timer.cancel();
  }

  void resetTimer() {}

  void updateQuestion() {
    setState(() {
      btnA = defColor;
      btnB = defColor;
      btnC = defColor;
      btnD = defColor;
      if (questionNumber == questions.length - 1) {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new Summary(score: finalScore)));
      } else {
        _start = 30;
        startTimer();
        questionNumber++;
      }
    });
  }

  //  void _showDialog(String res, String msg) {
  //   // flutter defined function
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       // return object of type Dialog
  //       return AlertDialog(
  //         backgroundColor: Colors.green,
  //         title: new Text(res),
  //         content: new Text(msg),
  //         actions: <Widget>[
  //           // usually buttons at the bottom of the dialog
  //            MaterialButton(
  //              textColor: Colors.white,
  //             color: Colors.green,
  //             child: new Text("OK"),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               updateQuestion();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

}

class Summary extends StatelessWidget {
  final int score;

  Summary({Key key, @required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(25.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 35.0, bottom: 25.0),
                      child: Container(
                        alignment: Alignment.center,
                        height: 240.0,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Text(
                          "SCORE : $score",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40.0,
                              color: (questions.length / 2) <= score
                                  ? Colors.green
                                  : Colors.red),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, bottom: 10.0, left: 60.0, right: 60.0),
                      child: GestureDetector(
                        onTap: () {
                          questions.shuffle();
                          finalScore = 0;
                          questionNumber = 0;
                          _start = 30;

                          // Navigator.pop(context);
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Drill()));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: BoxDecoration(
                              color: Color(0xFF180191),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text(
                            "RETRY",
                            style: new TextStyle(
                                fontSize: 20.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, bottom: 10.0, left: 60.0, right: 60.0),
                      child: GestureDetector(
                        onTap: () {
                          playHomeBGM();
                          finalScore = 0;
                          questionNumber = 0;
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PolyMath()));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          decoration: BoxDecoration(
                              color: Color(0xFF180191),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text(
                            "END",
                            style: new TextStyle(
                                fontSize: 20.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  final String image;
  final Color color;
  final Color btnColor;
  final String animation;

  CustomDialog(
      {@required this.title,
      @required this.description,
      @required this.buttonText,
      this.image,
      this.color,
      this.btnColor,
      this.animation});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: MaterialButton(
                  color: btnColor,
                  splashColor: Colors.greenAccent,
                  onPressed: () {
                    Navigator.of(context).pop(); // To close the dialog
                  },
                  child: Text(
                    buttonText,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: Consts.padding,
          right: Consts.padding,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: Consts.avatarRadius,
            child: ClipOval(
              child: Image.asset(
                image,
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        //...bottom card part,
        //...top circlular image part,
      ],
    );
  }
}

class Consts {
  Consts._();
  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
