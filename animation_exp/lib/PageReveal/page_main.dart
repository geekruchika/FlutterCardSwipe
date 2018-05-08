import 'dart:async';

import 'package:animation_exp/PageReveal/page_dragger.dart';
import 'package:animation_exp/PageReveal/page_indicator.dart';
import 'package:animation_exp/PageReveal/page_reveal.dart';
import 'package:animation_exp/PageReveal/pages.dart';
import 'package:flutter/material.dart';

class PageMain extends StatefulWidget {
  @override
  PageMainState createState() => new PageMainState();
}

class PageMainState extends State<PageMain> with TickerProviderStateMixin {
  StreamController<SlideUpdate> slideUpdateStream;
  AnimatedPagedragger animatedPagedragger;

  int activeIndex = 0;
  int nextPageIndex = 0;
  SlideDirection slideDirection = SlideDirection.none;
  double slidePercent = 0.0;

  PageMainState() {
    slideUpdateStream = new StreamController<SlideUpdate>();

    slideUpdateStream.stream.listen((SlideUpdate event) {
      setState(() {
        if (event.updateType == UpdateType.dragging) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;

          if (slideDirection == SlideDirection.leftToRight) {
            nextPageIndex = activeIndex - 1;
          } else if (slideDirection == SlideDirection.rightToLeft) {
            nextPageIndex = activeIndex + 1;
          } else {
            nextPageIndex = activeIndex;
          }

//         nextPageIndex=slideDirection==SlideDirection.leftToRight ? activeIndex-1 : activeIndex+1;
//
//         nextPageIndex.clamp(0.0, pages.length-1);
        } else if (event.updateType == UpdateType.animating) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
        } else if (event.updateType == UpdateType.doneDragging) {
          if (slidePercent > 0.5) {
            animatedPagedragger = new AnimatedPagedragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.open,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );

//           activeIndex=slideDirection==SlideDirection.leftToRight ? activeIndex-1 : activeIndex+1;
//           activeIndex.clamp(0.0, pages.length-1);
          } else {
            animatedPagedragger = new AnimatedPagedragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.close,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
            nextPageIndex = activeIndex;
          }
          animatedPagedragger.run();

//         slideDirection=SlideDirection.none;
//       slidePercent=0.0;

        } else if (event.updateType == UpdateType.doneAnimating) {
          activeIndex = nextPageIndex;
          slideDirection = SlideDirection.none;
          slidePercent = 0.0;
          animatedPagedragger.dispose();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(slidePercent);
    return (new Scaffold(
        body: new Stack(
      children: <Widget>[
        new Page(
          viewModel: pages[activeIndex],
          percentVisible: 1.0,
        ),
        new PageReveal(
          revealPercent: slidePercent,
          child: new Page(
            viewModel: pages[nextPageIndex],
            percentVisible: slidePercent,
          ),
        ),
        new PagerIndicator(
          viewModel: new PagerIndicatorViewModel(
              slideDirection, activeIndex, pages, slidePercent),
        ),
        new PageDragger(
          canDragLeftToRight: activeIndex > 0,
          canDragRightToLeft: activeIndex < pages.length - 1,
          slideUpdateSytream: this.slideUpdateStream,
        )
      ],
    )));
  }
}
