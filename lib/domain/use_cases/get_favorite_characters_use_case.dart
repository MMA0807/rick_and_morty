import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/core/error/error.dart';
import 'package:rick_and_morty/core/usecase/usecase.dart';
import 'package:rick_and_morty/domain/entities/entities.dart';
import 'package:rick_and_morty/domain/repositories/repositories.dart';

import 'get_characters_usecase.dart';

typedef _FavoriteUseCase = UseCase<List<Character>, CharacterParams>;

@lazySingleton
class GetFavoriteCharactersUseCase extends _FavoriteUseCase {
  GetFavoriteCharactersUseCase(this.repository);

  final IHomeRepository repository;

  @override
  Future<Either<Failure, List<Character>>> call(CharacterParams params) {
    return repository.getFavoriteCharacters(params.page);
  }
}
