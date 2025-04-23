import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/core/error/error.dart';
import 'package:rick_and_morty/core/injection/injection.dart';
import 'package:rick_and_morty/domain/entities/entities.dart';
import 'package:rick_and_morty/domain/use_cases/use_cases.dart';

part 'favorite_state.dart';

@injectable
class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteState());

  final _getFavoriteCharacters = getIt<GetFavoriteCharactersUseCase>();
  final _cacheFavoriteCharacters = getIt<CacheFavoriteCharactersUseCase>();

  void init() {
    _getFavorites();
  }

  Future<void> _getFavorites() async {
    emit(state.copyWith(status: FavoriteStatus.loading));
    final page = 1;
    final either = await _getFavoriteCharacters.call(CharacterParams(page));

    either.fold(
      (l) => emit(state.copyWith(error: _getFailureAndThrowException(l))),
      (r) => emit(state.copyWith(status: FavoriteStatus.success, favorites: r)),
    );
    debugPrint("ALL_FAV: ${state.favorites.length}");
  }

  Future<void> toggleFavorite(Character item) async {
    if (state.status.isSuccess) {
      if (state.isFavorite(item)) {
        removeFromFavorite(item);
      } else {
        addToFavorite(item);
      }
    }
  }

  Future<void> addToFavorite(Character item) async {
    if (state.status.isSuccess) {
      debugPrint("ADD EE");
      if (state.isFavorite(item)) return;

      final items = [...state.favorites, item];
      final either = await _cacheFavoriteCharacters.call(
        CacheFavoriteCharactersParams(items),
      );

      either.fold(
        (l) => emit(state.copyWith(error: _getFailureAndThrowException(l))),
        (r) => emit(state.copyWith(favorites: items)),
      );
    }
  }

  Future<void> removeFromFavorite(Character item) async {
    if (state.status.isSuccess && state.isFavorite(item)) {
      final items = [...state.favorites]..remove(item);
      final either = await _cacheFavoriteCharacters.call(
        CacheFavoriteCharactersParams(items),
      );

      either.fold(
        (l) => emit(state.copyWith(error: _getFailureAndThrowException(l))),
        (r) => emit(
          state.copyWith(status: FavoriteStatus.success, favorites: items),
        ),
      );
    }
  }

  Future<void> selectVitalStatus(int index, bool isSelected) async {
    if (state.status.isSuccess) {
      List<Character> filteredList = [];

      final selected = List.filled(state.selectedItems.length, false);

      selected[index] = isSelected;
      debugPrint("SELECTED: $selected");
      if (selected.every((e) => e == true) ||
          selected.every((e) => e == false)) {
        await _getFavorites();
        emit(state.copyWith(selectedItems: selected));
      } else if (selected.contains(true)) {
        await _getFavorites();
        filteredList =
            state.favorites
                .where((e) => index == e.vitalStatus?.index)
                .toList();

        emit(
          state.copyWith(selectedItems: selected, filteredList: filteredList),
        );
      }
    }
  }

  Future<void> addToFilteredFavorite(Character item) async {
    if (state.status.isSuccess) {
      if (state.isFavorite(item)) return;

      final items = [...state.favorites, item];
      emit(state.copyWith(favorites: items));
    }
  }

  Future<void> removeFromFilteredFavorite(Character item) async {
    if (state.status.isSuccess) {
      if (state.isFavorite(item)) return;

      final items = [...state.favorites, item]..remove(item);
      emit(state.copyWith(favorites: items));
    }
  }

  Future<void> removeAllFromFilteredFavorite() async {
    if (state.status.isSuccess) {
      emit(state.copyWith(favorites: []));
    }
  }

  void toggleOpenFilterBox() {
    emit(state.copyWith(showFilterBox: !state.showFilterBox));
  }

  Exception _getFailureAndThrowException(Failure l) {
    if (l is ServerFailure) {
      return ServerException();
    } else if (l is CacheFailure) {
      return CacheException();
    } else {
      return UnknownException();
    }
  }
}
