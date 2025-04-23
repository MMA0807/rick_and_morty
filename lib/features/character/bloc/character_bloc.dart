import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/core/error/error.dart';
import 'package:rick_and_morty/core/helper/pagination.dart';
import 'package:rick_and_morty/core/injection/injection.dart';
import 'package:rick_and_morty/domain/entities/entities.dart';
import 'package:rick_and_morty/domain/use_cases/get_characters_usecase.dart';
import 'package:stream_transform/stream_transform.dart';

part 'character_event.dart';

part 'character_state.dart';

const _throttleDuration = Duration(milliseconds: 100);

EventTransformer<CharacterEvent> _customTransformer(Duration duration) {
  return (events, mapper) {
    final nonDebounceStream = events
        .where(
          (event) => switch (event) {
            LoadMore() => false,
            Refreshed() => false,
          },
        )
        .asyncExpand(mapper);

    final debounceStream = events
        .where(
          (event) => switch (event) {
            LoadMore() => true,
            Refreshed() => true,
          },
        )
        .throttle(duration);

    return droppable<CharacterEvent>().call(
      nonDebounceStream.merge(debounceStream),
      mapper,
    );
  };
}

@injectable
class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  CharacterBloc() : super(CharacterState()) {
    on<CharacterEvent>(
      _onEvent,
      transformer: _customTransformer(_throttleDuration),
    );
  }

  final GetCharactersUseCase _getCharacter = getIt<GetCharactersUseCase>();

  Future<void> _onEvent(
    CharacterEvent event,
    Emitter<CharacterState> emit,
  ) async {
    await switch (event) {
      LoadMore() => _onLoadMore(event, emit),
      Refreshed() => _onRefreshed(event, emit),
    };
  }

  Future<void> _onRefreshed(
    Refreshed event,
    Emitter<CharacterState> emit,
  ) async {
    final either = await _getCharacter(CharacterParams(0));

    either.fold(
      (l) => emit(state.copyWith(error: _getFailureAndThrowException(l))),
      (r) => emit(
        state.copyWith(
          status: CharacterStatus.success,
          hasReachedMax: false,
          characters: r,
          page: 1,
        ),
      ),
    );
  }

  Future<void> _onLoadMore(LoadMore event, Emitter<CharacterState> emit) async {
    if (state.status.isSuccess && state.hasReachedMax) return;

    final page = state.page;
    final either = await _getCharacter(CharacterParams(page));

    either.fold(
      (l) => emit(state.copyWith(error: _getFailureAndThrowException(l))),
      (r) {
        if (r.isEmpty) {
          return emit(state.copyWith(hasReachedMax: true));
        }

        final newList = List<Character>.from(state.characters)..addAll(r);

        emit(
          state.copyWith(
            status: CharacterStatus.success,
            characters: newList,
            page: page + 1,
          ),
        );
      },
    );
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
