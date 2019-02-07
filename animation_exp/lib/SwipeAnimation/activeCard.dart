import 'dart:math';
import 'package:flutter/material.dart';

class ActiveCard extends StatelessWidget {
  final List data;
  final Widget singleData;
  final double bottom;
  final double right;
  final double left;
  final double cardWidth;
  final double rotation;
  final double skew;
  final BuildContext context;
  final Function dismissSingleData;
  final int flag;
  final Function addSingleData;
  final Function swipeRight;
  final Function swipeLeft;
  final Function onCardTap;

  ActiveCard(
      {this.data,
      this.singleData,
      this.bottom,
      this.right,
      this.left,
      this.cardWidth,
      this.rotation,
      this.skew,
      this.context,
      this.dismissSingleData,
      this.flag,
      this.addSingleData,
      this.swipeRight,
      this.swipeLeft,
      this.onCardTap});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return new Positioned(
      bottom: 100.0 + bottom,
      right: flag == 0 ? right != 0.0 ? right : null : null,
      left: flag == 1 ? right != 0.0 ? right : null : null,
      child: new Dismissible(
        key: new Key(new Random().toString()),
        crossAxisEndOffset: -0.3,
        onDismissed: (DismissDirection direction) {
          if (direction == DismissDirection.endToStart) {
            dismissSingleData(singleData);
          } else
            addSingleData(singleData);
        },
        child: new Transform(
          alignment: flag == 0 ? Alignment.bottomRight : Alignment.bottomLeft,
          //transform: null,
          transform: new Matrix4.skewX(skew),
          //..rotateX(-math.pi / rotation),
          child: new RotationTransition(
            turns: new AlwaysStoppedAnimation(
                flag == 0 ? rotation / 360 : -rotation / 360),
            child: new Hero(
              tag: "singleData",
              child: new GestureDetector(
                onTap: () {
                  onCardTap(data.indexOf(singleData));
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
                            height: screenSize.height / 1.7 -
                                screenSize.height / 2.2,
                            alignment: Alignment.center,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new FlatButton(
                                    padding: new EdgeInsets.all(0.0),
                                    onPressed: () {
                                      swipeLeft(singleData);
                                    },
                                    child: new Container(
                                      height: 60.0,
                                      width: 130.0,
                                      alignment: Alignment.center,
                                      decoration: new BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            new BorderRadius.circular(60.0),
                                      ),
                                      child: new Text(
                                        "DON'T",
                                        style:
                                            new TextStyle(color: Colors.white),
                                      ),
                                    )),
                                new FlatButton(
                                    padding: new EdgeInsets.all(0.0),
                                    onPressed: () {
                                      swipeRight(singleData);
                                    },
                                    child: new Container(
                                      height: 60.0,
                                      width: 130.0,
                                      alignment: Alignment.center,
                                      decoration: new BoxDecoration(
                                        color: Colors.cyan,
                                        borderRadius:
                                            new BorderRadius.circular(60.0),
                                      ),
                                      child: new Text(
                                        "I'M IN",
                                        style:
                                            new TextStyle(color: Colors.white),
                                      ),
                                    ))
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Positioned cardDemo(
//   List data,
//   Widget singleData,
//   double bottom,
//   double right,
//   double left,
//   double cardWidth,
//   double rotation,
//   double skew,
//   BuildContext context,
//   Function dismisssingleData,
//   int flag,
//   Function addsingleData,
//   Function swipeRight,
//   Function swipeLeft,
//   Function onCardTap,
// ) {
//   Size screenSize = MediaQuery.of(context).size;
//   // print("Card");
//   return new Positioned(
//     bottom: 100.0 + bottom,
//     right: flag == 0 ? right != 0.0 ? right : null : null,
//     left: flag == 1 ? right != 0.0 ? right : null : null,
//     child: new Dismissible(
//       key: new Key(new Random().toString()),
//       crossAxisEndOffset: -0.3,
//       onDismissed: (DismissDirection direction) {
//         if (direction == DismissDirection.endToStart) {
//           dismisssingleData(singleData);
//         } else
//           addsingleData(singleData);
//       },
//       child: new Transform(
//         alignment: flag == 0 ? Alignment.bottomRight : Alignment.bottomLeft,
//         //transform: null,
//         transform: new Matrix4.skewX(skew),
//         //..rotateX(-math.pi / rotation),
//         child: new RotationTransition(
//           turns: new AlwaysStoppedAnimation(
//               flag == 0 ? rotation / 360 : -rotation / 360),
//           child: new Hero(
//             tag: "singleData",
//             child: new GestureDetector(
//               onTap: () {
//                 onCardTap(data.indexOf(singleData));
//               },
//               child: new Card(
//                 color: Colors.transparent,
//                 elevation: 4.0,
//                 child: new Container(
//                   alignment: Alignment.center,
//                   width: screenSize.width / 1.2 + cardWidth,
//                   height: screenSize.height / 1.7,
//                   decoration: new BoxDecoration(
//                     color: new Color.fromRGBO(121, 114, 173, 1.0),
//                     borderRadius: new BorderRadius.circular(8.0),
//                   ),
//                   child: new Column(
//                     children: <Widget>[
//                       new Container(
//                         width: screenSize.width / 1.2 + cardWidth,
//                         height: screenSize.height / 2.2,
//                         decoration: new BoxDecoration(
//                           borderRadius: new BorderRadius.only(
//                               topLeft: new Radius.circular(8.0),
//                               topRight: new Radius.circular(8.0)),
//                         ),
//                         child: singleData,
//                       ),
//                       new Container(
//                           width: screenSize.width / 1.2 + cardWidth,
//                           height:
//                               screenSize.height / 1.7 - screenSize.height / 2.2,
//                           alignment: Alignment.center,
//                           child: new Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: <Widget>[
//                               new FlatButton(
//                                   padding: new EdgeInsets.all(0.0),
//                                   onPressed: () {
//                                     swipeLeft(singleData);
//                                   },
//                                   child: new Container(
//                                     height: 60.0,
//                                     width: 130.0,
//                                     alignment: Alignment.center,
//                                     decoration: new BoxDecoration(
//                                       color: Colors.red,
//                                       borderRadius:
//                                           new BorderRadius.circular(60.0),
//                                     ),
//                                     child: new Text(
//                                       "DON'T",
//                                       style: new TextStyle(color: Colors.white),
//                                     ),
//                                   )),
//                               new FlatButton(
//                                   padding: new EdgeInsets.all(0.0),
//                                   onPressed: () {
//                                     swipeRight(singleData);
//                                   },
//                                   child: new Container(
//                                     height: 60.0,
//                                     width: 130.0,
//                                     alignment: Alignment.center,
//                                     decoration: new BoxDecoration(
//                                       color: Colors.cyan,
//                                       borderRadius:
//                                           new BorderRadius.circular(60.0),
//                                     ),
//                                     child: new Text(
//                                       "I'M IN",
//                                       style: new TextStyle(color: Colors.white),
//                                     ),
//                                   ))
//                             ],
//                           ))
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }
