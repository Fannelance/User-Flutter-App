import 'package:flutter/material.dart';

class TimerBar extends StatefulWidget {
  final Duration duration;
  final Color color;
  final VoidCallback? onCompleted;

  const TimerBar({
    Key? key,
    required this.duration,
    this.color = Colors.blue,
    required this.onCompleted,
  }) : super(key: key);

  @override
  TimerBarState createState() => TimerBarState();
}

class TimerBarState extends State<TimerBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..forward();

    _controller.addListener(() {
      setState(() {});
      _checkAnimationStatus();
    });
  }

  void _checkAnimationStatus() {
    if (_controller.status == AnimationStatus.completed) {
      if (mounted) {
        Navigator.of(context).pop();
        widget.onCompleted!();
      }
    }
  }

  @override
  void dispose() {
    _controller.removeListener(
        _checkAnimationStatus); // Remove the listener on dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      borderRadius: BorderRadius.circular(2),
      value: 1.0 - _controller.value,
      backgroundColor: Colors.grey[200],
      color: widget.color,
    );
  }
}
