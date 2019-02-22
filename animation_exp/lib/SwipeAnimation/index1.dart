// import 'dart:async';
// import 'package:animation_exp/SwipeAnimation/dummyCard.dart';
// import 'package:animation_exp/SwipeAnimation/activeCard.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart' show timeDilation;

// class CardDemo extends StatefulWidget {
//   final int onButtonPressAnimationTime;
//   final List data;
//   final Function onSwipeRight;
//   final Function onSwipeLeft;
//   final Widget noCardLeft;
//   final Function onCardTap;
//   const CardDemo({
//     Key key,
//     this.onButtonPressAnimationTime = 1000,
//     this.noCardLeft,
//     @required this.onCardTap,
//     @required this.data,
//     @required this.onSwipeRight,
//     @required this.onSwipeLeft,
//   }) : super(key: key);
//   @override
//   CardDemoState createState() => new CardDemoState();
// }

// class CardDemoState extends State<CardDemo> with TickerProviderStateMixin {
//   AnimationController _buttonController;
//   Animation<double> rotate;
//   Animation<double> right;
//   Animation<double> bottom;
//   Animation<double> width;
//   int flag = 0;
//   List data;
//   List showData;
//   List selectedData = [];
//   static int i = 0;
//   void initState() {
//     data = widget.data;
//     super.initState();
//     showData = data.take(5).toList();

//     // _buttonController = new AnimationController(
//     //     duration: new Duration(milliseconds: widget.onButtonPressAnimationTime),
//     //     vsync: this);

//     // rotate = new Tween<double>(
//     //   begin: -0.0,
//     //   end: -40.0,
//     // ).animate(
//     //   new CurvedAnimation(
//     //     parent: _buttonController,
//     //     curve: Curves.ease,
//     //   ),
//     // );
//     // rotate.addListener(() {
//     //   setState(() {
//     //     print("rotated");
//     //     if (rotate.isCompleted) {
//     //       print("Completed");
//     //       i++;
//     //       // showData.removeAt(0);
//     //       if (data.length >= 5 + i) {
//     //         var j = data[4 + i];
//     //         showData.add(j);
//     //       }
//     //       _buttonController.reset();
//     //     }
//     //   });
//     // });

//     // right = new Tween<double>(
//     //   begin: 0.0,
//     //   end: 400.0,
//     // ).animate(
//     //   new CurvedAnimation(
//     //     parent: _buttonController,
//     //     curve: Curves.ease,
//     //   ),
//     // );
//     // bottom = new Tween<double>(
//     //   begin: 15.0,
//     //   end: 100.0,
//     // ).animate(
//     //   new CurvedAnimation(
//     //     parent: _buttonController,
//     //     curve: Curves.ease,
//     //   ),
//     // );
//     // width = new Tween<double>(
//     //   begin: 20.0,
//     //   end: 25.0,
//     // ).animate(
//     //   new CurvedAnimation(
//     //     parent: _buttonController,
//     //     curve: Curves.bounceOut,
//     //   ),
//     // );
//   }

//   // @override
//   // void dispose() {
//   //   _buttonController.dispose();
//   //   super.dispose();
//   // }

//   // Future<Null> _swipeAnimation() async {
//   //   try {
//   //     await _buttonController.forward();
//   //   } on TickerCanceled {}
//   // }

//   onGestureSwipeLeft(Widget singleData) {
//     print("onGesture");
//     widget.onSwipeLeft(data.indexOf(singleData));
//     setState(() {
//       i++;
//       showData.removeAt(0);
//       if (data.length >= 5 + i) {
//         var j = data[4 + i];
//         showData.add(j);
//       }
//       showData.removeAt(0);
//     });
//   }

//   onGestureSwipeRight(Widget singleData) {
//     print("onGesture");
//     widget.onSwipeRight(data.indexOf(singleData));
//     setState(() {
//       showData.removeAt(0);
//       i++;
//       if (data.length >= 5 + i) {
//         var j = data[4 + i];
//         showData.add(j);
//       }
//     });
//   }

//   // onButtonPressSwipeRight(Widget singleData) {
//   //   widget.onSwipeRight(data.indexOf(singleData));
//   //   if (flag == 0)
//   //     setState(() {
//   //       showData.removeAt(0);
//   //       flag = 1;
//   //     });
//   //   _swipeAnimation();
//   // }

//   // onButtonPressSwipeLeft(Widget singleData) {
//   //   widget.onSwipeLeft(data.indexOf(singleData));
//   //   if (flag == 1)
//   //     setState(() {
//   //       showData.removeAt(0);
//   //       flag = 0;
//   //     });
//   //   _swipeAnimation();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     timeDilation = 0.4;
//     double initialBottom = 15.0;
//     var dataLength = showData.length;
//     double backCardPosition = initialBottom + (dataLength - 1) * 10 + 10;
//     double backCardWidth = -10.0;
//     return dataLength > 0
//         ? new Stack(
//             alignment: AlignmentDirectional.center,
//             children: showData.reversed.map((item) {
//               if (showData.indexOf(item) == 0) {
//                 return ActiveCard(
//                   data: data,
//                   singleData: item,
//                   bottom: bottom.value,
//                   right: right.value,
//                   left: 0.0,
//                   cardWidth: backCardWidth + 10,
//                   rotation: rotate.value,
//                   skew: rotate.value < -10 ? 0.1 : 0.0,
//                   context: context,
//                   onGestureSwipeLeft: onGestureSwipeLeft,
//                   flag: flag,
//                   onGestureSwipeRight: onGestureSwipeRight,
//                   onCardTap: widget.onCardTap,
//                 );
//               } else {
//                 backCardPosition = backCardPosition - 10;
//                 backCardWidth = backCardWidth + 10;

//                 return cardDemoDummy(item, backCardPosition, 0.0, 0.0,
//                     backCardWidth, 0.0, 0.0, context);
//               }
//             }).toList())
//         : (widget.noCardLeft == null)
//             ? new Text("No Event Left",
//                 style: new TextStyle(color: Colors.white, fontSize: 50.0))
//             : widget.noCardLeft;
//   }
// }
