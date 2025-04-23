import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/error/error.dart';
import 'package:rick_and_morty/domain/entities/entities.dart';

abstract class IHomeRepository {
  Future<Either<Failure, List<Character>>> getCharacters(int page);

  Future<Either<Failure, List<Character>>> getFavoriteCharacters(int page);

  Future<Either<Failure, Unit>> cacheFavoriteCharacters(List<Character> models);

  Future<Either<Failure, List<Location>>> getLocations(int page);

  Future<Either<Failure, List<Episode>>> getEpisodes(int page);
}
