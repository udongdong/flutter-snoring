import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sound_stream/sound_stream.dart';

class RecordingProvider2 with ChangeNotifier{
  final RecorderStream _recorder = RecorderStream();
  final PlayerStream _player = PlayerStream();

  late StreamSubscription _recorderStatus;
  late StreamSubscription _playerStatus;
  late StreamSubscription _audioStream;

  List<Uint8List> _micChunks = [];

  bool _isRecording = false;
  bool _isPlaying = false;

  bool get isRecording => _isRecording;
  bool get isPlaying => _isPlaying;

  RecordingProvider2() {
    init();
  }

  @override
  void dispose() {
    _recorderStatus.cancel();
    _playerStatus.cancel();
    _audioStream.cancel();

    super.dispose();
  }

  Future<void> init () async {
    _recorderStatus = _recorder.status.listen((event) {
      _isRecording = event == SoundStreamStatus.Playing;
      notifyListeners();
    });

    _playerStatus = _player.status.listen((event) {
      _isPlaying = event == SoundStreamStatus.Playing;
      notifyListeners();
    });

    _audioStream = _recorder.audioStream.listen((data) {
      if (_isPlaying) {
        _player.writeChunk(data);
      } else {
        _micChunks.add(data);
      }
    });

    await Future.wait([
      _recorder.initialize(),
      _player.initialize(),
    ]);
  }

  void startRecording () {
    print('this is test');
    _recorder.start();
  }

  void stopRecording () {
    _recorder.stop();
  }

  void startPlaying() async {
    await _player.start();

    if (_micChunks.isNotEmpty) {
      for (var chunk in _micChunks) {
        await _player.writeChunk(chunk);
      }
      _micChunks.clear();
    }
  }

  void stopPlaying() {
    _player.stop();
  }
}
