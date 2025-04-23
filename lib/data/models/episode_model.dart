import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/domain/entities/episode.dart';

part 'episode_model.g.dart';

@JsonSerializable()
class EpisodeModel extends Equatable {
  const EpisodeModel({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
  });

  final String id;
  final String name;
  @JsonKey(name: 'air_date')
  final String airDate;
  final String episode;

  factory EpisodeModel.fromJson(Map<String, dynamic> json) =>
      _$EpisodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeModelToJson(this);

  factory EpisodeModel.fromEntity(Episode episode) => EpisodeModel(
    id: episode.id,
    name: episode.name,
    airDate: episode.airDate,
    episode: episode.episode,
  );

  Episode toEntity() =>
      Episode(id: id, name: name, airDate: airDate, episode: episode);

  @override
  List<Object?> get props => [id, name, airDate, episode];
}
