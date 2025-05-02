import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import 'package:rick_and_morty/data/models/models.dart';

const String cachedCharacters = 'CACHED_CHARACTERS';
const String cachedCharactersPage = 'CACHED_CHARACTERS_PAGE';
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

  Future<void> cacheCharactersPage(int page) {
    return _box.put(cachedCharactersPage, page.toString());
  }

  int getLastCharactersPage() =>
      _box.get(cachedCharactersPage) == null
          ? 0
          : int.tryParse(_box.get(cachedCharactersPage)) ?? 0;

  @override
  Future<void> cacheCharacters(List<CharacterModel> models, int page) async {
    if (checkCanCache(page)) {
      await cacheCharactersPage(page);

      final characters = [...getLastCharacters(page), ...models];

      return _box.put(
        cachedCharacters,
        json.encode(characters.map((e) => e.toJson()).toList()),
      );
    }
  }

  bool checkCanCache(int page) => page > getLastCharactersPage();

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
    if (checkCanCache(page)) return [];

    final modelsString = _box.get(cachedCharacters);
    if (modelsString == null) {
      throw CacheException();
    }
    return json
        .decode(modelsString)
        .map<CharacterModel>((e) => CharacterModel.fromJson(e))
        .toList();
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
