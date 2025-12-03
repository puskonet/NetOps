// ✅ GANTI IMPORT LAMA DENGAN INI:
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  // ✅ Ganti 'InternetConnectionChecker' jadi 'InternetConnection'
  final InternetConnection connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected async {
    // ✅ Gunakan 'hasInternetAccess' (milik versi Plus) yang lebih stabil
    return await connectionChecker.hasInternetAccess;
  }
}
