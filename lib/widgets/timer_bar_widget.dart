import 'package:flutter/material.dart';

class TimerBar extends StatefulWidget {
  final Duration duration;
  final Color color;

  const TimerBar({
    Key? key,
    required this.duration,
    this.color = Colors.blue,
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
    });
  }

  @override
  void dispose() {
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
