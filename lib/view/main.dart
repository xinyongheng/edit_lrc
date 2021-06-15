import 'package:edit_lrc/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../routes.dart';
import 'lrc/media_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(Configure.width, Configure.height),
      //allowFontScaling: false,
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '歌词编辑',
        theme: Configure.themeData(),
        home: MyHomePage(title: '歌词编辑'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    Application.configureFluroRouter();
    //Api.init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
/*      appBar: AppBar(
        title: Configure.appBar(context,widget.title),
      ),*/
      body: MediaControlView(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
