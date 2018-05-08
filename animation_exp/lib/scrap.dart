import 'package:flutter/material.dart';

class NavigationIconView {
  NavigationIconView({
    Widget icon,
    String title,
    Color color,
    TickerProvider vsync,
  })  : _icon = icon,
        _color = color,
        _title = title,
        item = new BottomNavigationBarItem(
          icon: icon,
          title: new Text(title),
          backgroundColor: color,
        ),
        controller = new AnimationController(
          duration: kThemeAnimationDuration,
          vsync: vsync,
        ) {
    _animation = new CurvedAnimation(
      parent: controller,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
  }

  final Widget _icon;
  final Color _color;
  final String _title;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  CurvedAnimation _animation;

  FadeTransition transition(
      BottomNavigationBarType type, BuildContext context) {
    Color iconColor;
    if (type == BottomNavigationBarType.shifting) {
      iconColor = _color;
    } else {
      final ThemeData themeData = Theme.of(context);
      iconColor = themeData.brightness == Brightness.light
          ? themeData.primaryColor
          : themeData.accentColor;
    }

    return new FadeTransition(
      opacity: _animation,
      child: new SlideTransition(
        position: new Tween<Offset>(
          begin: const Offset(0.0, 0.02), // Slightly down.
          end: Offset.zero,
        ).animate(_animation),
        child: new IconTheme(
          data: new IconThemeData(
            color: iconColor,
            size: 120.0,
          ),
          child: new Semantics(
            label: 'Placeholder for $_title tab',
            child: _icon,
          ),
        ),
      ),
    );
  }
}

class CustomIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    return new Container(
      margin: const EdgeInsets.all(4.0),
      width: iconTheme.size - 8.0,
      height: iconTheme.size - 8.0,
      color: iconTheme.color,
    );
  }
}

class BottomNavigationDemo extends StatefulWidget {
  //static const String routeName = '/material/bottom_navigation';

  @override
  _BottomNavigationDemoState createState() => new _BottomNavigationDemoState();
}

class _BottomNavigationDemoState extends State<BottomNavigationDemo>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.shifting;
  List<NavigationIconView> _navigationViews;

  @override
  void initState() {
    super.initState();
    _navigationViews = <NavigationIconView>[
      new NavigationIconView(
        icon: const Icon(Icons.access_alarm),
        title: 'Alarm',
        color: Colors.deepPurple,
        vsync: this,
      ),
      new NavigationIconView(
        icon: new CustomIcon(),
        title: 'Box',
        color: Colors.deepOrange,
        vsync: this,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.cloud),
        title: 'Cloud',
        color: Colors.teal,
        vsync: this,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.favorite),
        title: 'Favorites',
        color: Colors.indigo,
        vsync: this,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.event_available),
        title: 'Event',
        color: Colors.pink,
        vsync: this,
      )
    ];

    for (NavigationIconView view in _navigationViews)
      view.controller.addListener(_rebuild);

    _navigationViews[_currentIndex].controller.value = 1.0;
  }

  @override
  void dispose() {
    for (NavigationIconView view in _navigationViews) view.controller.dispose();
    super.dispose();
  }

  void _rebuild() {
    setState(() {
      // Rebuild in order to animate views.
    });
  }

  Widget _buildTransitionsStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];

    for (NavigationIconView view in _navigationViews)
      transitions.add(view.transition(_type, context));

    // We want to have the newly animating (fading in) views on top.
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return new Stack(children: transitions);
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = new BottomNavigationBar(
      items: _navigationViews
          .map((NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: _type,
      onTap: (int index) {
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
        });
      },
    );

    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Bottom navigation'),
        actions: <Widget>[
          new PopupMenuButton<BottomNavigationBarType>(
            onSelected: (BottomNavigationBarType value) {
              setState(() {
                _type = value;
              });
            },
            itemBuilder: (BuildContext context) =>
                <PopupMenuItem<BottomNavigationBarType>>[
                  const PopupMenuItem<BottomNavigationBarType>(
                    value: BottomNavigationBarType.fixed,
                    child: const Text('Fixed'),
                  ),
                  const PopupMenuItem<BottomNavigationBarType>(
                    value: BottomNavigationBarType.shifting,
                    child: const Text('Shifting'),
                  )
                ],
          )
        ],
      ),
      body: new Center(child: _buildTransitionsStack()),
      bottomNavigationBar: botNavBar,
    );
  }
}

