import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/domain/entities/location.dart';

part 'location_model.g.dart';

@JsonSerializable()
class LocationModel extends Equatable {
  const LocationModel({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
  });

  final String id;
  final String name;
  final String type;
  final String dimension;

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);

  factory LocationModel.fromEntity(Location location) => LocationModel(
    id: location.id,
    name: location.name,
    type: location.type,
    dimension: location.dimension,
  );

  Location toEntity() =>
      Location(id: id, name: name, type: type, dimension: dimension);

  @override
  List<Object?> get props => [id, name, type, dimension];
}
