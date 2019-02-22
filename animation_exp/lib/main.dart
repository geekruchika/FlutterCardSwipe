import 'package:animation_exp/SwipeAnimation/index.dart';
import 'package:flutter/material.dart';
import 'package:animation_exp/SwipeAnimation/data.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      // showPerformanceOverlay: true,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: new CardDemo(
          onButtonPressAnimationTime: 1000,
          data: imageData,
          onSwipeLeft: (index) {
            print("swipe left");
            print(index);
          },
          onSwipeRight: (index) {
            print("swipe right");
            print(index);
          },
          onCardTap: (index) {
            print("on card tap");
            print(index);
          },
          noCardLeft: Text("LOL"),
        ),
      ),
      
    );
  }
}
