import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/core/error/error.dart';
import 'package:rick_and_morty/core/usecase/usecase.dart';
import 'package:rick_and_morty/domain/entities/entities.dart';
import 'package:rick_and_morty/domain/repositories/repositories.dart';

@lazySingleton
class GetLocationsUseCase extends UseCase<List<Location>, LocationParams> {
  GetLocationsUseCase(this.repository);

  final IHomeRepository repository;

  @override
  Future<Either<Failure, List<Location>>> call(LocationParams params) {
    return repository.getLocations(params.page);
  }
}

class LocationParams {
  LocationParams(this.page);

  final int page;
}
