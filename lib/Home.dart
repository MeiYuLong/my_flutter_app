
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/Logo.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter_app/ImagePick.dart';
import 'package:my_flutter_app/TOPHome.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return new Scaffold(
       body: new HomePage(title: '首页',),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<HomePage>{
  int _counter = 0;
  static const platform = const MethodChannel('samples.flutter.io/battery');
  String _batterylevel = '未知 电池等级';
  Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    try{
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = '电池 级别为 $result %...';

    }on PlatformException catch (e){
      batteryLevel = "获取失败，'${e.message}'";
    }
    setState(() {
          _batterylevel = batteryLevel;
        });
  }
   void _incrementCounter() {
    setState(() {
      _counter++;
    });
    Navigator.of(context).pushNamed('/b');
  }
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        leading: new Center(
          child: new GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, '/c');
            },
            child: new Row(
                        children: <Widget>[
                          new Icon (Icons.add),
                          new Text('$_counter'),
                        ],
                        
          ),
          ),
          
        ),
        actions: <Widget>[
          IconButton(
          icon: Icon(Icons.add),
          onPressed: (){
            print('惦记了 有按钮');
            Navigator.of(context).push(new MaterialPageRoute(builder: (context){
              return new Logo();
            }));
          },
          ),
          IconButton(
          icon: Icon(Icons.add),
          onPressed: _getBatteryLevel,
          ),
        ],
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            new Text(
              _batterylevel
            )
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}