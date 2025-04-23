import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/core/types/types.dart';
import 'package:rick_and_morty/domain/entities/entities.dart';

part 'character_model.g.dart';

@JsonSerializable()
class CharacterModel extends Equatable {
  const CharacterModel({
    required this.id,
    required this.name,
    required this.vitalStatus,
    required this.gender,
    required this.type,
    required this.species,
    required this.image,
  });

  final String id;
  final String name;
  final String type;
  final String species;
  final String image;

  @JsonKey(name: 'status')
  final VitalStatus? vitalStatus;
  final Gender? gender;

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterModelToJson(this);

  CharacterModel fromEntity(Character character) => CharacterModel(
    id: character.id,
    name: character.name,
    vitalStatus: character.vitalStatus,
    gender: character.gender,
    type: character.type,
    species: character.species,
    image: character.image,
  );

  Character toEntity() => Character(
    id: id,
    name: name,
    vitalStatus: vitalStatus,
    gender: gender,
    type: type,
    species: species,
    image: image,
  );

  @override
  List<Object?> get props => [
    id,
    name,
    type,
    species,
    image,
    vitalStatus,
    gender,
  ];
}
