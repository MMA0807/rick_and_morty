// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) =>
    LocationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      dimension: json['dimension'] as String,
    );

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'dimension': instance.dimension,
    };
