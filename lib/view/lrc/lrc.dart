import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class LrcBean {
  String text = "";
  String timeString = "";
  int milliTime = 0;
}

class LcrUtil {
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
