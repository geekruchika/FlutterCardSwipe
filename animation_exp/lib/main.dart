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
          data: imageData,
          animationTime: Duration(milliseconds: 1000),
          showAsDeck: true,
          velocityToSwipe: 1200,
          leftSwipeButton: Container(
            height: 50,
            width: 150,
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                )),
            child: Center(
                child: Text("NOPE", style: TextStyle(color: Colors.white))),
          ),
          rightSwipeButton: Container(
            height: 50,
            width: 150,
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                )),
            child: Center(
                child: Text("YEAH", style: TextStyle(color: Colors.white))),
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
          leftSwipeBanner: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Transform.rotate(
              angle: 0.5,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("NOPE",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.red,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ),
          rightSwipeBanner: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Transform.rotate(
                angle: -0.5,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("YEAH",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
