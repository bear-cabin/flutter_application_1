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
    player.icyMetadataStream.listen((icydata) {
      fetchArtworkUrl(icydata?.info?.title);
    });
  }

  fetchArtworkUrl(String? title) async {
    if (title == null) return;
    var urlStr = "https://itunes.apple.com/search?term=$title&entity=song";
    final response = await http.get(Uri.parse(urlStr));
    Map<String, dynamic> json = jsonDecode(response.body);
    List results = json['results'];
    if (results.first case {'artworkUrl60': String url60}) {
      // station?.artworkURL = url60.replaceFirst('60x60', '600X600');
      station?.artworkURL = url60;
      notifyListeners();
    }
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
    player.setAudioSource(
      AudioSource.uri(
        Uri.parse(station.streamURL),
        headers: {"Icy-MetaData": "1"},
      ),
    );
    notifyListeners();
  }
}
