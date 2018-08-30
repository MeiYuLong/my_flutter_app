import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class TOPHome extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('图片'),
      ),
    body: new TOPHomePage(),
        );
  }
}

class TOPHomePage extends StatefulWidget {
  TOPHomePage({Key key, this.title}) : super(key:key);
  final String title;

  @override
  _TOPHomeState createState() => new _TOPHomeState();
}

class _TOPHomeState extends State<TOPHomePage>{
  List homeList = List();
  List <String> Items = <String>['A','B','C','D','E','F','G','H','J','B','C','D','E','F','G','H','J','B','C','D','E','F','G','H','J','B','C','D','E','F','G','H','J'];

  void initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context){
    return new GridView.count(
      primary: false,
      padding: const EdgeInsets.all(8.0),
      mainAxisSpacing:  8.0,
      crossAxisCount: 1,
      crossAxisSpacing: 9.0,
      children: buildGridTilelist(100),
    );
  }


List<Widget> buildGridTilelist(int number){
  List<Widget> widgetList = new List();
  for (var i = 0; i < number; i++) {
    widgetList.add(buildItem(i));
  }
  return widgetList;
}

String url =
      "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=495625508,"
      "3408544765&fm=27&gp=0.jpg";

Widget buildItem(int index) {
  return new GestureDetector(
    onTap: (){
    },
    child: new SizedBox(
      child: new Card(
            child: new Stack(
              children: <Widget>[
                new Image(image:  new NetworkImage(url),fit:  BoxFit.cover,),
                new Text(index.toString(),),
              ],
            ),
          ),
    ),
  );
}
}