// <Widget>[

//   cardDemo(image1, 35.0, 0.0, 0.0, 0.0, 0.0, 1),
//   cardDemo(image2, 25.0, 0.0, 10.0, 0.0, 0.0, 1),
//   cardDemo(image3, bottom.value, right.value, 20.0,
//       rotate.value, rotate.value < -10 ? 0.1 : 0.0, 12)
// ],
// cardDemo(image3, 15.0, 20.0, rotate.value, rotate.value<-10?0.1:0.0, 12)
//  Positioned con(double i, double j) {
//    return new Positioned(
//      bottom: 200.0 + j + 60,
//      right: 300.0,
//      child: new RotationTransition(
//        turns: new AlwaysStoppedAnimation(-55 / 360),
//        child: new Card(
//          color: Colors.transparent,
//          elevation: 10.0,
//          child: new Container(
//            width: 200.0 + i,
//            height: 250.0,
//            decoration: new BoxDecoration(
//                color: Colors.amberAccent,
//                borderRadius: new BorderRadius.circular(6.0),
//                border: new Border.all(color: Colors.black)),
//          ),
//        ),
//      ),
//    );
//  }
// import 'package:flutter/material.dart';
//

// void main() {
//   runApp(new MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       home: new MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePageState createState() => new MyHomePageState();
// }

// class MyCustomCard extends StatelessWidget {
//   MyCustomCard({this.colors});

//   final MaterialColor colors;

//   Widget build(BuildContext context) {
//     return new Container(
//       alignment: FractionalOffset.center,
//       height: 144.0,
//       width: 360.0,
//       decoration: new BoxDecoration(
//         color: colors.shade50,
//         border: new Border.all(color: new Color(0xFF9E9E9E)),
//       ),
//       child: new FlutterLogo(size: 100.0, colors: colors),
//     );
//   }
// }

// class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
//   AnimationController _controller;
//   Animation<double> _frontScale;
//   Animation<double> _backScale;

//   @override
//   void initState() {
//     super.initState();
//     _controller = new AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     );
//     _frontScale = new Tween(
//       begin: 1.0,
//       end: 0.0,
//     ).animate(new CurvedAnimation(
//       parent: _controller,
//       curve: new Interval(0.0, 0.5, curve: Curves.easeIn),
//     ));
//     _backScale = new CurvedAnimation(
//       parent: _controller,
//       curve: new Interval(0.5, 1.0, curve: Curves.easeOut),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("back${_backScale.value}");
//     print("front${_frontScale.value}");
//     print("Controller${_controller.value}");

