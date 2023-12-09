// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Station _$StationFromJson(Map<String, dynamic> json) => Station(
      json['name'] as String,
      json['streamURL'] as String,
      json['imageURL'] as String,
      json['desc'] as String,
      json['longDesc'] as String,
    );

Map<String, dynamic> _$StationToJson(Station instance) => <String, dynamic>{
      'name': instance.name,
      'streamURL': instance.streamURL,
      'imageURL': instance.imageURL,
      'desc': instance.desc,
      'longDesc': instance.longDesc,
    };
