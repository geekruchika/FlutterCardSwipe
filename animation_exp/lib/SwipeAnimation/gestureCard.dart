import 'package:flutter/material.dart';

class GestureCard extends StatefulWidget {
  final Offset initialPosition;
  final Function swipeRight;
  final Function swipeLeft;
  final double velocityToSwipe;
  final Widget child;
  final bool isActive;
  final Widget rightSwipeButton;
  final Widget leftSwipeButton;
  final Duration animationTime;

  GestureCard({
    Key key,
    @required this.swipeRight,
    @required this.swipeLeft,
    @required this.child,
    this.isActive = true,
    this.initialPosition,
    this.leftSwipeButton,
    this.rightSwipeButton,
    this.velocityToSwipe,
    this.animationTime,
  }) : super(key: key);

  @override
  GestureCardState createState() {
    return new GestureCardState();
  }
}

class GestureCardState extends State<GestureCard>
    with SingleTickerProviderStateMixin {
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
    controller = new AnimationController(
      duration: widget.animationTime,
      vsync: this,
    );
    previousOffset = widget.initialPosition;
    currentOffset = widget.initialPosition;
    top = widget.initialPosition.dy;
    left = widget.initialPosition.dx;
    position = DragUpdateDetails(globalPosition: widget.initialPosition);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: top,
        left: left,
        child: GestureDetector(
          onPanStart: (DragStartDetails details) {
            currentOffset =
                Offset(details.globalPosition.dx, details.globalPosition.dy);
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
            if (angle > 0.50 ||
                details.velocity.pixelsPerSecond.dx > widget.velocityToSwipe) {
              animation =
                  new Tween<double>(begin: angle, end: 1.0).animate(controller)
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
            } else if (angle < -0.50 ||
                details.velocity.pixelsPerSecond.dx < -widget.velocityToSwipe) {
              animation =
                  new Tween<double>(begin: -angle, end: 1.0).animate(controller)
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
              widget.leftSwipeButton != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                            onTap: () async {
                              animation =
                                  new Tween<double>(begin: -angle, end: 1.0)
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
                            },
                            child: widget.leftSwipeButton),
                        GestureDetector(
                          onTap: () async {
                            animation =
                                new Tween<double>(begin: angle, end: 1.0)
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
                          },
                          child: widget.rightSwipeButton,
                        )
                      ],
                    )
                  : SizedBox(
                      height: 0,
                      width: 0,
                    )
            ]),
          ),
        ));
  }
}
