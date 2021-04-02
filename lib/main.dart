import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STOPWATCH',
      home: StopwatchApp(),
    );
  }
}

class StopwatchApp extends StatefulWidget {
  @override
  _StopwatchAppState createState() => _StopwatchAppState();
}

class _StopwatchAppState extends State<StopwatchApp> {

  String timeString = "00:00:00";
  Stopwatch stopwatch = Stopwatch();
  Timer timer;

  void start() {
    stopwatch.start();
    timer = Timer.periodic(Duration(microseconds: 1), update);
  }

  void update(Timer t){
    if (stopwatch.isRunning) {
      setState(() {
        timeString = (stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, "0")+
        ":"+(stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, "0")+":"+
            (stopwatch.elapsed.inMilliseconds % 1000 / 10).clamp(0, 99).toStringAsFixed(0).padLeft(2, "0");
      });
    }
  }

  void stop(){
    setState(() {
      timer.cancel();
      stopwatch.stop();
    });
  }

  void reset(){
    timer.cancel();
    stopwatch.reset();
    setState(() {
      timeString= "00:00:00";
    });
    stopwatch.stop();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 60, vertical: 60),
            child: Text(
              'STOPWATCH',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade900
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(10,10),
                      color: Colors.black38,
                      blurRadius: 15,
                    ),
                    BoxShadow(
                      offset: Offset(-10,-10),
                      color: Colors.white.withOpacity(0.85),
                      blurRadius: 15,
                    )
                  ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.timer, size: 90, color: Colors.grey.shade900,),
                  Text(
                    timeString,
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.grey.shade900,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(10,10),
                          color: Colors.black38,
                          blurRadius: 15,
                        ),
                        BoxShadow(
                          offset: Offset(-10,-10),
                          color: Colors.white.withOpacity(0.85),
                          blurRadius: 15,
                        ),
                      ]
                  ),
                  child: IconButton(
                    onPressed: reset,
                    icon: Icon(
                      Icons.refresh,
                      size: 60,
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(10,10),
                          color: Colors.black38,
                          blurRadius: 15,
                        ),
                        BoxShadow(
                          offset: Offset(-10,-10),
                          color: Colors.white.withOpacity(0.85),
                          blurRadius: 15,
                        ),
                      ]
                  ),
                  child: IconButton(
                    onPressed: (){
                      stopwatch.isRunning ? stop() : start();
                    },
                    icon: Icon(stopwatch.isRunning ? Icons.pause : Icons.play_arrow, size: 60,),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
