import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  NetworkInfo(this._connectivity);

  final Connectivity _connectivity;

  Future<bool> get isConnected async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return !connectivityResult.contains(ConnectivityResult.none);
  }

  /// A broadcast stream that emits `true` when online, `false` when offline.
  Stream<bool> get connectivityStream {
    return _connectivity.onConnectivityChanged.map(
      (List<ConnectivityResult> results) =>
          !results.contains(ConnectivityResult.none),
    );
  }
}
