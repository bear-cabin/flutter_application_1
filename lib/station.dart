import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'station.g.dart';

@JsonSerializable()
class Station {
  Station(this.name, this.streamURL, this.imageURL, this.desc, this.longDesc);
  String name;
  String streamURL;
  String imageURL;
  String desc;
  String longDesc;
  factory Station.fromJson(Map<String, dynamic> json) =>
      _$StationFromJson(json);
  Map<String, dynamic> toJson() => _$StationToJson(this);

  Widget imageWidget({double height = 68}) {
    if (imageURL.startsWith('http')) {
      return Image.network(imageURL);
    } else if (imageURL.endsWith('.png')) {
      return Image.asset('images/stations/$imageURL');
    } else if (imageURL.isNotEmpty) {
      return Image.asset(
        'images/stations/$imageURL.png',
      );
    } else {
      return SizedBox(
        width: height / 68 * 115.5,
        height: height,
      );
    }
  }

}
