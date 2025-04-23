part of 'home_cubit.dart';

enum HomeStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => HomeStatus.initial == this;

  bool get isLoading => HomeStatus.loading == this;

  bool get isSuccess => HomeStatus.success == this;

  bool get isFailure => HomeStatus.failure == this;
}

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

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.characterStatus = CharacterStatus.initial,
    this.currentIndex = 0,
    this.characters = const [],
    this.message = "",
  });

  final HomeStatus status;
  final CharacterStatus characterStatus;
  final int currentIndex;
  final List<Character> characters;
  final String? message;

  HomeState copyWith({
    HomeStatus? status,
    CharacterStatus? characterStatus,
    List<Character>? characters,
    int? currentIndex,
    String? message,
  }) => HomeState(
    status: status ?? this.status,
    characterStatus: characterStatus ?? this.characterStatus,
    currentIndex: currentIndex ?? this.currentIndex,
    characters: characters ?? this.characters,
    message: message ?? this.message,
  );

  @override
  List<Object?> get props => [
    status,
    characterStatus,
    characters,
    currentIndex,
    message,
  ];
}
