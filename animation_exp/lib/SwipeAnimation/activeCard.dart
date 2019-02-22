import 'package:animation_exp/SwipeAnimation/gestureCard.dart';
import 'package:flutter/material.dart';

class ActiveCard extends StatelessWidget {
  final Widget singleData;
  final double bottom;
  final double right;
  final double left;
  final double cardWidth;
  final BuildContext context;
  final Function onGestureSwipeLeft;
  final int flag;
  final Function onGestureSwipeRight;
  final Function onCardTap;
  final Offset initialPosition;
  bool isActive;
  static int i = 0;

  ActiveCard(
      {this.isActive = true,
      this.singleData,
      this.bottom,
      this.right,
      this.left,
      this.cardWidth,
      this.context,
      this.onGestureSwipeLeft,
      this.flag,
      this.onGestureSwipeRight,
      this.onCardTap,
      this.initialPosition});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    print(initialPosition);
    print(singleData);
    return new Cards(
      isActive: isActive,
      initialPosition: initialPosition,
      swipeLeft: () {
        onGestureSwipeLeft();
      },
      swipeRight: () {
        onGestureSwipeRight();
      },
      child: new Hero(
        tag: "singleData",
        child: new GestureDetector(
          onTap: () {
            onCardTap();
          },
          child: new Card(
            color: Colors.transparent,
            elevation: 4.0,
            child: new Container(
              alignment: Alignment.center,
              width: screenSize.width / 1.2 + cardWidth,
              height: screenSize.height / 1.7,
              decoration: new BoxDecoration(
                color: new Color.fromRGBO(121, 114, 173, 1.0),
                borderRadius: new BorderRadius.circular(8.0),
              ),
              child: new Column(
                children: <Widget>[
                  new Container(
                    width: screenSize.width / 1.2 + cardWidth,
                    height: screenSize.height / 2.2,
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.only(
                          topLeft: new Radius.circular(8.0),
                          topRight: new Radius.circular(8.0)),
                    ),
                    child: singleData,
                  ),
                  new Container(
                    width: screenSize.width / 1.2 + cardWidth,
                    height: screenSize.height / 1.7 - screenSize.height / 2.2,
                    alignment: Alignment.center,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
