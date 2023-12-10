import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/play_station.dart';
import 'package:http/http.dart' as http;
import 'station.dart';
import 'play_station.dart';

class StationListPage extends StatefulWidget {
  const StationListPage({super.key});
  @override
  State<StationListPage> createState() => _StationListPageState();
}

class _StationListPageState extends State<StationListPage> {
  List<Station> stations = [];

  @override
  void initState() {
    super.initState();
    fetchStations();
  }

  fetchStations() async {
    const urlStr = "https://fethica.com/assets/swift-radio/stations.json";
    final response = await http.get(Uri.parse(urlStr));
    Map<String, dynamic> json = jsonDecode(response.body);
    var stations = <Station>[];
    for (final obj in json["station"] as List) {
      var map = obj as Map<String, dynamic>;
      stations.add(Station.fromJson(map));
    }
    setState(() {
      this.stations = stations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(
        child: Image.asset(
          "images/background.png",
          fit: BoxFit.cover,
        ),
      ),
      Column(
        children: [
          const TopBar(),
          ListView.builder(
              shrinkWrap: true,
              itemCount: stations.length,
              itemBuilder: (context, index) {
                Color color = const Color.fromRGBO(255, 255, 255, 0.1);
                if (index % 2 != 0) {
                  color = Colors.transparent;
                }
                return StationCell(
                  station: stations[index],
                  color: color,
                );
              })
        ],
      )
    ]);
  }
}

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Row(
        children: [
          const SizedBox(
            width: 8,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
            color: Colors.white,
          )
        ],
      ),
    );
  }
}

class StationCell extends StatelessWidget {
  const StationCell({super.key, required this.station, required this.color});
  final Station station;
  final Color color;

  Widget imageWidget(Station station) {
    if (station.imageURL.startsWith('http')) {
      return Image.network(station.imageURL);
    } else if (station.imageURL.endsWith('.png')) {
      return Image.asset('images/stations/${station.imageURL}');
    } else if (station.imageURL.isNotEmpty) {
      return Image.asset(
        'images/stations/${station.imageURL}.png',
      );
    } else {
      return const SizedBox(
        width: 115.5,
        height: 68,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => const PlayStationPage())
        );
      },
      child: Container(
        color: color,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SizedBox(
            height: 68,
            child: Row(
              children: [
                imageWidget(station),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      station.name,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      station.desc,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.normal),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
