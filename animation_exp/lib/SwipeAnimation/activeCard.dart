import 'package:animation_exp/SwipeAnimation/gestureCard.dart';
import 'package:flutter/material.dart';

class ActiveCard extends StatelessWidget {
  final Widget singleData;
  final double cardWidth;
  final BuildContext context;
  final Function onGestureSwipeLeft;
  final Function onGestureSwipeRight;
  final Function onCardTap;
  final Offset initialPosition;
  final bool isActive;
  final double velocityToSwipe;
  final Duration animationTime;
  final Widget leftSwipeButton;
  final Widget rightSwipeButton;
  ActiveCard({
    this.isActive = true,
    this.singleData,
    this.cardWidth,
    this.context,
    this.onGestureSwipeLeft,
    this.onGestureSwipeRight,
    this.onCardTap,
    this.initialPosition,
    this.velocityToSwipe,
    this.animationTime,
    this.leftSwipeButton,
    this.rightSwipeButton,
  });

  @override
  Widget build(BuildContext context) {
    return new GestureCard(
      isActive: isActive,
      initialPosition: initialPosition,
      animationTime: animationTime,
      velocityToSwipe: velocityToSwipe,
      leftSwipeButton: leftSwipeButton,
      rightSwipeButton: rightSwipeButton,
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
            child: Center(
              child: new Card(
                color: Colors.transparent,
                child: Container(child: singleData),
                elevation: 4.0,
              ),
            )
            //     new Card(
            //   color: Colors.transparent,
            //   elevation: 4.0,
            //   child: new Container(
            //     alignment: Alignment.center,
            //     width: screenSize.width / 1.2 + cardWidth,
            //     height: screenSize.height / 1.7,
            //     decoration: new BoxDecoration(
            //       color: new Color.fromRGBO(121, 114, 173, 1.0),
            //       borderRadius: new BorderRadius.circular(8.0),
            //     ),
            //     child: new Column(
            //       children: <Widget>[
            //         new Container(
            //           width: screenSize.width / 1.2 + cardWidth,
            //           height: screenSize.height / 2.2,
            //           decoration: new BoxDecoration(
            //             borderRadius: new BorderRadius.only(
            //                 topLeft: new Radius.circular(8.0),
            //                 topRight: new Radius.circular(8.0)),
            //           ),
            //           child: singleData,
            //         ),
            //         new Container(
            //           width: screenSize.width / 1.2 + cardWidth,
            //           height: screenSize.height / 1.7 - screenSize.height / 2.2,
            //           alignment: Alignment.center,
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            ),
      ),
    );
  }
}
