import 'dart:async';
import 'dart:developer';

import 'package:edit_lrc/config.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'dart:convert';


import 'view/test/test.dart';

class Application {
  static late FluroRouter _router;
  static final String root = "/";
  static final String test = '/test';
  static final String grammar = '/grammar';
  static final String videoList = '/videoList';
  static final String video = '/video';
  static final String textList = '/textList';
  static final String text = '/text';
  static final String imageList = '/imageList';
  static final String image = '/image';

  static void registerHandler(String routePath, HandlerFunc handlerFunc) {
    _router.define(routePath, handler: Handler(handlerFunc: handlerFunc));
  }

  static void configureFluroRouter() {
    _router = FluroRouter();
    _router.notFoundHandler = noRouteHandler;
    //router.define("/smart_word/:userId", handler: smartWordHandler);
    registerHandler("$test$root:text", (context, parameters) {
      String text = "";
      if (parameters.containsKey('text')) {
        text = parameters['text']![0];
      }
      return TestPage(text);
    });
    /*registerHandler('$grammar', (context, parameters) => GrammarTree());
    registerHandler('$imageList', (context, parameters) {
      return ImageList(parameters['title']![0], parameters['href']![0]);
    });
    registerHandler('$textList', (context, parameters) {
      return TextList(parameters['title']![0], parameters['href']![0]);
    });
    registerHandler('$videoList', (context, parameters) {
      Map<String, dynamic> _map = Map();
      _map['title'] = parameters['title']![0];
      _map['href'] = parameters['href']![0];
      return VideoArray(_map);
    });*/
  }

  static Future navigateTo(context, String path,
      {bool replace = false,
      bool clearStack = false,
      bool maintainState = true,
      bool rootNavigator = false,
      TransitionType? transition = TransitionType.fadeIn,
      Duration? transitionDuration,
      RouteTransitionsBuilder? transitionBuilder,
      RouteSettings? routeSettings}) {
    log(path);
    return _router.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        maintainState: maintainState,
        transition: transition,
        transitionDuration: transitionDuration,
        transitionBuilder: transitionBuilder,
        routeSettings: routeSettings);
  }

  static void pop<T>(context, [T? result]) {
    return _router.pop(context, result);
  }

  static String fluroCnParamsEncode(String originalCn) {
    return jsonEncode(Utf8Encoder().convert(originalCn));
  }

  /// fluro 传递后取出参数，解析
  static String fluroCnParamsDecode(String encodeCn) {
    var list = <int>[];

    ///字符串解码
    for (var data in jsonDecode(encodeCn)[0]) {
      list.add(data);
    }
    return Utf8Decoder().convert(list);
  }
}

Handler smartWordHandler =
    Handler(handlerFunc: (context, parameters) => TestPage("no data"));

Handler noRouteHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  StringBuffer sf = StringBuffer();
  parameters.forEach((key, value) {
    sf.write(key);
    sf.write(":");
    value.forEach((element) {
      sf.write(element);
      sf.write(",");
    });
    sf.write("&");
  });
  return NoRoute(text: sf.toString());
});

class NoRoute extends StatelessWidget {
  const NoRoute({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Configure.appBar(context,'NoRoute'),
        body: Container(
          child: SelectableText(
            text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: Configure.medium,
              fontSize: Configure.normalSize,
            ),
          ),
        ));
  }
}
