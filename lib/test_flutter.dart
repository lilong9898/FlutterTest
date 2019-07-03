import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

/**
 * 测试一个基本的flutter程序，包括listView和navigator
 *
 * 最终生成的apk是flutter_app/build/app/outputs/apk/app.apk
 * apk结构：
 *
 * - lib目录
 *   - libflutter.so            8M     dart引擎
 * - assets目录
 *   - flutter_assets
 *     - kernel_blob.bin        5M     系统和用户的dart代码的编译产物(dart引擎用字节码)
 *     - isolate_snapshot_data  2M     系统用于加速isolate功能的启动的代码，固定的
 *     -
 *   - images                   ...    图片，包括各个分辨率的
 *   - fonts                    ...    字体
 *   - packages                 ...    用来存放依赖库的资源的目录
 *   - vm_snapshot_data         10k    系统用于加速dart vm启动的代码，固定的
 *   - FontManifest.json        100B   所有字体资源的清单文件
 *   - AssetManifest.json       100B   所有资源的清单文件
 * - res目录
 * - classes.dex
 * - META-INF目录
 * - AndroidManifest.xml
 * - resources.arsc
 *
 * flutter的局限性：
 * (1) 官方不提供热更新方案
 * (2) libflutter.so有8M，kernel_blob.bin有5M，isolate_snapshot_data有2M，包大小至少增加15M
 *
 * */
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Welcome to Flutter',
        theme: new ThemeData(
          primaryColor: Colors.orange
        ),
        home: new RandomWordsWidget()
    );
  }
}

class RandomWordsState extends State<RandomWordsWidget> {
  final List<WordPair> _suggestions = new List<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
  final Set<WordPair> _saved = new Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("MY APPBAR"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.list),
            onPressed: _pushSaved,
          )
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) {
        final Iterable<ListTile> tiles = _saved.map((WordPair pair) {
          return new ListTile(
            title: new Text(
              pair.asPascalCase,
              style: _biggerFont,
            ),
          );

        });
        final Iterable<Widget> dividedTiles = ListTile.divideTiles(
            context: context,
            tiles: tiles,
        ).toList();
        return new Scaffold(
          appBar: new AppBar(
            title: new Text("saved suggestions"),
          ),
          body: new ListView(children: dividedTiles,)
        );
      },
    ));
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (BuildContext context, int i) {
        if (i.isOdd) {
          return new Divider();
        }
        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {

    final bool alreadySaved = _saved.contains(pair);
    return new ListTile(
      leading: new Image(
        image: new AssetImage("images/cover3.jpg"),
      ),
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}

class RandomWordsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RandomWordsState();
  }
}
