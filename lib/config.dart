import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Configure{
  static double width = 960;
  static double height = 600;
  static Color themeColor = Color(0xff00adfd);
  static Color titleColor = Colors.white;
  static MaterialColor primarySwatch = Colors.blue;
  static FontWeight normal = FontWeight.normal; //w400
  static FontWeight bold = FontWeight.bold; //w700
  static FontWeight medium = FontWeight.w500;
  static double titleSize = 29.sp;
  static double mediumSize = 20.sp;
  static double normalSize = 15.sp;

  /// 当前设备宽度 dp
  /// The horizontal extent of this size.
  static double get screenWidth => ScreenUtil().screenWidth;

  ///当前设备高度 dp
  ///The vertical extent of this size. dp
  static double get screenHeight => ScreenUtil().screenHeight;

  static AppBar appBar(BuildContext context, String text,
      [List<Widget>? actions]) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: _buttonBack(context),
      actions: actions,
      title: Text(
        text,
        style: TextStyle(
          color: titleColor,
          fontSize: 22.sp,
          fontWeight: medium,
        ),
      ),
      centerTitle: true,
    );
  }
  static Widget? _buttonBack(context) {
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    final bool canPop = parentRoute?.canPop ?? false;
    final bool hasEndDrawer = scaffold?.hasEndDrawer ?? false;
    final bool useCloseButton =
        parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;
    if (!hasEndDrawer && canPop)
      return IconButton(
        iconSize: titleSize,
        icon: Icon(useCloseButton ? Icons.close : Icons.arrow_back),
        color: titleColor,
        tooltip: useCloseButton ? '关闭' : '返回',
        onPressed: () {
          Navigator.maybePop(context);
        },
      );
    else
      return null;
  }

  static ThemeData themeData() {
    return ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Configure.themeColor,
      // primaryColorBrightness: Brightness.dark,
      hoverColor: Colors.cyanAccent,
      buttonColor: Colors.yellow,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: Colors.red,
        selectionHandleColor: Colors.deepPurple,
      ),
    );
  }
}