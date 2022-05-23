import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/recording_provider.dart';

class Snoring extends StatelessWidget {
  const Snoring({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isRecording = context
        .watch<RecordingProvider2>()
        .isRecording;
    bool _isPlaying = context
        .watch<RecordingProvider2>()
        .isPlaying;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          iconSize: 96.0,
          icon: Icon(_isRecording ? Icons.mic_off : Icons.mic),
          onPressed: _isRecording ? () => context
              .read<RecordingProvider2>()
              .stopRecording() : () => context
              .read<RecordingProvider2>()
              .startRecording(),
        ),
        IconButton(
          iconSize: 96.0,
          icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
          onPressed: _isPlaying ? () => context
              .read<RecordingProvider2>()
              .stopPlaying() : () => context
              .read<RecordingProvider2>()
              .startPlaying(),
        ),
      ],
    );
  }
}