//     return new Scaffold(
//       floatingActionButton: new FloatingActionButton(
//         child: new Icon(Icons.flip_to_back),
//         onPressed: () {
//           setState(() {
//             if (_controller.isCompleted || _controller.velocity > 0)
//               _controller.reverse();
//             else
//               _controller.forward();
//           });
//         },
//       ),
//       body: new ListView(children: <Widget>[
//         // new Center(
//         //   child: new Container(
//         //     color: Colors.black,
//         //     child: new Transform(
//         //       alignment: Alignment.topRight,
//         //       transform: new Matrix4.skewX(0.3)..rotateX(-math.pi / 12.0),
//         //       child: new Container(
//         //         padding: const EdgeInsets.all(8.0),
//         //         color: const Color(0xFFE8581C),
//         //         child: const Text('Apartment for rent!'),
//         //       ),
//         //     ),
//         //   ),
//         // ),
//         // new Center(
//         //   child: new Stack(
//         //     children: <Widget>[
//         //       new AnimatedBuilder(
//         //         child: new MyCustomCard(colors: Colors.orange),
//         //         animation: _backScale,
//         //         builder: (BuildContext context, Widget child) {
//         //           final Matrix4 transform = new Matrix4.identity()
//         //             ..scale(1.0, _backScale.value, 1.0);
//         //           return new Transform(
//         //             transform: transform,
//         //             alignment: FractionalOffset.center,
//         //             child: child,
//         //           );
//         //         },
//         //       ),
//         //       new AnimatedBuilder(
//         //         child: new MyCustomCard(colors: Colors.blue),
//         //         animation: _frontScale,
//         //         builder: (BuildContext context, Widget child) {
//         //           final Matrix4 transform = new Matrix4.identity()
//         //             ..scale(1.0, _frontScale.value, 1.0);
//         //           return new Transform(
//         //             transform: transform,
//         //             alignment: FractionalOffset.center,
//         //             child: child,
//         //           );
//         //         },
//         //       ),
//         //     ],
//         //   ),
//         // ),
//         new Center(
//             child: new Container(
//           color: Colors.black,
//           child: new Stack(
//             children: <Widget>[
//               new AnimatedBuilder(
//                 child: new Transform(
//                   alignment: Alignment.topRight,
//                   transform: new Matrix4.skewX(0.3)..rotateX(-math.pi / 12.0),
//                   child: new Container(
//                     width: 150.0,
//                     padding: const EdgeInsets.all(8.0),
//                     color: const Color(0xFFE8581C),
//                     child: const Text('Apartment for rent!'),
//                   ),
//                 ),
//                 animation: _backScale,
//                 builder: (BuildContext context, Widget child) {
//                   final Matrix4 transform = new Matrix4.identity()
//                     ..scale(1.0, _backScale.value, 1.0);
//                   return new Transform(
//                     transform: transform,
//                     alignment: FractionalOffset.center,
//                     child: child,
//                   );
//                 },
//               ),
//               new AnimatedBuilder(
//                 child: new Transform(
//                   alignment: Alignment.topRight,
//                   transform: new Matrix4.skewX(0.3)..rotateX(-math.pi / 12.0),
//                   child: new Container(
//                     width: 150.0,
//                     padding: const EdgeInsets.all(8.0),
//                     color: const Color(0xFFE8581C),
//                     child: const Text('hiiiii!'),
//                   ),
//                 ),
//                 animation: _frontScale,
//                 builder: (BuildContext context, Widget child) {
//                   final Matrix4 transform = new Matrix4.identity()
//                     ..scale(1.0, _frontScale.value, 1.0);
//                   return new Transform(
//                     transform: transform,
//                     alignment: FractionalOffset.center,
//                     child: child,
//                   );
//                 },
//               ),
//             ],
//           ),
//         )),
//       ]),
//     );
//   }
// }
// // import 'dart:math' as math;

// // import 'package:flutter/animation.dart';
// // import 'package:flutter/rendering.dart';
// // import 'package:flutter/scheduler.dart';

// // class NonStopVSync implements TickerProvider {
// //   const NonStopVSync();
// //   @override
// //   Ticker createTicker(TickerCallback onTick) => new Ticker(onTick);
// // }

// // void main() {
// //   // We first create a render object that represents a green box.
// //   final RenderBox green = new RenderDecoratedBox(
// //       decoration: const BoxDecoration(color: const Color(0xFF00FF00)));
// //   // Second, we wrap that green box in a render object that forces the green box
// //   // to have a specific size.
// //   final RenderBox square = new RenderConstrainedBox(
// //       additionalConstraints:
// //           const BoxConstraints.tightFor(width: 200.0, height: 200.0),
// //       child: green);
// //   // Third, we wrap the sized green square in a render object that applies rotation
// //   // transform before painting its child. Each frame of the animation, we'll
// //   // update the transform of this render object to cause the green square to
// //   // spin.
// //   final RenderTransform spin = new RenderTransform(
// //       transform: new Matrix4.identity(),
// //       alignment: Alignment.center,
// //       child: square);
// //   // Finally, we center the spinning green square...
// //   final RenderBox root =
// //       new RenderPositionedBox(alignment: Alignment.center, child: spin);
// //   // and attach it to the window.
// //   new RenderingFlutterBinding(root: root);

