import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  const Episode({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
  });

  final String id;
  final String name;
  final String airDate;
  final String episode;

  @override
  List<Object?> get props => [id, name, airDate, episode];
}
