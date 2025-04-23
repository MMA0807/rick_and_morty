import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/core/error/error.dart';
import 'package:rick_and_morty/core/usecase/usecase.dart';
import 'package:rick_and_morty/domain/entities/entities.dart';
import 'package:rick_and_morty/domain/repositories/repositories.dart';

typedef _CacheFavoriteUseCase = UseCase<Unit, CacheFavoriteCharactersParams>;

@lazySingleton
class CacheFavoriteCharactersUseCase extends _CacheFavoriteUseCase {
  CacheFavoriteCharactersUseCase(this.repository);

  final IHomeRepository repository;

  @override
  Future<Either<Failure, Unit>> call(CacheFavoriteCharactersParams params) {
    return repository.cacheFavoriteCharacters(params.characters);
  }
}

class CacheFavoriteCharactersParams {
  CacheFavoriteCharactersParams(this.characters);

  final List<Character> characters;
}
