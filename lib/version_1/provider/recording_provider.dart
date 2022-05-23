import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';

const Codec _codec = Codec.aacMP4;
const String _mPath = 'tau_file.mp4';
const theSource = AudioSource.microphone;

class RecordingProvider1 with ChangeNotifier{
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();

  StreamSubscription<NoiseReading>? _noiseSubscription;
  late NoiseMeter _noiseMeter;

  bool isRecording = false;
  bool isPlaying = false;

  RecordingProvider1(){
    init();
  }

  init() async {
    _noiseMeter = NoiseMeter((error){
      print(error.toString());
    });

    await _player.openPlayer();
    await openTheRecorder();
  }

  @override
  void dispose() {
    _noiseSubscription?.cancel();
    super.dispose();
  }

  Future<void> openTheRecorder() async {
    await _recorder.openRecorder();
    // if (!await _recorder.isEncoderSupported(_codec)) {
    //   _codec = Codec.opusWebM;
    //   _mPath = 'tau_file.webm';
    //   if (!await _recorder.isEncoderSupported(_codec)) {
    //
    //     return;
    //   }
    // }

    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
      AVAudioSessionCategoryOptions.allowBluetooth |
      AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
      AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));
  }

  void startRecording(callback) async {
    try{
      _noiseSubscription = _noiseMeter.noiseStream.listen((NoiseReading noiseReading) {
        if (isRecording) return;

        isRecording = true;

        _recorder.startRecorder(
          toFile: _mPath,
          codec: _codec,
          audioSource: theSource,
        );

        // callback();

        notifyListeners();
      });
    }catch(error){
      print(error);
    }
  }

  void stopRecording() async {
    print('start stopRecording');
    await _recorder.stopRecorder();
    if (_noiseSubscription != null) {
        _noiseSubscription!.cancel();
        _noiseSubscription = null;
      }
    isRecording = false;
    notifyListeners();
  }

  void startPlaying() {
    _player.startPlayer(fromURI: _mPath);
    isPlaying = true;
    notifyListeners();
  }

  void stopPlaying() {
    _player.stopPlayer();
    isPlaying = false;
    notifyListeners();
  }
}