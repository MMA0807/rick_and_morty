import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/core/error/exceptions.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/core/network/network_info.dart';
import 'package:rick_and_morty/data/data_sources/data_sources.dart';
import 'package:rick_and_morty/data/models/character_model.dart';
import 'package:rick_and_morty/domain/entities/entities.dart';
import 'package:rick_and_morty/domain/repositories/repositories.dart';

@LazySingleton(as: IHomeRepository)
class HomeRepository implements IHomeRepository {
  HomeRepository(
    this._networkInfo,
    this._remoteDataSource,
    this._localDataSource,
  );

  final IHomeLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;
  final IHomeRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<Character>>> getCharacters(int page) async {
    if (await _networkInfo.isConnected) {
      try {
        final models = await _remoteDataSource.getCharacters(page);
        final entities = models.map<Character>((e) => e.toEntity()).toList();
        await _localDataSource.cacheCharacters(models, page);
        return Right(entities);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final models = _localDataSource.getLastCharacters(page);
        final entities = models.map<Character>((e) => e.toEntity()).toList();
        return Right(entities);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Character>>> getFavoriteCharacters(
    int page,
  ) async {
    try {
      final models = _localDataSource.getLastFavoriteCharacters(page);
      final entities = models.map<Character>((e) => e.toEntity()).toList();
      return Right(entities);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> cacheFavoriteCharacters(
    List<Character> items,
  ) async {
    try {
      CharacterModel model = CharacterModel(
        id: '',
        name: '',
        vitalStatus: null,
        gender: null,
        type: '',
        species: '',
        image: '',
      );

      final models = items.map((e) => model.fromEntity(e)).toList();

      await _localDataSource.cacheFavoriteCharacters(models);

      return Right(unit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Episode>>> getEpisodes(int page) async {
    if (await _networkInfo.isConnected) {
      try {
        final models = await _remoteDataSource.getEpisodes(page);
        final entities = models.map<Episode>((e) => e.toEntity()).toList();
        await _localDataSource.cacheEpisodes(models, page);
        return Right(entities);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final models = _localDataSource.getLastEpisodes(page);
        final entities = models.map<Episode>((e) => e.toEntity()).toList();
        return Right(entities);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Location>>> getLocations(int page) async {
    if (await _networkInfo.isConnected) {
      try {
        final models = await _remoteDataSource.getLocations(page);
        final entities = models.map<Location>((e) => e.toEntity()).toList();
        await _localDataSource.cacheLocations(models, page);
        return Right(entities);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final models = _localDataSource.getLastLocations(page);
        final entities = models.map<Location>((e) => e.toEntity()).toList();
        return Right(entities);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
