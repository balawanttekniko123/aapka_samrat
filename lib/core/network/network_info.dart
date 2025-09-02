import 'package:connectivity_plus/connectivity_plus.dart';

import '../storage/auth_token_provider.dart';

class NetworkInfo {
  Future<bool> get isConnected async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }
}


///test.dart ke liye
class MockNetworkInfo extends NetworkInfo {
  @override
  Future<bool> get isConnected async => true;
}

class MockAuthTokenProvider extends AuthTokenProvider {
  @override
  Future<String?> getToken() async => 'mock-token';

  @override
  Future<void> clearToken() async {}
}
