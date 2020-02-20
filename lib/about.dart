import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于 Hitokoto'),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(15),
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                '关于一言',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              '动漫也好、小说也好、网络也好，不论在哪里，我们总会看到有那么一两个句子能穿透你的心。我们把这些句子汇聚起来，形成一言网络，以传递更多的感动。如果可以，我们希望我们没有停止服务的那一天。\n\n'
                  '简单来说，一言指的就是一句话，可以是动漫中的台词，也可以是网络上的各种小段子。\n\n'
                  '或是感动，或是开心，有或是单纯的回忆。来到这里，留下你所喜欢的那一句句话，与大家分享，这就是一言存在的目的。\n',
              style: TextStyle(fontSize: 16),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Wrap(
                children: <Widget>[
                  Text(
                    '*:本段文本源自 ',
                    style: TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                    child: Text(
                      'hitokoto.us',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                    onTap: () {
                      _launchUrl('http://hitokoto.us');
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                '关于这个 APP',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                '你有被一句话或者一句诗打动的时候吗？\n\n小时候总喜欢将自己喜爱的歌词摘抄在笔记本上，不仅是因为歌曲的音符吸引，更是因为歌词间所引起的共鸣和向往。'
                '\n\n在这个嘈杂的社会里，你是否很少有静下心来、或能静下心来返璞归真，好好地通过文字间感受生活呢？\n',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                '“山川是不卷收的文章，日月为你掌灯伴读。” ——简媜\n...\n',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Wrap(
              alignment: WrapAlignment.start,
              children: <Widget>[
                Text(
                  '我是 ',
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  child: Text(
                    'Wisp X ',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    _launchUrl('https://www.wispx.cn');
                  },
                ),
                Text(
                  ', 希望这个 APP 可以给你带来帮助。',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _launchUrl(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
