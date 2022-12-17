import 'dart:async';
import 'dart:ui';

import 'package:animation_exp/PageReveal/page_indicator.dart';
import 'package:flutter/material.dart';

class PageDragger extends StatefulWidget {
  final canDragRightToLeft;
  final canDragLeftToRight;
  final StreamController<SlideUpdate> slideUpdateSytream;

  PageDragger(
      {this.canDragLeftToRight,
      this.canDragRightToLeft,
      this.slideUpdateSytream});

  @override
  _PageDraggerState createState() => _PageDraggerState();
}

class _PageDraggerState extends State<PageDragger> {
  static const FULL_TRANSITION_PX = 300.0;

  Offset? dragStart;
  SlideDirection? slideDirection;
  double slidePercent = 0.0;
  onDragStart(DragStartDetails details) {
    dragStart = details.globalPosition;
  }

  onDragUpdate(DragUpdateDetails details) {
    if (dragStart != null) {
      final newPosition = details.globalPosition;
      final dx = dragStart.dx - newPosition.dx;
      if (dx > 0.0 && widget.canDragRightToLeft) {
        slideDirection = SlideDirection.rightToLeft;
      } else if (dx < 0.0 && widget.canDragLeftToRight) {
        slideDirection = SlideDirection.leftToRight;
      } else {
        slideDirection = SlideDirection.none;
      }

      if (slideDirection != SlideDirection.none) {
        slidePercent = (dx / FULL_TRANSITION_PX).abs().clamp(0.0, 1.0);
      } else {
        slidePercent = 0.0;
      }

      widget.slideUpdateSytream.add(
          SlideUpdate(UpdateType.dragging, slidePercent, slideDirection));
    }
  }

  onDragEnd(DragEndDetails details) {
    widget.slideUpdateSytream.add(
        SlideUpdate(UpdateType.doneDragging, 0.0, SlideDirection.none));

    dragStart = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: onDragStart,
      onHorizontalDragUpdate: onDragUpdate,
      onHorizontalDragEnd: onDragEnd,
    );
  }
}

class AnimatedPagedragger {
  static const PERCENT_PER_MILLISECOND = 0.005;

  final slideDirection;
  final transitionGoal;

  AnimationController completionAnimationController;

  AnimatedPagedragger({
    this.slideDirection,
    this.transitionGoal,
    slidePercent,
    StreamController<SlideUpdate> slideUpdateStream,
    TickerProvider vsync,
  }) {
    var startSlidePercent = slidePercent;
    var endSlidePercent;
    var duration;

    if (transitionGoal == TransitionGoal.open) {
      endSlidePercent = 1.0;

      final slideRemaining = 1.0 - slidePercent;
      duration = Duration(
          milliseconds: (slideRemaining / PERCENT_PER_MILLISECOND).round());
    } else {
      endSlidePercent = 0.0;
      duration = Duration(
          milliseconds: (slidePercent / PERCENT_PER_MILLISECOND).round());
    }

    completionAnimationController =
        new AnimationController(vsync: vsync, duration: duration)
          ..addListener(() {
            final slidePercent = lerpDouble(startSlidePercent, endSlidePercent,
                completionAnimationController.value);
            slideUpdateStream.add(SlideUpdate(
                UpdateType.animating, slidePercent, slideDirection));
          })
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.completed) {
              slideUpdateStream.add(SlideUpdate(
                  UpdateType.doneAnimating, endSlidePercent, slideDirection));
            }
          });
  }
  run() {
    completionAnimationController.forward(from: 0.0);
  }

  dispose() {
    completionAnimationController.dispose();
  }
}

enum TransitionGoal {
  open,
  close,
}

enum UpdateType {
  dragging,
  doneDragging,
  animating,
  doneAnimating,
}

class SlideUpdate {
  final updateType;
  final direction;
  final slidePercent;

  SlideUpdate(this.updateType, this.slidePercent, this.direction);
}
