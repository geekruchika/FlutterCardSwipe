import 'package:flutter/material.dart';

class Cards extends StatefulWidget {
  final Offset initialPosition;
  final Function swipeRight;
  final Function swipeLeft;
  final double velocityToSwipe = 1000;
  final Widget child;
  final bool isActive;
  final Widget onTapSwipeRight;
  final Widget onTapSwipeLeft;
  Cards({
    Key key,
    @required this.swipeRight,
    @required this.swipeLeft,
    @required this.child,
    this.isActive = true,
    this.initialPosition = const Offset(50, 50),
    this.onTapSwipeRight,
    this.onTapSwipeLeft,
  }) : super(key: key);

  @override
  CardsState createState() {
    return new CardsState();
  }
}

class CardsState extends State<Cards> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Offset previousOffset;
  Offset currentOffset;
  DragUpdateDetails position;
  int flag = 0;
  double top = 0;
  double left = 0;
  double angle = 0;

  @override
  void initState() {
    print("inside init");
    controller = new AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    previousOffset = widget.initialPosition;
    currentOffset = widget.initialPosition;
    top = widget.initialPosition.dy;
    left = widget.initialPosition.dx;
    position = DragUpdateDetails(globalPosition: widget.initialPosition);

    super.initState();
  }

  void initialize() {
    // flag = 0;
    // angle = 0;
    // previousOffset = widget.initialPosition;
    // currentOffset = widget.initialPosition;
    // top = widget.initialPosition.dy;
    // left = widget.initialPosition.dx;
    // position = DragUpdateDetails(globalPosition: widget.initialPosition);
  }

  @override
  Widget build(BuildContext context) {
    print("inside gesture build");
    return Positioned(
      top: top,
      left: left,
      child: widget.isActive
          ? GestureDetector(
              onPanStart: (DragStartDetails details) {
                currentOffset = Offset(
                    details.globalPosition.dx, details.globalPosition.dy);
              },
              onPanUpdate: (DragUpdateDetails details) {
                setState(() {
                  position = details;
                });
                top = position.globalPosition.dy -
                    (currentOffset.dy - previousOffset.dy);
                left = (position.globalPosition.dx -
                    (currentOffset.dx - previousOffset.dx));
                angle = (position.globalPosition.dx - currentOffset.dx) / 360;
              },
              onPanEnd: (DragEndDetails details) async {
                print(details.velocity.pixelsPerSecond.dx);
                if (angle > 0.50 ||
                    details.velocity.pixelsPerSecond.dx >
                        widget.velocityToSwipe) {
                  print("swipe Right");
                  animation = new Tween<double>(begin: angle, end: 1.0)
                      .animate(controller)
                        ..addListener(() {
                          setState(() {
                            top = top - 100 * animation.value;
                            left = left + 250 * animation.value;
                          });
                        });

                  setState(() {
                    flag = 1;
                  });
                  await controller.forward();

                  await widget.swipeRight();

                  initialize();
                } else if (angle < -0.50 ||
                    details.velocity.pixelsPerSecond.dx <
                        -widget.velocityToSwipe) {
                  print("swipe Left");
                  animation = new Tween<double>(begin: -angle, end: 1.0)
                      .animate(controller)
                        ..addListener(() {
                          setState(() {
                            top = top - 100 * animation.value;
                            left = left - 250 * animation.value;
                          });
                        });
                  setState(() {
                    flag = -1;
                  });
                  await controller.forward();
                  widget.swipeLeft();

                  initialize();
                } else
                  setState(() {
                    angle = 0;
                    previousOffset = Offset(
                        widget.initialPosition.dx, widget.initialPosition.dy);
                    currentOffset = Offset(
                        widget.initialPosition.dx, widget.initialPosition.dy);
                    top = widget.initialPosition.dy;
                    left = widget.initialPosition.dx;
                  });
              },
              child: Transform.rotate(
                angle: (flag == 0
                    ? angle
                    : (flag == 1 ? animation.value : -animation.value)),
                child: Column(children: <Widget>[
                  widget.child,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          print("swipe Left");
                          animation = new Tween<double>(begin: -angle, end: 1.0)
                              .animate(controller)
                                ..addListener(() {
                                  setState(() {
                                    top = top - 100 * animation.value;
                                    left = left - 250 * animation.value;
                                  });
                                });
                          setState(() {
                            flag = -1;
                          });
                          await controller.forward();
                          widget.swipeLeft();

                          initialize();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                          height: 50,
                          width: 150,
                          child: Center(
                            child: Text(
                              "Swipe Left",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          print("swipe Right");

                          animation = new Tween<double>(begin: angle, end: 1.0)
                              .animate(controller)
                                ..addListener(() {
                                  setState(() {
                                    top = top - 100 * animation.value;
                                    left = left + 250 * animation.value;
                                  });
                                });

                          setState(() {
                            flag = 1;
                          });
                          await controller.forward();
                          widget.swipeRight();
                          initialize();
                        },
                        child: Container(
                          decoration: BoxDecoration(color: Colors.black),
                          height: 50,
                          width: 150,
                          child: Center(
                            child: Text(
                              "Swipe Right",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ]),
              ),
            )
          : Column(children: <Widget>[
              widget.child,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      height: 50,
                      width: 150,
                      child: Center(
                        child: Text(
                          "Behind Swipe Left",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(color: Colors.black),
                      height: 50,
                      width: 150,
                      child: Center(
                        child: Text(
                          "Behind Swipe Right",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ]),
    );
  }
}
