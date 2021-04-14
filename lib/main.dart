import 'dart:async';

import 'package:flutter/material.dart';

import 'StopwatchApp.dart';

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

