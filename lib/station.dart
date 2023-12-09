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
}
