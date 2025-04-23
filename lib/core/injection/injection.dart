import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
configInjector(
  GetIt getIt, {
  String? env,
  EnvironmentFilter? environmentFilter,
}) {
  return getIt.init(environmentFilter: environmentFilter, environment: env);
}
