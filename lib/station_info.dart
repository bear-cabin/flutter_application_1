import 'package:flutter/material.dart';
import 'station.dart';
import 'station_cell.dart';

class StationInfoPage extends StatelessWidget {
  const StationInfoPage({super.key, required this.station});
  final Station station;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
        ),
        body: Column(
          children: [
            StationCell(station: station, color: Colors.transparent),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                station.longDesc,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
