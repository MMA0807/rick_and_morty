import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/core/error/error.dart';
import 'package:rick_and_morty/core/usecase/usecase.dart';
import 'package:rick_and_morty/domain/entities/entities.dart';
import 'package:rick_and_morty/domain/repositories/repositories.dart';

@lazySingleton
class GetEpisodesUseCase extends UseCase<List<Episode>, EpisodeParams> {
  GetEpisodesUseCase(this.repository);

  final IHomeRepository repository;

  @override
  Future<Either<Failure, List<Episode>>> call(EpisodeParams params) {
    return repository.getEpisodes(params.page);
  }
}

class EpisodeParams {
  EpisodeParams(this.page);

  final int page;
}
