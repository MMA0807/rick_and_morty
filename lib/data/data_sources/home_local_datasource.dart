import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../models/character_model.dart';
import '../models/episode_model.dart';
import '../models/location_model.dart';

const String cachedCharacters = 'CACHED_CHARACTERS';
const String cachedFavoriteCharacters = 'CACHED_FAVORITE_CHARACTERS';
const String cachedEpisodes = 'CACHED_EPISODES';
const String cachedLocations = 'CACHED_LOCATIONS';

abstract class IHomeLocalDataSource {
  List<CharacterModel> getLastCharacters(int page);

  Future<void> cacheCharacters(List<CharacterModel> models, int page);

  List<CharacterModel> getLastFavoriteCharacters(int page);

  Future<void> cacheFavoriteCharacters(List<CharacterModel> models);

  List<LocationModel> getLastLocations(int page);

  Future<void> cacheLocations(List<LocationModel> models, int page);

  List<EpisodeModel> getLastEpisodes(int page);

  Future<void> cacheEpisodes(List<EpisodeModel> models, int page);
}

@LazySingleton(as: IHomeLocalDataSource)
class HomeLocalDataSource implements IHomeLocalDataSource {
  HomeLocalDataSource(this._box);

  final Box _box;
  final _pageLimit = 20;

  @override
  Future<void> cacheCharacters(List<CharacterModel> models, int page) {
    return _isFirstPage(page)
        ? _box.put(
          cachedCharacters,
          json.encode(models.map((e) => e.toJson()).toList()),
        )
        : Future.value();
  }

  @override
  Future<void> cacheFavoriteCharacters(List<CharacterModel> models) {
    return models.length < _pageLimit
        ? _box.put(
          cachedFavoriteCharacters,
          json.encode(models.map((e) => e.toJson()).toList()),
        )
        : Future.value();
  }

  @override
  Future<void> cacheEpisodes(List<EpisodeModel> models, int page) {
    return _isFirstPage(page)
        ? _box.put(
          cachedEpisodes,
          json.encode(models.map((e) => e.toJson()).toList()),
        )
        : Future.value();
  }

  @override
  Future<void> cacheLocations(List<LocationModel> models, int page) {
    return _isFirstPage(page)
        ? _box.put(
          cachedLocations,
          json.encode(models.map((e) => e.toJson()).toList()),
        )
        : Future.value();
  }

  @override
  List<CharacterModel> getLastCharacters(int page) {
    final modelsString = _box.get(cachedCharacters);
    if (modelsString == null) {
      throw CacheException();
    }
    return _isFirstPage(page)
        ? json
            .decode(modelsString)
            .map<CharacterModel>((e) => CharacterModel.fromJson(e))
            .toList()
        : [];
  }

  @override
  List<CharacterModel> getLastFavoriteCharacters(int page) {
    final modelsString = _box.get(cachedFavoriteCharacters);
    if (modelsString == null) {
      return [];
    }
    return _isFirstPage(page)
        ? json
            .decode(modelsString)
            .map<CharacterModel>((e) => CharacterModel.fromJson(e))
            .toList()
        : [];
  }

  @override
  List<EpisodeModel> getLastEpisodes(int page) {
    final modelsString = _box.get(cachedEpisodes);
    if (modelsString == null) {
      throw CacheException();
    }
    return _isFirstPage(page)
        ? json
            .decode(modelsString)
            .map<EpisodeModel>((e) => EpisodeModel.fromJson(e))
            .toList()
        : [];
  }

  @override
  List<LocationModel> getLastLocations(int page) {
    final modelsString = _box.get(cachedLocations);
    if (modelsString == null) {
      throw CacheException();
    }
    return _isFirstPage(page)
        ? json
            .decode(modelsString)
            .map<LocationModel>((e) => LocationModel.fromJson(e))
            .toList()
        : [];
  }

  bool _isFirstPage(int page) => page == 1;
}
