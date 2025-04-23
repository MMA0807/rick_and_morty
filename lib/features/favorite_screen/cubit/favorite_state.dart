part of 'favorite_cubit.dart';

enum FavoriteStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => FavoriteStatus.initial == this;

  bool get isLoading => FavoriteStatus.loading == this;

  bool get isSuccess => FavoriteStatus.success == this;

  bool get isFailure => FavoriteStatus.failure == this;
}

class FavoriteState extends Equatable {
  const FavoriteState({
    this.status = FavoriteStatus.initial,
    this.favorites = const [],
    this.filteredList = const [],
    this.selectedItems = const [false, false, false],
    this.showFilterBox = false,
    this.error,
  });

  final FavoriteStatus status;
  final List<Character> favorites;
  final List<Character> filteredList;
  final List<bool> selectedItems;
  final bool showFilterBox;
  final Exception? error;

  FavoriteState copyWith({
    FavoriteStatus? status,
    List<Character>? favorites,
    List<Character>? filteredList,
    List<bool>? selectedItems,
    bool? showFilterBox,
    Exception? error,
  }) => FavoriteState(
    status: status ?? this.status,
    favorites: favorites ?? this.favorites,
    filteredList: filteredList ?? this.filteredList,
    selectedItems: selectedItems ?? this.selectedItems,
    showFilterBox: showFilterBox ?? this.showFilterBox,
    error: error,
  );

  bool isFavorite(Character item) => favorites.contains(item);

  @override
  List<Object?> get props => [
    status,
    favorites,
    filteredList,
    showFilterBox,
    selectedItems,
  ];
}
