import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scrolltimer/floating_pill.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<StatefulWidget> createState() => _TimerPageState();
}

class _TimerPageState extends State {
  Timer? _timer;
  Duration _elapsed = Duration.zero;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(_elapsed, (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _elapsed += Duration(seconds: 1);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: FloatingPill(elapsed: _elapsed)),
    );
  }
}
