import 'package:edit_lrc/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MediaControlView extends StatefulWidget {
  const MediaControlView({Key? key}) : super(key: key);

  @override
  _MediaControlViewState createState() => _MediaControlViewState();
}

class _MediaControlViewState extends State<MediaControlView> {
  List<String> lrcList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _firstCard(),
          _secondCard()
        ],
      ),
    );
  }

  Widget _firstCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.w)),
        border: Border.all(width: 1.w, color: Colors.grey),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(8.w),
      child: Column(
        children: [
          _firstMenu(),
          _paddingView(),
          _secondMenu()
        ],
      ),
    );
  }

  TextStyle _menuStyle = TextStyle(
    color: Configure.themeColor,
    fontSize: Configure.mediumSize,
    fontWeight: Configure.medium,
  );

  TextButton menuText(data, {onPressed}) {
    return TextButton(
        onPressed: onPressed, child: Text(data, style: _menuStyle,));
  }

  //第一行
  Widget _firstMenu() {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Row(
        children: [
          menuText('播放', onPressed: () {}),
          Container(width: 10.w, height: 1.h),
          menuText('打TAG', onPressed: () {}),
          Container(width: 10.w, height: 1.h),
          menuText('回退（2秒）', onPressed: () {}),
        ],
      ),
    );
  }

  //第二行
  Widget _secondMenu() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        menuText('加载歌词', onPressed: () {}),
        Container(width: 10.w, height: 1.h),
        menuText('保存内容', onPressed: () {}),
      ],
    );
  }

  Widget _paddingView() {
    return Container(height: 5.h, color: Colors.grey);
  }

  Widget _emptyView = Center(
    child: Text('请先 导入 歌词',
      style: TextStyle(
        fontSize: 20.sp,
        fontWeight: Configure.bold,
        color: Colors.black,
      ),
    ),
  );

  Widget _secondCard() {
    var list = <Widget>[];
    list.add(_cardHead());
    if (lrcList.isNotEmpty) {
      lrcList.forEach((element) {
        list.add(_childView('geci'));
      });
    }else{
      list.add(_emptyView);
    }
    return ListView(
      children: list,
    );
  }

  Text _text(data) {
    return Text(data, style: TextStyle(fontSize: Configure.normalSize),);
  }

  Row _cardHead() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: 5.w, top: 2.h, right: 20.w, bottom: 2.h),
          child: Text("时间线"),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: 5.w, top: 2.h, right: 20.w, bottom: 2.h),
          child: Text("歌词内容"),
        ),
      ],
    );
  }

  Widget _childView(lyric, {String timeTag = ''}) {
    return Row(
      children: [
        Container(child: _text(timeTag), width: 50.w,),
        Container(child: _text(lyric), width: 50.w,)
      ],
    );
  }
}
