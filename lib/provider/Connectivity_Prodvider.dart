import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityProvider with ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  bool _isConnected = true;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  ConnectivityProvider() {
    _startMonitoring();
  }

  void _startMonitoring() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
       if (results.contains(ConnectivityResult.none)) {
      _isConnected = results.any((result) => result != ConnectivityResult.none);
   print("hors connexion ");
  // No available network types
      _isConnected = false;
}else{
      _isConnected = true;
   print(" connexion établie");

}
      notifyListeners();  // Notifie tous les listeners lorsque la connectivité change
    });
  }

  bool get isConnected => _isConnected;

  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }
}
