// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:graphql_flutter/graphql_flutter.dart' as _i128;
import 'package:hive/hive.dart' as _i979;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;
import 'package:rick_and_morty/core/injection/register_module.dart' as _i93;
import 'package:rick_and_morty/core/network/network_info.dart' as _i763;
import 'package:rick_and_morty/data/data_sources/data_sources.dart' as _i881;
import 'package:rick_and_morty/data/data_sources/home_local_datasource.dart'
    as _i475;
import 'package:rick_and_morty/data/data_sources/home_remote_datasource.dart'
    as _i659;
import 'package:rick_and_morty/data/repositories/home_repository.dart' as _i903;
import 'package:rick_and_morty/domain/repositories/repositories.dart' as _i268;
import 'package:rick_and_morty/domain/use_cases/cache_favorite_characters_use_case.dart'
    as _i1034;
import 'package:rick_and_morty/domain/use_cases/get_characters_usecase.dart'
    as _i968;
import 'package:rick_and_morty/domain/use_cases/get_episodes_use_case.dart'
    as _i664;
import 'package:rick_and_morty/domain/use_cases/get_favorite_characters_use_case.dart'
    as _i943;
import 'package:rick_and_morty/domain/use_cases/get_locations_use_case.dart'
    as _i509;
import 'package:rick_and_morty/features/character/bloc/character_bloc.dart'
    as _i399;
import 'package:rick_and_morty/features/favorite_screen/cubit/favorite_cubit.dart'
    as _i357;
import 'package:rick_and_morty/features/home/cubit/home_cubit.dart' as _i475;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i357.FavoriteCubit>(() => _i357.FavoriteCubit());
    gh.factory<_i475.HomeCubit>(() => _i475.HomeCubit());
    gh.factory<_i399.CharacterBloc>(() => _i399.CharacterBloc());
    gh.lazySingleton<_i161.InternetConnection>(
      () => registerModule.connectionChecker,
    );
    gh.lazySingleton<_i128.GraphQLClient>(() => registerModule.gqlClient);
    await gh.lazySingletonAsync<_i979.Box<dynamic>>(
      () => registerModule.openBox,
      preResolve: true,
    );
    gh.lazySingleton<_i475.IHomeLocalDataSource>(
      () => _i475.HomeLocalDataSource(gh<_i979.Box<dynamic>>()),
    );
    gh.lazySingleton<_i659.IHomeRemoteDataSource>(
      () => _i659.HomeRemoteDataSource(gh<_i128.GraphQLClient>()),
    );
    gh.lazySingleton<_i763.NetworkInfo>(
      () => _i763.NetworkInfo(gh<_i161.InternetConnection>()),
    );
    gh.lazySingleton<_i268.IHomeRepository>(
      () => _i903.HomeRepository(
        gh<_i763.NetworkInfo>(),
        gh<_i881.IHomeRemoteDataSource>(),
        gh<_i881.IHomeLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i1034.CacheFavoriteCharactersUseCase>(
      () => _i1034.CacheFavoriteCharactersUseCase(gh<_i268.IHomeRepository>()),
    );
    gh.lazySingleton<_i968.GetCharactersUseCase>(
      () => _i968.GetCharactersUseCase(gh<_i268.IHomeRepository>()),
    );
    gh.lazySingleton<_i509.GetLocationsUseCase>(
      () => _i509.GetLocationsUseCase(gh<_i268.IHomeRepository>()),
    );
    gh.lazySingleton<_i664.GetEpisodesUseCase>(
      () => _i664.GetEpisodesUseCase(gh<_i268.IHomeRepository>()),
    );
    gh.lazySingleton<_i943.GetFavoriteCharactersUseCase>(
      () => _i943.GetFavoriteCharactersUseCase(gh<_i268.IHomeRepository>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i93.RegisterModule {}
