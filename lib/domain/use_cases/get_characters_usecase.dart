import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/core/error/error.dart';
import 'package:rick_and_morty/core/usecase/usecase.dart';
import 'package:rick_and_morty/domain/entities/entities.dart';
import 'package:rick_and_morty/domain/repositories/repositories.dart';

@lazySingleton
class GetCharactersUseCase extends UseCase<List<Character>, CharacterParams> {
  GetCharactersUseCase(this.repository);

  final IHomeRepository repository;

  @override
  Future<Either<Failure, List<Character>>> call(CharacterParams params) {
    return repository.getCharacters(params.page);
  }
}

class CharacterParams {
  CharacterParams(this.page);

  final int page;
}
