import 'dart:async';
import 'package:flutter/material.dart';

class AutoScrollText extends StatefulWidget {
  final String text;

  const AutoScrollText({super.key, required this.text});

  @override
  _AutoScrollTextState createState() => _AutoScrollTextState();
}

class _AutoScrollTextState extends State<AutoScrollText> {
  late ScrollController _controller;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _timer = Timer.periodic(Duration(milliseconds: 50), (_) {
      if (_controller.hasClients) {
        _controller.animateTo(
          _controller.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.linear,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      child: Text(
        widget.text,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}


