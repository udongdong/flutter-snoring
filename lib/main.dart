import 'package:flutter_study/base_scaffold_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/version_1/provider/recording_provider.dart';
import 'package:flutter_study/version_2/provider/recording_provider.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (_) => RecordingProvider1()),
        ChangeNotifierProvider(create: (_) => RecordingProvider2())
      ],
      child : const MaterialApp ( home: BaseScaffold())
    )
  );
}
