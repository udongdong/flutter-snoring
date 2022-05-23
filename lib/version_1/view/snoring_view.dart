import 'package:flutter/material.dart';
import 'package:flutter_study/version_1/provider/recording_provider.dart';
import 'package:provider/provider.dart';

import '../component/chart.dart';

class Snoring extends StatelessWidget {
  const Snoring({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isRecording = context.watch<RecordingProvider1>().isRecording;
    bool isPlaying = context.watch<RecordingProvider1>().isPlaying;

    return Column(
      children: [
        const Expanded(
          flex: 2,
          child: Center(),
        ),
        const Expanded(
            child: Chart()
        ),
        const SizedBox(
          height: 68,
        ),
        ElevatedButton(onPressed: isRecording?
            () => context.read<RecordingProvider1>().stopRecording()
            :() => context.read<RecordingProvider1>().startRecording((value) {}),
            child: Text(isRecording? 'stop' : 'record')),
        ElevatedButton(onPressed: isPlaying?
            () => context.read<RecordingProvider1>().stopPlaying()
            :() => context.read<RecordingProvider1>().startPlaying(),
            child: Text(isPlaying? 'stop' : 'play')),
        const SizedBox(
          height: 68,
        ),
      ],
    );
  }
}
