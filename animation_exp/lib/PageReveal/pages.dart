import 'package:flutter/material.dart';


final pages=[
   new PageViewModel(Colors.blue, Icons.phone, Icons.contacts, "This is subtitle", "Contact"),

   new PageViewModel(Colors.red, Icons.chat_bubble, Icons.chat, "This is subtitle", "Chat"),

  new PageViewModel(Colors.green, Icons.hotel, Icons.home, "This is subtitle", "Home"),

];

class Page extends StatelessWidget {

  final PageViewModel viewModel;
  final double percentVisible;
Page({this.viewModel,this.percentVisible=1.0});

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.INFINITY,
      color: viewModel.color,
      child: new Opacity(
        opacity: percentVisible,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

           new Transform(
             child: new Padding(
                padding: const EdgeInsets.only(bottom:25.0),
                child: new Icon(
                  viewModel.iconName,
                  size: 150.0,
                  color: Colors.white,
                ),
              ),
             transform: new Matrix4.translationValues(0.0, 50.0*(1.0-percentVisible), 0.0),
           ),

            new Transform(
              transform: new Matrix4.translationValues(0.0, 30.0*(1.0-percentVisible), 0.0),
              child: new Padding(
                padding: const EdgeInsets.only(top:10.0,bottom: 10.0),
                child: new Text(
                  viewModel.title,
                  style: new TextStyle(fontSize: 34.0, color: Colors.white,fontWeight: FontWeight.bold),
                ),
              ),
            ),
            new Transform(
              transform: new Matrix4.translationValues(0.0, 30.0*(1.0-percentVisible), 0.0),

              child: new Padding(
                padding: const EdgeInsets.only(bottom:75.0),
                child: new Text(
                  viewModel.subtitle,
                  textAlign: TextAlign.center,
                  style: new TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class PageViewModel{
  final Color color;
  final IconData iconName;
  final String title;
  final String subtitle;
  final IconData iconAssetIcon;
  PageViewModel(this.color,this.iconAssetIcon,this.iconName,this.subtitle,this.title);
}