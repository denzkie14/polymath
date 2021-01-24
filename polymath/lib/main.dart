import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:polymath/popme.dart';
import 'package:polymath/view/drillme.dart';
import 'package:polymath/view/tutorial_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

AudioPlayer homeBGM;
AudioPlayer playingBGM;
var questions;
var jsonQuestions;
SharedPreferences storage;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   storage = await SharedPreferences.getInstance();

  Flame.images.loadAll(<String>[
    'bg/bg-underwater.jpg',
    'ui/question.png',
    // 'popme/bubble-blue.png',
    'popme/bubble-green.png',
    'popme/bubble-orange.png',
    'popme/bubble-purple.png',
    'popme/bubble-red.png',
    'popme/bubble-white.png',
    'popme/bubble-yellow.png',
   // 'popme/popcoin.png',
    'popme/coin1.png',
    'popme/coin2.png',
    'popme/coin3.png',
    'popme/coin4.png',
    'popme/coin5.png',
    'popme/coin6.png',
    'bg/failed.png',
    'branding/title.png',
    'ui/credits.png',
    'ui/help.png',
    'ui/icon-credits.png',
    'ui/icon-help.png',
    'ui/start-button.png',
    'ui/developer.png',
    'ui/start.png',
    'ui/info.png',
    'ui/music-on.png',
    'ui/music-off.png',
    'ui/fx-on.png',
    'ui/fx-off.png',
    'ui/button.png',
     'ui/btn-drill.png',
      'ui/btn-tutorial.png',
    
  ]);

  Flame.audio.disableLog();
  Flame.audio.loadAll(<String>[
     'sfx/failed.mp3', 'sfx/mainmusic.mp3','sfx/playing.mp3','sfx/levelup.mp3','sfx/pop.mp3','sfx/bubble.mp3','sfx/points.mp3']);

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
  

    jsonQuestions = await rootBundle.loadString('assets/json/pop.json');
    questions = json.decode(jsonQuestions);
    
  //questions.shuffle();
  // TapGestureRecognizer tapper = TapGestureRecognizer();
  // tapper.onTapDown = game.onTapDown;
  // runApp(game.widget);
  // flameUtil.addGestureRecognizer(tapper);


 runApp( MaterialApp(
      title: 'PolyMath',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'HVD',
      ),
      home: PolyMath(),
        debugShowCheckedModeBanner: false,
      ),

  );


    homeBGM = await Flame.audio.loopLongAudio('sfx/mainmusic.mp3', volume: .25);
    homeBGM.pause();
    playingBGM = await Flame.audio.loopLongAudio('sfx/playing.mp3', volume: .35);
    playingBGM.pause();

    playHomeBGM();

}

 void playHomeBGM() {
    playingBGM.pause();
    playingBGM.seek(Duration.zero);
    homeBGM.resume();
  }

  void playPlayingBGM() {
    homeBGM.pause();
    homeBGM.seek(Duration.zero);
    playingBGM.resume();
  }


class MainPopme extends StatefulWidget {
  @override
  _MainPopmeState createState() => _MainPopmeState();
}

class _MainPopmeState extends State<MainPopme> {
  final PolyMath pol = new PolyMath();

   PopMe game = PopMe(storage, questions);

 Future<bool> _isClosing(){
    pol.setPlayer(1);  
   Navigator.pop(context, true);

  }

  @override
  Widget build(BuildContext context) {
    return   WillPopScope(
          onWillPop: _isClosing,
          child: Scaffold(
        body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned.fill(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTapDown: game.onTapDown,
                  child: game.widget,
                ),
              )
              ]
        )
      ),
    );
  }
}

class PolyMath extends StatefulWidget {
   
   void setPlayer(var v){
     currentView = v;

     if(currentView == 1){
        playHomeBGM();

     }else{
        playPlayingBGM();

     }
   }

  @override
  _PolyMathState createState() => _PolyMathState();
}
 var currentView;
class _PolyMathState extends State<PolyMath> with WidgetsBindingObserver {
 