// //   // To make the square spin, we use an animation that repeats every 1800
// //   // milliseconds.
// //   final AnimationController animation = new AnimationController(
// //     duration: const Duration(milliseconds: 1800),
// //     vsync: const NonStopVSync(),
// //   )..repeat();
// //   // The animation will produce a value between 0.0 and 1.0 each frame, but we
// //   // want to rotate the square using a value between 0.0 and math.pi. To change
// //   // the range of the animation, we use a Tween.
// //   final Tween<double> tween = new Tween<double>(begin: 0.0, end: math.pi);
// //   // We add a listener to the animation, which will be called every time the
// //   // animation ticks.
// //   animation.addListener(() {
// //     // This code runs every tick of the animation and sets a new transform on
// //     // the "spin" render object by evaluating the tween on the current value
// //     // of the animation. Setting this value will mark a number of dirty bits
// //     // inside the render tree, which cause the render tree to repaint with the
// //     // new transform value this frame.
// //     spin.transform = new Matrix4.rotationZ(tween.evaluate(animation));
// //   });
// // }
//   Positioned cardDemoDummy(DecorationImage img, double bottom, double right,
//       double left, double cardWidth, double rotation, double skew) {
//     Size screenSize = MediaQuery.of(context).size;
//     print("dummyCard");
//     return new Positioned(
//       bottom: 100.0 + bottom,
//       // right: flag == 0 ? right != 0.0 ? right : null : null,
//       //left: flag == 1 ? right != 0.0 ? right : null : null,
//       child: new Card(
//         color: Colors.transparent,
//         elevation: 4.0,
//         child: new Container(
//           alignment: Alignment.center,
//           width: screenSize.width / 1.2 + cardWidth,
//           height: screenSize.height / 1.7,
//           decoration: new BoxDecoration(
//             color: new Color.fromRGBO(121, 114, 173, 1.0),
//             borderRadius: new BorderRadius.circular(8.0),
//           ),
//           child: new Column(
//             children: <Widget>[
//               new Container(
//                 width: screenSize.width / 1.2 + cardWidth,
//                 height: screenSize.height / 2.2,
//                 decoration: new BoxDecoration(
//                   borderRadius: new BorderRadius.only(
//                       topLeft: new Radius.circular(8.0),
//                       topRight: new Radius.circular(8.0)),
//                   image: img,
//                 ),
//               ),
//               new Container(
//                   width: screenSize.width / 1.2 + cardWidth,
//                   height: screenSize.height / 1.7 - screenSize.height / 2.2,
//                   alignment: Alignment.center,
//                   child: new Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       new FlatButton(
//                           padding: new EdgeInsets.all(0.0),
//                           onPressed: () {},
//                           child: new Container(
//                             height: 60.0,
//                             width: 130.0,
//                             alignment: Alignment.center,
//                             decoration: new BoxDecoration(
//                               color: Colors.red,
//                               borderRadius: new BorderRadius.circular(60.0),
//                             ),
//                             child: new Text(
//                               "DON'T",
//                               style: new TextStyle(color: Colors.white),
//                             ),
//                           )),
//                       new FlatButton(
//                           padding: new EdgeInsets.all(0.0),
//                           onPressed: () {},
//                           child: new Container(
//                             height: 60.0,
//                             width: 130.0,
//                             alignment: Alignment.center,
//                             decoration: new BoxDecoration(
//                               color: Colors.cyan,
//                               borderRadius: new BorderRadius.circular(60.0),
//                             ),
//                             child: new Text(
//                               "I'M IN",
//                               style: new TextStyle(color: Colors.white),
//                             ),
//                           ))
//                     ],
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   Positioned cardDemo(DecorationImage img, double bottom, double right,
//       double left, double cardWidth, double rotation, double skew) {
//     Size screenSize = MediaQuery.of(context).size;
//     print("Card");
//     return new Positioned(
//       bottom: 100.0 + bottom,
//       right: flag == 0 ? right != 0.0 ? right : null : null,
//       left: flag == 1 ? right != 0.0 ? right : null : null,
//       child: new Dismissible(
//         key: new Key(new Random().toString()),
//         crossAxisEndOffset: -0.3,
//         onResize: () {
//           //print("here");
//           // setState(() {
//           //   var i = data.removeLast();

//           //   data.insert(0, i);
//           // });
//         },
//         onDismissed: (DismissDirection direction) {
// //          _swipeAnimation();
//           if (direction == DismissDirection.endToStart)
//             dismissImg(img);
//           else
//             addImg(img);
//         },
//         child: new Transform(
//           alignment: flag == 0 ? Alignment.bottomRight : Alignment.bottomLeft,
//           //transform: null,
//           transform: new Matrix4.skewX(skew),
//           //..rotateX(-math.pi / rotation),
//           child: new RotationTransition(
//             turns: new AlwaysStoppedAnimation(
//                 flag == 0 ? rotation / 360 : -rotation / 360),
//             child: new Hero(
//               tag: "img",
//               child: new GestureDetector(
//                 onTap: () {
//                   print("card clicked");
//                   // Navigator.push(
//                   //     context,
//                   //     new MaterialPageRoute(
//                   //         builder: (context) => new DetailPage(type: img)));
//                   Navigator.of(context).push(new PageRouteBuilder(
//                         pageBuilder: (_, __, ___) => new DetailPage(type: img),
//                       ));
//                 },
//                 child: new Card(
//                   color: Colors.transparent,
//                   elevation: 4.0,
//                   child: new Container(
//                     alignment: Alignment.center,
//                     width: screenSize.width / 1.2 + cardWidth,
//                     height: screenSize.height / 1.7,
//                     decoration: new BoxDecoration(
//                       color: new Color.fromRGBO(121, 114, 173, 1.0),
//                       borderRadius: new BorderRadius.circular(8.0),
//                     ),
//                     child: new Column(
//                       children: <Widget>[
//                         new Container(
//                           width: screenSize.width / 1.2 + cardWidth,
//                           height: screenSize.height / 2.2,
//                           decoration: new BoxDecoration(
//                             borderRadius: new BorderRadius.only(
//                                 topLeft: new Radius.circular(8.0),
//                                 topRight: new Radius.circular(8.0)),
//                             image: img,
//                           ),
//                         ),
//                         new Container(
//                             width: screenSize.width / 1.2 + cardWidth,
//                             height: screenSize.height / 1.7 -
//                                 screenSize.height / 2.2,
//                             alignment: Alignment.center,
//                             child: new Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: <Widget>[
//                                 new FlatButton(
//                                     padding: new EdgeInsets.all(0.0),
//                                     onPressed: () {
//                                       if (flag == 1)
//                                         setState(() {
//                                           flag = 0;
//                                         });
//                                       _swipeAnimation();
//                                     },
//                                     child: new Container(
//                                       height: 60.0,
//                                       width: 130.0,
//                                       alignment: Alignment.center,
//                                       decoration: new BoxDecoration(
//                                         color: Colors.red,
//                                         borderRadius:
//                                             new BorderRadius.circular(60.0),
//                                       ),
//                                       child: new Text(
//                                         "DON'T",
//                                         style:
//                                             new TextStyle(color: Colors.white),
//                                       ),
//                                     )),
//                                 new FlatButton(
//                                     padding: new EdgeInsets.all(0.0),
//                                     onPressed: () {
//                                       if (flag == 0)
//                                         setState(() {
//                                           flag = 1;
//                                         });
//                                       _swipeAnimation();
//                                     },
//                                     child: new Container(
//                                       height: 60.0,
//                                       width: 130.0,
//                                       alignment: Alignment.center,
//                                       decoration: new BoxDecoration(
//                                         color: Colors.cyan,
//                                         borderRadius:
//                                             new BorderRadius.circular(60.0),
//                                       ),
//                                       child: new Text(
//                                         "I'M IN",
//                                         style:
//                                             new TextStyle(color: Colors.white),
//                                       ),
//                                     ))
//                               ],
//                             ))
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
