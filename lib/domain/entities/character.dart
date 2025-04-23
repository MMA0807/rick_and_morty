import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/core/types/types.dart';

class Character extends Equatable {
  const Character({
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
  final VitalStatus? vitalStatus;
  final Gender? gender;

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