  AppLifecycleState _appLifecycleState;
  @override
  void initState() {
    // TODO: implement initState
    // player.loop(alarmAudioPath);
    currentView = 1;
    super.initState();
   

    WidgetsBinding.instance.addObserver(this);

    // player.play(alarmAudioPath);
  }

 

  @override
  void dispose() {
    // TODO: implement dispose
    homeBGM.dispose();
    playingBGM.dispose();
 
    //  player.clear(alarmAudioPath);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    setState(() {
      _appLifecycleState = state;
    });

  print(_appLifecycleState);

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
    //  homeBGM.setVolume(0);
    //  playingBGM.setVolume(0);
    if(currentView == 1)
        homeBGM.pause();
        else
         playingBGM.pause();
      //  player.clear(alarmAudioPath);
    } else{
        if(currentView == 1)
        homeBGM.resume();
        else
         playingBGM.resume();
     
      //  player.loop(alarmAudioPath);
     //  homeBGM.setVolume(25);
     // playingBGM.setVolume(35);
      
    }
  }

  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false, 
    child: Scaffold(
      body: Stack(
      
        children: <Widget>[
            Center(
                      child: new Image.asset(
              'assets/images/bg/mainwall.png',
              width: size.width,
              height: size.height,
              fit: BoxFit.fill,
            ),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "",
                style: TextStyle(fontSize: 50.0, fontFamily: 'Jumpman'),
                
              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 100.0, right:90.0, top: 20.0, bottom: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TutorialPage()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 60.0,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        "Teach Me!",
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.white),
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
                padding: const EdgeInsets.only(left: 100.0, right:90.0, top: 20.0, bottom: 20.0),
                  child: GestureDetector(
                    onTap: () {
                         currentView = 2;
                       playPlayingBGM();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Drill()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 60.0,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        "Drill Me!",
                      style:
                            new TextStyle(fontSize: 20.0, color: Colors.white),
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
                 padding: const EdgeInsets.only(left: 100.0, right:90.0, top: 20.0, bottom: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      //  Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => PopUI()));

                      // PopMe popme = PopMe();
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => popme.widget));
                      // TapGestureRecognizer tapper = TapGestureRecognizer();
                      // tapper.onTapDown = popme.onTapDown;
                      // flameUtil.addGestureRecognizer(tapper);
                      currentView = 2;
                      playPlayingBGM();
                       Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainPopme()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 60.0,
                      decoration: BoxDecoration(
                          color: Colors.orange, //Color(0xFF180191)
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        "Pop Me!",
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          // Row(
          //   children: <Widget>[
          //     Expanded(
          //       child: Padding(
          //        padding: const EdgeInsets.only(left: 60.0, right:140.0, top: 20.0, bottom: 20.0),
          //         child: GestureDetector(
          //           onTap: () {
          //             Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                     builder: (context) => MainPopme()));
          //           },
          //           child: Container(
          //             alignment: Alignment.center,
          //             height: 60.0,
          //             decoration: BoxDecoration(
          //                 color: Colors.orange,
          //                 borderRadius: BorderRadius.circular(10.0)),
          //             child: Text(
          //               "ANSWER ME",
          //               style:
          //                   new TextStyle(fontSize: 20.0, color: Colors.white),
          //             ),
          //           ),
          //         ),
          //       ),
          //     )
          //   ],
          // ),
                Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                 padding: const EdgeInsets.only(left: 100.0, right:90.0, top: 20.0, bottom: 20.0),
                  child: GestureDetector(
                    onTap: () {
                    showDialog(

  context: context,builder: (_) => AssetGiffyDialog(
    image: Image.asset('assets/img/dialoggif.gif'),
    title: Text('Exit',
            style: TextStyle(
            fontSize: 22.0, fontWeight: FontWeight.w600),
    ),
    description: Text('Are you sure you want to exit?',
          textAlign: TextAlign.center,
          style: TextStyle(),
        ),
    onOkButtonPressed: () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    },
  ) );
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => TutorDivide()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 60.0,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Icon(Icons.exit_to_app, color: Colors.white),
                          Text(
                            " Exit",
                            style:
                                new TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
                    ],
                )
          
        ],
      ),
    )
    );
  }
}