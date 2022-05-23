import 'package:flutter/material.dart';
import 'package:flutter_study/version_1/view/recorded_list.dart';
import 'package:flutter_study/version_1/view/snoring_view.dart';

class BaseScaffold extends StatefulWidget{
  const BaseScaffold({Key? key}) : super(key: key);

  @override
  _BaseScaffoldState createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  int _currentIndex = 0;
  final List<Widget> _views = [const Snoring(), const Record()];

  @override
  void initState() {
    // var status = await Permission.microphone.request();
    // if (status != PermissionStatus.granted) {
    //   throw RecordingPermissionException('Microphone permission not granted');
    // }

    super.initState();
  }

  void _onTap (int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool _isDark = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _isDark ? Colors.green : Colors.green.shade800,
        title: const Text('코골이 측정'),
      ),
      body:_views[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _onTap,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
            label: '측정'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: '기록'
          )
        ],

      ),
    );
  }
}
