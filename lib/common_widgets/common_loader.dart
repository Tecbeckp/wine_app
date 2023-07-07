import 'dart:math' show pi;

import 'package:flutter/material.dart';

class CommonLoader extends StatefulWidget {
  const CommonLoader({Key? key}) : super(key: key);

  @override
  State<CommonLoader> createState() => _CommonLoaderState();
}

class _CommonLoaderState extends State<CommonLoader>
    with TickerProviderStateMixin {
  late AnimationController _contorller;
  late AnimationController _contorllerCounterClock;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _contorller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _contorllerCounterClock =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _animation = Tween<double>(
      begin: 0.0,
      end: 2 * pi,
    ).animate(_contorller);
    _contorllerCounterClock.repeat();
    _contorller.repeat();
  }

  @override
  void dispose() {
    _contorller.dispose();
    _contorllerCounterClock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _contorller,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..rotateZ(_animation.value),
            child: Image.asset(
              'assets/images/icon.png',
              color: Colors.black,
              height: 33,
              width: 33,
            ),
          );
        });
  }
}
