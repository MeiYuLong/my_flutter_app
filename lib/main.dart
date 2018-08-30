import 'package:flutter/material.dart';
import 'package:my_flutter_app/Home.dart';
import 'package:my_flutter_app/Find.dart';
import 'package:my_flutter_app/mine.dart';
import 'package:my_flutter_app/Logo.dart';
import 'package:my_flutter_app/ImagePick.dart';
import 'package:my_flutter_app/TOPHome.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
      routes: <String, WidgetBuilder>{
        '/a': (BuildContext context) => new Logo(),
        '/b': (BuildContext context) => new ImagePick(), 
        '/c': (BuildContext context) => new TOPHome(), 
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

  // Create a tab controller
  TabController controller;

 @override
  void initState() {
    super.initState();

    // Initialize the Tab Controller
    controller = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
    controller.dispose();
    super.dispose();
  }


  String _stringAdd(string1,string2,[String string3 = '333333',String string4 = '22222']){
    String str = string1+' '+string2;
     print(string1+' '+string2 + ' ' + string3 + ' ' + string4);
    if (string3 != null) {
      str = string1+' '+string2 + ' ' + string3;
      print(string1+' '+string2 + ' ' + string3 + ' ' + string4);
    }
    return str;
  }
  void functionConst(  key, value){
    print(key.toString());
  }
  void functionConst1(int item){
    print(item.toString());
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    Map map1  = new Map();
    map1['one'] = 'map1111';
    map1['two'] = 'map2222';
    map1['three'] = 'map223333';
    print('map1' + map1.toString());

   map1.forEach(functionConst);
    Map map2 = {'map2-01':222221};
    print('object' + 'map2' + map2.toString());

    String string = '\u2665';
    print(string);

     var clapping = '\u{1f44f}';
    print(clapping);
    print(clapping.codeUnits);
    print(clapping.runes.toList());

    //这里使用String.fromCharCodes方法显示字符图形
    //String的详细api后面会具体讲解。
    Runes input = new Runes(
        '\u2665  \u{1f605}  \u{1f60e}  \u{1f47b}  \u{1f596}  \u{1f44d}');
    print(new String.fromCharCodes(input));

    _stringAdd('string1', 'string2');

    print('---------------------------------------------------');
    var list0 = [1,2,3];
    list0.forEach(functionConst1);

    var toUpBig = (msg) => '!!!!!~~  ${msg.toUpperCase()}';
    print(toUpBig('Mei'));
    assert(toUpBig('Mei') == '!!!!!~~  MEI');
    return new Scaffold(
     
      body: new TabBarView(
        children: <Widget>[new Home(),new Find(),new Mine()],
        controller: controller,
        
      ),
      bottomNavigationBar: new Material(
        color: Colors.blue,
        child: new TabBar(
          tabs: <Tab>[
            new Tab(
              icon: new Icon(Icons.home),
              text: '首页',
            ),
            new Tab(
              icon: new Icon(Icons.search),
              text: '发现',
            ),
            new Tab(
              icon: new Icon(Icons.center_focus_strong),
              text: '我的',
            ),
          ],
          controller: controller,
          indicatorSize: TabBarIndicatorSize.label,
        ),
      ),
    );
  }
}
