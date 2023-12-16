import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedPlay extends StatefulWidget {
  const AnimatedPlay({super.key});

  @override
  State<AnimatedPlay> createState() => _AnimatedPlayState();
}

class _AnimatedPlayState extends State<AnimatedPlay> {
  Timer? timer;
  var value = 0;

  @override
  void initState() {
    timer = Timer.periodic(
      const Duration(milliseconds: 100), 
      (timer) {
        setState(() {
          value = (value + 1) % 4;
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = 4;
    double size = width * 3 + 4 * 2;
    var children = <Widget>[];
    for (int i=0; i<3; i++) {
      children.add(
        Container(
          color: Colors.white,
          width: width,
          height: ((value + i) % 4) * size / 3,
        )
      );
    }
    return SizedBox(
      width: size,
      height: size,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: children,
      ),
    );
  }
}