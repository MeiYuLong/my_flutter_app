import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:my_flutter_app/Model.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

class Find extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return new Scaffold(
        body: new FindPage(title:'列表'),
    );
  }
}
  class FindPage extends StatefulWidget {
    FindPage({Key key, this.title}) : super(key: key);
    final String title;
   
    @override
    _FindState createState()=> new _FindState();
    
  }
  void taptitle(String item){
    print(item);
  }
  class _FindState extends State<FindPage>{
    var barTitle = 'Bar99999999999';
    var modelArray = new List();
    Widget buildListTile(BuildContext context, Model item){
      return new ListTile(
        isThreeLine: true,
        dense: false,
        leading:  new CircleAvatar(child: new Text(item.name),),
        title: new Text(item.height +'Title'),
        subtitle: new Text(item.birth_year + 'SubTitle'),
        trailing: new Icon(Icons.arrow_right,color: Colors.blue,),
        onTap: (){
          setState(() {
                barTitle = item.name;    
          });
          print(item.name);
        },
      );
      
    }

  Future <String> loadJsonContent() async{
    return await rootBundle.loadString('Other/starwars_data.json');
  }

  void _loadJson(){
    loadJsonContent().then((value){
      JsonDecoder decoder = new JsonDecoder();
      List json = decoder.convert(value);
      print(json.length);
      print(json.last.toString());
      json.forEach((value){
         var mdoel = new Model.fromJson(value);
         print(value);
         setState(() {
                  modelArray.add(mdoel);
                  });
        //   print(modelArray);
      });

    });
  }
    
    @override
    Widget build(BuildContext context){
      List <String> Items = <String>['A','B','C','D','E','F','G','H','J','B','C','D','E','F','G','H','J','B','C','D','E','F','G','H','J','B','C','D','E','F','G','H','J'];

      // var json = loadJsonContent();
     if(modelArray.length < 1){
        _loadJson();
     }
      
      Iterable<Widget> listTitles = modelArray.map((item){
        return buildListTile(context, item);
      });
      listTitles = ListTile.divideTiles(context: context,tiles: listTitles);
      return new Scaffold(
        appBar: new AppBar(
        title: new Text(widget.title),
        leading: new Center(
          child: new Row(
            children: <Widget>[
              new Icon (Icons.add),
              new Text (barTitle),
            ],
          ),
          ),
        ),
        body: new Container(
          child: new ListView(
            children: listTitles.toList(),
          ),
          decoration: new BoxDecoration(
             image:  new DecorationImage(
               image:  new AssetImage('Other/bg1.jpg'),
               fit: BoxFit.cover
            ),
          ),
        ),
      );
    }
  }