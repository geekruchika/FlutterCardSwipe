import 'package:animation_exp/SwipeAnimation/gesture_card_deck.dart';
import 'package:flutter/material.dart';
import 'package:animation_exp/SwipeAnimation/data.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: new GestureCardDeck(
          onButtonPressAnimationTime: 1000,
          data: imageData,
          animationTime: Duration(milliseconds: 200),
          velocityToSwipe: 1200,
          leftSwipeButton: Container(
            height: 50,
            width: 150,
            decoration: BoxDecoration(color: Colors.black),
            child: Center(
                child:
                    Text("Swipe Left", style: TextStyle(color: Colors.white))),
          ),
          rightSwipeButton: Container(
            height: 50,
            width: 150,
            decoration: BoxDecoration(color: Colors.black),
            child: Center(
                child:
                    Text("Swipe Right", style: TextStyle(color: Colors.white))),
          ),
          onSwipeLeft: (index) {
            print("on swipe left");
            print(index);
          },
          onSwipeRight: (index) {
            print("on swipe right");
            print(index);
          },
          onCardTap: (index) {
            print("on card tap");
            print(index);
          },
          leftPosition: 50,
          topPosition: 90,
        ),
      ),
    );
  }
}
