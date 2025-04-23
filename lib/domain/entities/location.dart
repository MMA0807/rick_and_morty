import 'package:equatable/equatable.dart';

class Location extends Equatable {
  const Location({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
  });

  final String id;
  final String name;
  final String type;
  final String dimension;

  @override
  List<Object?> get props => [id, name, type, dimension];
}
