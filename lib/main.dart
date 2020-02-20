import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hitokoto/about.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hitokoto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Hitokoto 一言'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List tabs = [
    {"key": "", "val": "随机"},
    {"key": "a", "val": "动画"},
    {"key": "b", "val": "漫画"},
    {"key": "c", "val": "游戏"},
    {"key": "d", "val": "小说"},
    {"key": "e", "val": "原创"},
    {"key": "f", "val": "网络"},
    {"key": "g", "val": "其他"}
  ];
  String text = '请稍等...';
  String from = '';
  int index = 0;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _getData();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      if(_tabController.indexIsChanging) {
        index = _tabController.index;
        _getData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.error_outline),
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => About()),
              );
            },
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: tabs.map((e) => Tab(text: e['val'])).toList(),
        ),
      ),
      body: _content(context),
      floatingActionButton: FloatingActionButton(
        child: loading ? CircularProgressIndicator(
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation(Colors.blue),
        ) : Icon(Icons.autorenew),
        onPressed: loading ? null : _getData,
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ListView(
        padding: EdgeInsets.all(20),
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: "ZhiMangXing",
                    color: Colors.black87,
                    letterSpacing: 3,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      '- ${from.toString()}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _getData() async {
    if (loading) return;
    try {
      setState(() {
        loading = true;
      });
      Response response = await Dio().get(
        "https://international.v1.hitokoto.cn",
        queryParameters: {"c": tabs[index]['key']},
      );
      setState(() {
        text = response.data['hitokoto'];
        from = response.data['from'];
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }
}
