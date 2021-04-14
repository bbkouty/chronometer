import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
///
/// Author : BBKOUTY
/// Date   : 2021/04/14
///
/// This Class is build for managing the actual stopwatch
///
class StopwatchApp extends StatefulWidget {
  @override
  _StopwatchAppState createState() => _StopwatchAppState();
}

class _StopwatchAppState extends State<StopwatchApp> {

  /// A variable that store what the stopwatch will show to the user
  String timeString = "00:00:00";
  /// A stopwatch that we use for all the event, isRunning and so on...
  Stopwatch stopwatch = Stopwatch();
  /// The timer that we handle
  Timer timer;
  /// This list will hold all the time lap
  List timeLapList = [];

  /// This function start the clock 
  void start() {
    stopwatch.start();
    timer = Timer.periodic(Duration(microseconds: 1), update);
  }

  /// This function helps for the changing state on the timer
  void update(Timer t){
    if (stopwatch.isRunning) {
      setState(() {
        timeString = (stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, "0")+
            ":"+(stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, "0")+":"+
            (stopwatch.elapsed.inMilliseconds % 1000 / 10).clamp(0, 99).toStringAsFixed(0).padLeft(2, "0");
      });
    }
  }

  /// The function stop make a pause to the stopwatch
  void stop(){
    setState(() {
      timer.cancel();
      stopwatch.stop();
    });
  }

  /// This function reset the clock of the stopwatch
  void reset(){
    timer.cancel();
    stopwatch.reset();
    setState(() {
      timeString= "00:00:00";
      timeLapList.clear();
    });
    stopwatch.stop();
  }

  /// This function will add the timer to the time lap list
  void addTimeLapList(){
    if(stopwatch.isRunning) {
      setState(() {
        timeLapList.add(timeString);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'STOPWATCH',
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade900
            ),
          ),
        ),
        backgroundColor: Colors.grey.shade200,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade200,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Flexible(
            flex: 1,
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
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.timer, size: 90, color: Colors.grey.shade900,),
                    FittedBox(
                      child: Text(
                        timeString,
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
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
                        size: 50,
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
                      icon: Icon(
                        stopwatch.isRunning ? Icons.pause : Icons.play_arrow,
                        size: 50,
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
                      onPressed: addTimeLapList,
                      icon: Icon(Icons.timelapse, size: 50,),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            thickness: 5,
            color: Colors.black,
          ),
          Text('The List of taps'),
          SizedBox(
            height: 10,
          ),
          Flexible(
            flex: 1,
            child: ListView.builder(
              dragStartBehavior: DragStartBehavior.down,
              itemCount: timeLapList?.length ?? 0,
              itemBuilder: (context,index)=>Center(child: Text('${timeLapList[index].toString()}'))
            ),
          ),
        ],
      ),
    );
  }
}
