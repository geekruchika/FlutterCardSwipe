import 'package:flutter/material.dart';



class CardDesign extends StatelessWidget {
  final img;
  final cardWidth;
  CardDesign({this.cardWidth, this.img});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: cardWidth,
      decoration: BoxDecoration(
          image: new DecorationImage(
            image: new ExactAssetImage(img),
            fit: BoxFit.cover,
          ),
          color: Colors.purple,
          borderRadius: BorderRadius.all(Radius.circular(8))),
    );
  }
}
