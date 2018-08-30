import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:my_flutter_app/LoadingPage.dart';
import 'package:url_launcher/url_launcher.dart';

class Mine extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return new Scaffold(
       body: new MinePage(title: '首页',),
    );
  }
}

class MinePage extends StatefulWidget {
  MinePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  MineState createState() => new MineState();
}

class MineState extends State<MinePage> {
  List _fruits = ['Apple','Banana','Pineapple','Grapes'];

   var _ipAddress = 'Unknown';

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selectedFruit;
  String _accountText;
  String _pressWordText;
  double billAmount = 0.0;
  double tipPercentage = 0.0;

  @override
  void initState(){
    _dropDownMenuItems = buildAndGetDropDownMeniItems(_fruits);
    _selectedFruit = _dropDownMenuItems[0].value;
    super.initState();
  }

  _getIPAddress() async{
    var url = 'https://httpbin.org/ip';
    var httpClient = new HttpClient();

    String result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var respone = await request.close();
      if (respone.statusCode == HttpStatus.OK) {
        var json = await respone.transform(UTF8.decoder).join();
        var data = JSON.decode(json);
        result = data['origin'];

      } else {
        result = 'Error getting IP address:\nHttp status ${respone.statusCode}';
      }
    } catch (e) {
      result = 'Failed getting IP address';
    }

    if (!mounted) return;

    setState(() {
          _ipAddress = result;
        });
  }

  _getLauncherURL () async{
      const url =  'https://flutter.io' ;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw '无法访问';
      }
  }

  List<DropdownMenuItem<String>> buildAndGetDropDownMeniItems(List fruits){
    List<DropdownMenuItem<String>> items =new List();
    for (String fruit in fruits) {
      items.add(new DropdownMenuItem(value:  fruit, child: new Center(child: new Text(fruit)) ));
    }
    return items;
  }

   void changedDropDownItem(String selectedFruit) {
    setState(() {
      _selectedFruit = selectedFruit;
    });
    _getLauncherURL();
  }


  @override
  Widget build(BuildContext context){
 
    return  new Scaffold(
        appBar: new AppBar(
          title: new Text('下拉菜单'),
          leading: new Center(
            child: new GestureDetector(
              // padding: EdgeInsets.only(left: 10.0),
            onTap: _getIPAddress,
            child: new Center(
              child: new Text('网络请求'),
            ),
            ),
          ),
          actions: <Widget>[
            new DropdownButton(
              value: _selectedFruit,
              style: new TextStyle(
                color: Colors.red,
              ),
              items: _dropDownMenuItems,
              onChanged: changedDropDownItem,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: new Container(
            child: new Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                loginHeader(),
                // loginFields(context),
              ],
            ),
        ),
    );
  }

  
loginHeader() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlutterLogo(
            colors: Colors.lightBlue,
            size: 80.0,
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            "Welcome to Flutter Gank",
            style:
                TextStyle(fontWeight: FontWeight.w700, color: Colors.lightBlue),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "Sign in to continue",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      );

  loginFields(BuildContext context) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Enter your username",
                  labelText: "Username",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              child: TextField(
                maxLines: 1,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  labelText: "Password",
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              width: double.infinity,
              child: RaisedButton(
                padding: EdgeInsets.all(12.0),
                shape: StadiumBorder(),
                child: Text(
                  "SIGN IN",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.lightBlue,
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/main');
                },
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              "SIGN UP FOR AN ACCOUNT",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
}