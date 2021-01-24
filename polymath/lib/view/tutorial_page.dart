import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:polymath/view/tutorial_add.dart';
import 'package:polymath/view/tutorial_divide.dart';
import 'package:polymath/view/tutorial_multiply.dart';
import 'package:polymath/view/tutorial_subtract.dart';


import 'package:toast/toast.dart';



class TutorialPage extends StatefulWidget {
  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> with WidgetsBindingObserver {

  AudioCache player = new AudioCache();
  static const alarmAudioPath = "mainmusic.mp3";
  // AppLifecycleState _appLifecycleState;
  @override
  void initState() {
    // TODO: implement initState
    //player.loop(alarmAudioPath);
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // player.play(alarmAudioPath);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //player.clear(alarmAudioPath);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // setState(() {
    //   _appLifecycleState = state;
    // });

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      //player.clear(alarmAudioPath);
    } else if (state == AppLifecycleState.resumed) {
      //player.loop(alarmAudioPath);
    }
  }

  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return new Scaffold(
        body: Stack(
          children: <Widget>[
             Center(
                      child: new Image.asset(
              'assets/images/bg/drillbg.jpg',
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
                  "TUTORIALS",
                  style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold, color: Colors.red),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    
                    child: GestureDetector(
                      onTap: () {
                       Navigator.push(context, MaterialPageRoute(
                         builder: (context) => TutorAdd()
                       ));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: BoxDecoration(
                            color: Color(0xFF180191),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Text(
                          "ADDITION",
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
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: () {
                       Navigator.push(context, MaterialPageRoute(
                         builder: (context) => TutorSubtract()
                       ));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: BoxDecoration(
                          
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Text(
                          "SUBTRACTION",
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
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: () {
                       Navigator.push(context, MaterialPageRoute(
                         builder: (context) => TutorMultiply()
                       ));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Text(
                          "MULTIPLICATION",
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
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: () {
                       Navigator.push(context, MaterialPageRoute(
                         builder: (context) => TutorDivide()
                       ));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Text(
                          "DIVISION",
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
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: () {
                         Navigator.of(context).pop();
                      //  Navigator.push(context, MaterialPageRoute(
                      //    builder: (context) => TutorDivide()
                      //  ));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back, color: Colors.white),
                            Text(
                              " BACK",
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
          ],
        )
      );
  }
}
