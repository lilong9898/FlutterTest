import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/**
 * 测试http库
 * 注意：Dart程序只能单线程执行，无多线程能力
 * 要实现类似多线程的能力，要用isolate，本质上是多进程，多个isolate不共享内存数据
 *
 * Dart中在不用isolate的情况下，通过asnyc await Future这些成套关键字标记的＂异步操作＂
 * 本质上是调整了执行顺序：
 * 当执行到async方法时，立即执行其内部的await关键字前的语句，并返回一个Future
 * await关键字后的语句，被放入队列中，等队列中现有的动作执行完后再执行
 *
 * 所有代码还是运行在一个线程里
 *
 * 函数名 async {
 *    ... = await 返回Future的函数
 * }
 *
 * async和await关键字是为了简化语法，等同于直接使用Future的方法
 * */
void main() {
  runApp(new MaterialApp(
    title: "http test",
    home: Scaffold(
      appBar: new AppBar(
        title: new Text("http test"),
      ),
      body: new _MockWebView(),
    ),
  ));
}

// 显示网络请求的返回结果
class _MockWebView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MockWebViewState();
  }
}

class _MockWebViewState extends State<_MockWebView> {
  String _result = "";
  Future _requestHttp() async {
    http.Response response =
        await http.get("https://flutterchina.club/flutter-for-android/");
    setState(() {
      print("set state");
      _result = response.body;
    });
  }

  @override
  void initState() {
    super.initState();
    _requestHttp();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new ListView(
        children: <Widget>[new Text("$_result")],
      ),
    );
  }
}
