import 'dart:async';
import 'dart:math';

import 'package:animation_exp/SwipeAnimation/detail.dart';
import 'package:animation_exp/SwipeAnimation/styles.dart';
import 'package:animation_exp/PageReveal/page_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class CardDemo extends StatefulWidget {
  @override
  CardDemoState createState() => new CardDemoState();
}

class CardDemoState extends State<CardDemo> with TickerProviderStateMixin {
  AnimationController _buttonController;
  Animation<double> rotate;
  Animation<double> right;
  Animation<double> bottom;
  Animation<double> width;
  int flag = 0;
  // TabController tabController;

  List data = [image3, image5, image2, image1, image4];
  List selectedData = [];
  void initState() {
    super.initState();
    // tabController = new TabController(length: 4, vsync: this);

    _buttonController = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);

    rotate = new Tween<double>(
      begin: -0.0,
      end: -40.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    rotate.addListener(() {
      setState(() {
        if (rotate.isCompleted) {
          var i = data.removeLast();
          data.insert(0, i);

          _buttonController.reset();
        }
      });
    });

    right = new Tween<double>(
      begin: 0.0,
      end: 400.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    bottom = new Tween<double>(
      begin: 15.0,
      end: 100.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    width = new Tween<double>(
      begin: 20.0,
      end: 25.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  Future<Null> _swipeAnimation() async {
    try {
      await _buttonController.forward();
    } on TickerCanceled {}
  }

  dismissImg(DecorationImage img) {
    setState(() {
      data.remove(img);
    });
  }

  addImg(DecorationImage img) {
    setState(() {
      data.remove(img);
      selectedData.add(img);
      //print(selectedData);
    });
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;
    print("main");
    double initialBottom = 15.0;
    var dataLength = data.length;
    double backCardPosition = initialBottom + (dataLength - 1) * 10 + 10;
    double backCardWidth = -10.0;
    return (new Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          backgroundColor: new Color.fromRGBO(106, 94, 175, 1.0),
          centerTitle: true,
          leading: new Container(
            margin: const EdgeInsets.all(15.0),
            child: new Icon(
              Icons.equalizer,
              color: Colors.cyan,
              size: 30.0,
            ),
          ),
          actions: <Widget>[
            new GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new PageMain()));
              },
              child: new Container(
                  margin: const EdgeInsets.all(15.0),
                  child: new Icon(
                    Icons.search,
                    color: Colors.cyan,
                    size: 30.0,
                  )),
            ),
          ],
          title: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "EVENTS",
                style: new TextStyle(
                    fontSize: 12.0,
                    letterSpacing: 3.5,
                    fontWeight: FontWeight.bold),
              ),
              new Container(
                width: 15.0,
                height: 15.0,
                margin: new EdgeInsets.only(bottom: 20.0),
                alignment: Alignment.center,
                child: new Text(
                  dataLength.toString(),
                  style: new TextStyle(fontSize: 10.0),
                ),
                decoration: new BoxDecoration(
                    color: Colors.red, shape: BoxShape.circle),
              )
            ],
          ),
        ),
        body: new Container(
          color: new Color.fromRGBO(106, 94, 175, 1.0),
          alignment: Alignment.center,
          child: dataLength > 0
              ? new Stack(
                  alignment: AlignmentDirectional.center,
                  children: data.map((item) {
                    if (data.indexOf(item) == dataLength - 1) {
                      return cardDemo(
                          item,
                          bottom.value,
                          right.value,
                          0.0,
                          backCardWidth + 10,
                          rotate.value,
                          rotate.value < -10 ? 0.1 : 0.0);
                    } else {
                      backCardPosition = backCardPosition - 10;
                      backCardWidth = backCardWidth + 10;
                      // return  new dummyCard(img: item,bottom: backCardPosition,cardWidth: backCardWidth,);
                      return cardDemoDummy(item, backCardPosition, 0.0, 0.0,
                          backCardWidth, 0.0, 0.0);
                    }
                  }).toList())
              : new Text("No Event Left",
                  style: new TextStyle(color: Colors.white, fontSize: 50.0)),
        )));
  }

  Positioned cardDemo(DecorationImage img, double bottom, double right,
      double left, double cardWidth, double rotation, double skew) {
    Size screenSize = MediaQuery.of(context).size;
    print("Card");
    return new Positioned(
      bottom: 100.0 + bottom,
      right: flag == 0 ? right != 0.0 ? right : null : null,
      left: flag == 1 ? right != 0.0 ? right : null : null,
      child: new Dismissible(
        key: new Key(new Random().toString()),
        crossAxisEndOffset: -0.3,
        onResize: () {
          //print("here");
          // setState(() {
          //   var i = data.removeLast();

          //   data.insert(0, i);
          // });
        },
        onDismissed: (DismissDirection direction) {
//          _swipeAnimation();
          if (direction == DismissDirection.endToStart)
            dismissImg(img);
          else
            addImg(img);
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
              tag: "img",
              child: new GestureDetector(
                onTap: () {
                  print("card clicked");
                  // Navigator.push(
                  //     context,
                  //     new MaterialPageRoute(
                  //         builder: (context) => new DetailPage(type: img)));
                  Navigator.of(context).push(new PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new DetailPage(type: img),
                      ));
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
                            image: img,
                          ),
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
                                      if (flag == 1)
                                        setState(() {
                                          flag = 0;
                                        });
                                      _swipeAnimation();
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
                                      if (flag == 0)
                                        setState(() {
                                          flag = 1;
                                        });
                                      _swipeAnimation();
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

  Positioned cardDemoDummy(DecorationImage img, double bottom, double right,
      double left, double cardWidth, double rotation, double skew) {
    Size screenSize = MediaQuery.of(context).size;
    print("dummyCard");
    return new Positioned(
      bottom: 100.0 + bottom,
      // right: flag == 0 ? right != 0.0 ? right : null : null,
      //left: flag == 1 ? right != 0.0 ? right : null : null,
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
                  image: img,
                ),
              ),
              new Container(
                  width: screenSize.width / 1.2 + cardWidth,
                  height: screenSize.height / 1.7 - screenSize.height / 2.2,
                  alignment: Alignment.center,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new FlatButton(
                          padding: new EdgeInsets.all(0.0),
                          onPressed: () {},
                          child: new Container(
                            height: 60.0,
                            width: 130.0,
                            alignment: Alignment.center,
                            decoration: new BoxDecoration(
                              color: Colors.red,
                              borderRadius: new BorderRadius.circular(60.0),
                            ),
                            child: new Text(
                              "DON'T",
                              style: new TextStyle(color: Colors.white),
                            ),
                          )),
                      new FlatButton(
                          padding: new EdgeInsets.all(0.0),
                          onPressed: () {},
                          child: new Container(
                            height: 60.0,
                            width: 130.0,
                            alignment: Alignment.center,
                            decoration: new BoxDecoration(
                              color: Colors.cyan,
                              borderRadius: new BorderRadius.circular(60.0),
                            ),
                            child: new Text(
                              "I'M IN",
                              style: new TextStyle(color: Colors.white),
                            ),
                          ))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
