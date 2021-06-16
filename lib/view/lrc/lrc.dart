import 'dart:io';
import 'dart:html' as html;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class LrcBean {
  String text = "";
  String timeString = "";
  int milliTime = 0;
}

typedef FileSelectResultListener = Function<T>(bool status,
    {T? result, String? msg});

class LcrUtil {
  static Future<void> selectFileAsText(
      FileSelectResultListener resultListener) async {
    html.InputElement inputElement =
        html.FileUploadInputElement() as html.InputElement;
    inputElement.click();
    inputElement.onChange.listen((event) {
      final files = inputElement.files;
      if (files?.length == 1) {
        final file = files![0];
        print('选中文件name=${file.name}');
        final html.FileReader fileReader = html.FileReader();
        fileReader.onLoadEnd.listen((event) {
          print('结果：${fileReader.result}');
          final result = fileReader.result as String;
          resultListener(true, result: result, msg: "success");
        });
        fileReader.onError.listen((event) {
          final result = 'error: ' + event.toString();
          resultListener(false, msg: result);
        });
        fileReader.readAsText(file);
      }
    });
  }

  Future<List<LrcBean>> loadMediaLrcBean(path) async {
    String content = await loadMediaLrc(path);
    List<String> list = content.split("\n");
    RegExp regExpHost = RegExp(r'(\[\])(.+)');
    List<LrcBean> lrcs = <LrcBean>[];
    list.forEach((element) {
      RegExpMatch? regExpMatch = regExpHost.firstMatch(element);
      String time = regExpMatch?.group(1) ?? "";
      String lrc = regExpMatch?.group(2) ?? "";
      LrcBean lrcBean = LrcBean();
      lrcBean.text = lrc;
      lrcBean.timeString = time;
      lrcBean.milliTime = 0;
      lrcs.add(lrcBean);
    });
    return lrcs;
  }

  Future<String> readText(path) async {
    return File(path).readAsString();
  }

  Future<File> saveText(path, String content) async {
    return File(path).writeAsString(content);
  }

  Future<String> loadMediaLrc(fileName) async {
    return await rootBundle.loadString('media/$fileName.lrc');
  }

  Future<ByteData> loadMedia(filePath) async {
    return await rootBundle.load('media/$filePath');
  }
}

class MediaPlayer {
  late AudioPlayer _audioPlayer;
  AudioCache _audioCache = AudioCache(
    fixedPlayer: AudioPlayer(),
  );

  initMediaPath(mediaPath) async {
    _audioPlayer = await _audioCache.play('media/$mediaPath');
  }

  bool isPlaying() {
    return _audioPlayer.state == PlayerState.PLAYING;
  }

  pause() async {
    await _audioPlayer.pause();
  }

  onResume() async {
    await _audioPlayer.resume();
  }

  release() async {
    await _audioPlayer.release();
  }

  seekTo(milliseconds) async {
    await _audioPlayer.seek(Duration(milliseconds: milliseconds));
  }
}
