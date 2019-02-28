import 'package:flutter/material.dart';

Widget image1 = Container(
  height: 400,
  width: 300,
  decoration: BoxDecoration(
      image: new DecorationImage(
        image: new ExactAssetImage('assets/img1.jpg'),
        fit: BoxFit.cover,
      ),
      color: Colors.blue,
      borderRadius: BorderRadius.all(Radius.circular(8))),
);
Widget image2 = Container(
  height: 400,
  width: 300,
  decoration: BoxDecoration(
      image: new DecorationImage(
        image: new ExactAssetImage('assets/img2.jpg'),
        fit: BoxFit.cover,
      ),
      color: Colors.red,
      borderRadius: BorderRadius.all(Radius.circular(8))),
);

Widget image3 = Container(
  height: 400,
  width: 300,
  decoration: BoxDecoration(
      image: new DecorationImage(
        image: new ExactAssetImage('assets/img3.jpg'),
        fit: BoxFit.cover,
      ),
      color: Colors.green,
      borderRadius: BorderRadius.all(Radius.circular(8))),
);
Widget image4 = Container(
  height: 400,
  width: 300,
  decoration: BoxDecoration(
      image: new DecorationImage(
        image: new ExactAssetImage('assets/img4.jpg'),
        fit: BoxFit.cover,
      ),
      color: Colors.yellow,
      borderRadius: BorderRadius.all(Radius.circular(8))),
);
Widget image5 = Container(
    height: 400,
    width: 300,
    decoration: BoxDecoration(
        image: new DecorationImage(
          image: new ExactAssetImage('assets/img5.jpg'),
          fit: BoxFit.cover,
        ),
        color: Colors.orange,
        borderRadius: BorderRadius.all(Radius.circular(8))),
    child: Center(child: Text("5")));
Widget image6 = Container(
  height: 400,
  width: 300,
  decoration: BoxDecoration(
      image: new DecorationImage(
        image: new ExactAssetImage('assets/img2.jpg'),
        fit: BoxFit.cover,
      ),
      color: Colors.yellow,
      borderRadius: BorderRadius.all(Radius.circular(8))),
);
Widget image7 = Container(
  height: 400,
  width: 300,
  decoration: BoxDecoration(
      image: new DecorationImage(
        image: new ExactAssetImage('assets/img1.jpg'),
        fit: BoxFit.cover,
      ),
      color: Colors.pinkAccent,
      borderRadius: BorderRadius.all(Radius.circular(8))),
);
Widget image8 = Container(
  height: 400,
  width: 300,
  decoration: BoxDecoration(
      image: new DecorationImage(
        image: new ExactAssetImage('assets/img3.jpg'),
        fit: BoxFit.cover,
      ),
      color: Colors.red,
      borderRadius: BorderRadius.all(Radius.circular(8))),
);
Widget image9 = Container(
  height: 400,
  width: 300,
  decoration: BoxDecoration(
      image: new DecorationImage(
        image: new ExactAssetImage('assets/img2.jpg'),
        fit: BoxFit.cover,
      ),
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8))),
);
Widget image10 = Container(
  height: 400,
  width: 300,
  decoration: BoxDecoration(
      image: new DecorationImage(
        image: new ExactAssetImage('assets/img4.jpg'),
        fit: BoxFit.cover,
      ),
      color: Colors.purple,
      borderRadius: BorderRadius.all(Radius.circular(8))),
);

ImageProvider avatar1 = new ExactAssetImage('assets/avatars/avatar-1.jpg');
ImageProvider avatar2 = new ExactAssetImage('assets/avatars/avatar-2.jpg');
ImageProvider avatar3 = new ExactAssetImage('assets/avatars/avatar-3.jpg');
ImageProvider avatar4 = new ExactAssetImage('assets/avatars/avatar-4.jpg');
ImageProvider avatar5 = new ExactAssetImage('assets/avatars/avatar-5.jpg');
ImageProvider avatar6 = new ExactAssetImage('assets/avatars/avatar-6.jpg');
