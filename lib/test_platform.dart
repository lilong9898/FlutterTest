import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**
 * 测试flutter与android的java代码之间的通信（flutter向android java请求电量信息）
 * 通信是通过platform channel中的method channel
 * platform channel还包括其他种类的channel
 *
 * method channel是双向的，invokeMethod的一方为调用端，实现callHandler的一方为被调用端
 *
 * flutter中的print用来打log, 用flutter logs命令可看，本质上是封装了adb logcat
 *
 * */
void main() {
  runApp(new MaterialApp(
    title: "Test Platform",
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text("Test Platform"),
      ),
      body: new BatteryDisplayWidget(),
    ),
  ));
}

class BatteryDisplayWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new BatteryDisplayState();
  }
}

class BatteryDisplayState extends State<BatteryDisplayWidget> {
  static const channel =
      const MethodChannel("TestPlatform/MethodChannelBattery");

  String batteryLevel = "unknown battery level";

  Future getBatteryLevel() async {
    String batteryLevelDisplay = "battery level error";
    try {
      final int level = await channel.invokeMethod("getBatteryLevel");
      batteryLevelDisplay = "battery level = $level %";
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      batteryLevel = batteryLevelDisplay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text(
          "$batteryLevel",
          style: new TextStyle(fontSize: 20),
        ),
        new Container(
          margin: EdgeInsets.only(top: 20),
          child: new RaisedButton(
            child: new Text("get battery level",
                style: new TextStyle(fontSize: 20)),
            onPressed: getBatteryLevel,
          ),
        )
      ],
    ));
  }
}
