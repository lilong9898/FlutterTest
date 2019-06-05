import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// 测试布局

// 可以直接通过runApp方法给屏幕设置控件，跳过MaterialApp之类的widget
//void main() {
//  runApp(new Center(
//    child: new Text(
//      "haha",
//      textDirection: TextDirection.ltr,
//      style: TextStyle(color: Colors.orange, fontSize: 40),
//    ),
//  ));
//}

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "LayoutTest",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("LayoutTest"),
        ),
        body: new RootWidget(),
      ),
    );
  }
}

/**
 * 根布局
 * */
class RootWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RootWidgetState();
  }
}

class RootWidgetState extends State<RootWidget> {
  @override
  Widget build(BuildContext context) {
    Widget titleLayout = new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: new Text(
                    "Oeschinen Lake Campground",
                    style: new TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                new Text(
                  "Kandersteg, Switzerland",
                  style: new TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
          new FavoriteWidget(),
        ],
      ),
    );
    Widget buttonLayout = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          getButton(Icons.call, "CALL"),
          getButton(Icons.near_me, "ROUTE"),
          getButton(Icons.share, "SHARE"),
        ],
      ),
    );
    Widget textLayout = new Container(
      padding: const EdgeInsets.all(32),
      child: new Text(
        '''
Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
        ''',
        softWrap: true,
      ),
    );
    Widget image = new Image(
      image: new AssetImage("images/scene.jpg"),
    );
    return new ListView(
      children: <Widget>[image, titleLayout, buttonLayout, textLayout],
    );
  }

  Widget getButton(IconData icon, String desc) {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Icon(icon, color: Theme.of(context).primaryColor),
        new Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: new Text(
            desc,
            style: new TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}

/** 点赞星标和点赞数的组合控件*/
class FavoriteWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new FavoriteWidgetState();
  }
}

class FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;

  @override
  Widget build(BuildContext context) {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Container(
          padding: const EdgeInsets.all(0.0),
          child: new IconButton(
            icon: _isFavorited
                ? new Icon(Icons.star)
                : new Icon(Icons.star_border),
            color: Colors.red[500],
            onPressed: () {
              setState(() {
                if (_isFavorited) {
                  _isFavorited = false;
                  _favoriteCount--;
                } else {
                  _isFavorited = true;
                  _favoriteCount++;
                }
              });
            },
          ),
        ),
        new SizedBox(
          width: 25.0,
          child: new Container(
            child: new Text("$_favoriteCount"),
          ),
        ),
      ],
    );
  }
}
