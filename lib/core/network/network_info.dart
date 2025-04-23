import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

@lazySingleton
class NetworkInfo {
  const NetworkInfo(this.connectionChecker);

  final InternetConnection connectionChecker;

  Future<bool> get isConnected => connectionChecker.hasInternetAccess;
}
