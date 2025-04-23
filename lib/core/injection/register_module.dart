import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rick_and_morty/core/const/const.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  InternetConnection get connectionChecker => InternetConnection();

  @lazySingleton
  GraphQLClient get gqlClient =>
      GraphQLClient(cache: GraphQLCache(), link: HttpLink(Links.baseUrl));

  @preResolve
  @lazySingleton
  Future<Box> get openBox async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    return Hive.openBox<String>(hiveOpenBoxValue);
  }
}
