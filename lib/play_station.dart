import 'package:flutter/material.dart';

class PlayStationPage extends StatefulWidget {
  const PlayStationPage({super.key});
  @override
  State<StatefulWidget> createState() => _PlayStationPageState();
}

class _PlayStationPageState extends State<PlayStationPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            "images/background.png",
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            title: const Text('text'),
          ),
        )
      ]
    );
  }
}