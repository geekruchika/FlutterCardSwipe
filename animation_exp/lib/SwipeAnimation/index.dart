import 'dart:math';

import 'package:animation_exp/SwipeAnimation/dummyCard.dart';
import 'package:animation_exp/SwipeAnimation/activeCard.dart';
import 'package:flutter/material.dart';

class CardDemo extends StatefulWidget {
  final int onButtonPressAnimationTime;
  final List data;
  final Function onSwipeRight;
  final Function onSwipeLeft;
  final Widget noCardLeft;
  final Function onCardTap;

  const CardDemo({
    Key key,
    this.onButtonPressAnimationTime = 1000,
    this.noCardLeft,
    @required this.onCardTap,
    @required this.data,
    @required this.onSwipeRight,
    @required this.onSwipeLeft,
  }) : super(key: key);
  @override
  CardDemoState createState() => new CardDemoState();
}

class CardDemoState extends State<CardDemo> with TickerProviderStateMixin {
  Animation<double> rotate;
  Animation<double> right;
  Animation<double> bottom;
  Animation<double> width;
  int flag = 0;
  List data;
  List showData;
  List selectedData = [];
  static int i = 0;
  void initState() {
    super.initState();
    data = widget.data;
    showData = data.take(5).toList();
  }

  onGestureSwipeLeft() {
    setState(() {
      print("onGesture Left Called");
      widget.onSwipeLeft(data.indexOf(showData[0]));
      showData.removeAt(0);
      i++;
    });
    if (data.length >= 5 + i) {
      var j = data[4 + i];
      showData.add(j);
    }
    print(showData.length);
  }

  onGestureSwipeRight() {
    setState(() {
      print("onGesture Right Called");
      widget.onSwipeRight(data.indexOf(showData[0]));
      showData.removeAt(0);
      i++;
    });
    if (data.length >= 5 + i) {
      var j = data[4 + i];
      showData.add(j);
    }
  }

  @override
  Widget build(BuildContext context) {
    String key = Random().nextDouble().toString();
    double initialBottom = 15.0;
    var dataLength = showData.length;
    double backCardPosition = initialBottom + (dataLength - 1) * 10 + 10;
    double backCardWidth = -10.0;
    return dataLength > 0
        ? new Stack(
            key: Key(key),
            alignment: AlignmentDirectional.center,
            children: showData.reversed.map((item) {
              if (showData.indexOf(item) == 0) {
                print("Active card called");
                return ActiveCard(
                  initialPosition: Offset(30, backCardPosition),
                  singleData: item,
                  left: 0.0,
                  cardWidth: backCardWidth + 10,
                  context: context,
                  onGestureSwipeLeft: onGestureSwipeLeft,
                  flag: flag,
                  onGestureSwipeRight: onGestureSwipeRight,
                  onCardTap: widget.onCardTap,
                );
              } else {
                backCardPosition = backCardPosition + 10;
                backCardWidth = backCardWidth + 10;

                return ActiveCard(
                  isActive: false,
                  initialPosition: Offset(30, backCardPosition),
                  singleData: item,
                  left: 0.0,
                  cardWidth: backCardWidth,
                  context: context,
                  onGestureSwipeLeft: onGestureSwipeLeft,
                  flag: flag,
                  onGestureSwipeRight: onGestureSwipeRight,
                  onCardTap: widget.onCardTap,
                );
              }
            }).toList(),
          )
        : (widget.noCardLeft == null)
            ? new Text("No Event Left",
                style: new TextStyle(color: Colors.white, fontSize: 50.0))
            : widget.noCardLeft;
  }
}
