import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  _requestHttp() async {
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
