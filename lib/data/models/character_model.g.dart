// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterModel _$CharacterModelFromJson(Map<String, dynamic> json) =>
    CharacterModel(
      id: json['id'] as String,
      name: json['name'] as String,
      vitalStatus: $enumDecodeNullable(_$VitalStatusEnumMap, json['status']),
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      type: json['type'] as String,
      species: json['species'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$CharacterModelToJson(CharacterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'species': instance.species,
      'image': instance.image,
      'status': _$VitalStatusEnumMap[instance.vitalStatus],
      'gender': _$GenderEnumMap[instance.gender],
    };

const _$VitalStatusEnumMap = {
  VitalStatus.alive: 'Alive',
  VitalStatus.dead: 'Dead',
  VitalStatus.unknown: 'unknown',
};

const _$GenderEnumMap = {
  Gender.female: 'Female',
  Gender.genderless: 'Genderless',
  Gender.male: 'Male',
  Gender.unknown: 'unknown',
};
