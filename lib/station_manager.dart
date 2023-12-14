import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

import 'station.dart';

class StationManager with ChangeNotifier {
  static final shared = StationManager();
  List<Station> stations = [];
  final player = AudioPlayer();
  Station? station;

  StationManager() {
    fetchStations();
  }

  fetchStations() async {
    const urlStr = "https://fethica.com/assets/swift-radio/stations.json";
    final response = await http.get(Uri.parse(urlStr));
    Map<String, dynamic> json = jsonDecode(response.body);
    var stations = <Station>[];
    for (final obj in json["station"] as List) {
      var map = obj as Map<String, dynamic>;
      var station = Station.fromJson(map);
      stations.add(station);
    }
    this.stations = stations;
    notifyListeners();
  }

  replaceStation(Station station) {
    this.station = station;
    final uri = Uri.parse(station.streamURL);
    player.setAudioSource(AudioSource.uri(uri));
    notifyListeners();
  }
}
