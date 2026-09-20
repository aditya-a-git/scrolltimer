import 'package:flutter/material.dart';

class FloatingPill extends StatefulWidget {
  final Duration elapsed;
  
  const FloatingPill({super.key, required this.elapsed});

  @override
  State<StatefulWidget> createState() => _FloatingPillState();
}

class _FloatingPillState extends State<FloatingPill> {
  String _getDuration(Duration duration) {
    final hours = duration.inHours.toString();
    final mins = (duration.inMinutes % 60).toString();
    final secs = (duration.inSeconds % 60).toString();

    return "$hours:$mins:$secs";
  }

  double _xOffset = 100;
  double _yOffset = 200;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _xOffset,
      top: _yOffset,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _xOffset += details.delta.dx;
            _yOffset += details.delta.dy;
          });
        },
        child: Material(
          color: Colors.transparent,
          elevation: 4.0,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: Text(
              _getDuration(widget.elapsed),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
