part of 'character_bloc.dart';

enum CharacterStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => CharacterStatus.initial == this;

  bool get isLoading => CharacterStatus.loading == this;

  bool get isSuccess => CharacterStatus.success == this;

  bool get isFailure => CharacterStatus.failure == this;
}

final class CharacterState extends Equatable {
  const CharacterState({
    this.status = CharacterStatus.initial,
    this.characters = const [],
    this.page = 1,
    this.hasReachedMax = false,
    this.error,
  });

  final CharacterStatus status;
  final List<Character> characters;
  final int page;
  final bool hasReachedMax;
  final Exception? error;

  CharacterState copyWith({
    CharacterStatus? status,
    Pagination<Character>? pagination,
    List<Character>? characters,
    int? page,
    bool? hasReachedMax,
    Exception? error,
  }) {
    return CharacterState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error,
    );
  }

  @override
  String toString() {
    return '''CharacterState { status: $status, hasReachedMax: $hasReachedMax, characters: ${characters.length} }''';
  }

  @override
  List<Object> get props => [
    status,
    characters,
    page,
    hasReachedMax,
  ];
}
