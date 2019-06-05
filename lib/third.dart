import 'package:flutter/material.dart';

// 测试控件
void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "WidgetTest",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("WidgetTest"),
        ),
        body: new TestWidget(),
      ),
    );
  }
}

/**
 * [StatefulWidget]的子类都要实现[StatefulWidget.createState]方法以生成[State]
 * 后者有[State.build]来生成下级[Widget]
 * */
class TestWidget extends StatefulWidget {
  TestWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _TestWidgetState();
  }
}

class _TestWidgetState extends State<TestWidget> {
  bool _active = false;

  void _onTap() {
    _active = !_active;
    setState(() {});
  }

  // GestureDetector是个StatelessWidget
  // 少数控件有感知手势的能力，比如IconButton，其它的需要包裹它的GestureDetector提供手势感知能力
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap: _onTap,
        // 使用container来规定按钮的背景色和大小
        child: new Center(
          child: new Container(
            child: new Center(
              child: new Text(
                _active ? "Active" : "Inactive",
                style: new TextStyle(fontSize: 32, color: Colors.white),
              ),
            ),
            width: 200,
            height: 200,
            // Decoration用来通过操作canvas来画背景, [BoxDecoration]是[Decoration]最主要的子类
            decoration: new BoxDecoration(
                color: _active ? Colors.lightGreen[700] : Colors.grey[600]),
          ),
        ));
  }
}

/**
 * [StatelessWidget]的子类直接实现[StatelessWidget.build]方法，不需要通过[State]
 * */
class TestStatelessWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new TestConstructorWidget(number: 1,);
  }
}

class TestConstructorWidget extends StatelessWidget{

  // 这是个成员变量
  int number;

  // 构造函数这样写，是将成员变量与同名的named parameter(具名参数)绑定，外界给同名具名参数赋值，就会对这个成员变量赋值
  // 这种写法要求成员变量不能是私有的
  TestConstructorWidget({this.number});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}