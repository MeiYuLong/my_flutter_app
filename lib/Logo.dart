import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class Logo extends StatefulWidget{
  _LogoState createState() => new _LogoState();
}

class _LogoState extends State<Logo> with SingleTickerProviderStateMixin{
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController( 
      duration: const Duration(milliseconds: 1000),vsync: this);

    animation = new Tween(begin: 0.0, end: 300.0).animate(controller)
    ..addListener((){
         setState(() {
  
          });
    });
    controller.forward();
  }
  Widget build(BuildContext context){
    return new Center(
      child: new Container(
        color: Colors.white,
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        height: animation.value,
        width: animation.value,
        child:  new FlutterLogo(),
      ),
    );
  }
  @override
    void dispose() {
      controller.dispose();
      // TODO: implement dispose
      super.dispose();
    }
}
