import 'package:flutter/material.dart';
import 'station.dart';

class PlayStationPage extends StatefulWidget {
  const PlayStationPage({super.key, required this.station});
  final Station station;

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
            title: Text(widget.station.name),
          ),
          body: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 333,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    widget.station.imageWidget(height: 111),
                    const SizedBox(height: 20,),
                    Text(
                      widget.station.desc,
                      style: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.8),
                        fontWeight: FontWeight.normal
                      ),
                    )
                  ],
                ),
              ),
              const Spacer()
            ],
          ),
        )
      ]
    );
  }
}