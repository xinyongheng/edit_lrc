import 'package:edit_lrc/config.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  TestPage(this.text);

  final String text;

  @override
  _GalleryAppState createState() => _GalleryAppState();
}

class _GalleryAppState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Configure.appBar(context,"测试页面"),
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.text),
          ),
          Container(
            color: Colors.amberAccent,
            child: Center(
              child: Text('测试页面'),
            ),
          )
        ],
      ),
    );
  }
}
